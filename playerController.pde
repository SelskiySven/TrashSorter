class PlayerController extends Template implements OnObjectClass{
  float playerSpeed=240;
  int currentPoint=0;
  PVector moveTo, stepMove;
  PVector[] movePoints=new PVector[0];
  SharedInt dir, playerIsMovingInt, playerIsCarryingObjectInt;
  Condition playerIsMoving, playerGoesUp, playerGoesDown, playerGoesLeft, playerGoesRight, playerIsCarryingObject;
  GameObject takenObject, playerShadow;
  Delay stepsDelay;
  Boolean stepsSoundArePlaying=false;
  float[][] objectDeviation = {
  {-96,-88,-88,-92,-96,-88,-88,-92},
  {-96,-88,-88,-92,-96,-88,-88,-92},
  {-96,-92,-88,-92,-96,-92,-88,-92},
  {-96,-92,-88,-92,-96,-92,-88,-92}};
  
  void setup(){
    
    playerSpeed/=FPS;
  
    dir = new SharedInt(0);
    playerIsMovingInt = new SharedInt(0);
    playerIsCarryingObjectInt = new SharedInt(0);
    
    playerIsMoving = new Condition(playerIsMovingInt, 1);
    playerIsCarryingObject = new Condition(playerIsCarryingObjectInt,1);
    
    playerGoesLeft = new Condition(dir, 0);
    playerGoesRight = new Condition(dir, 1);
    playerGoesUp = new Condition(dir, 2);
    playerGoesDown = new Condition(dir, 3);
   
    Animation playerA = parent.createAnimation().setGrid(16,4).setFrameTime(0.125f);
    Animation playerAS = parent.createAnimation().setGrid(16,4);
   
    parent.addAnimation(playerA.setPosLen(0,0,8).addConditions(playerGoesLeft, playerIsMoving, playerIsCarryingObject.not()));
    parent.addAnimation(playerA.setPosLen(0,1,8).addConditions(playerGoesRight, playerIsMoving, playerIsCarryingObject.not()));
    parent.addAnimation(playerA.setPosLen(0,2,8).addConditions(playerGoesUp, playerIsMoving, playerIsCarryingObject.not()));
    parent.addAnimation(playerA.setPosLen(0,3,8).addConditions(playerGoesDown, playerIsMoving, playerIsCarryingObject.not()));
    
    parent.addAnimation(playerAS.setPosLen(0,0,1).addConditions(playerGoesLeft, playerIsMoving.not(), playerIsCarryingObject.not()));
    parent.addAnimation(playerAS.setPosLen(0,1,1).addConditions(playerGoesRight, playerIsMoving.not(), playerIsCarryingObject.not()));
    parent.addAnimation(playerAS.setPosLen(0,2,1).addConditions(playerGoesUp, playerIsMoving.not(), playerIsCarryingObject.not()));
    parent.addAnimation(playerAS.setPosLen(0,3,1).addConditions(playerGoesDown, playerIsMoving.not(), playerIsCarryingObject.not()));
    
    parent.addAnimation(playerAS.setPosLen(8,0,1).addConditions(playerGoesLeft, playerIsMoving.not(), playerIsCarryingObject));
    parent.addAnimation(playerAS.setPosLen(8,1,1).addConditions(playerGoesRight, playerIsMoving.not(), playerIsCarryingObject));
    parent.addAnimation(playerAS.setPosLen(8,2,1).addConditions(playerGoesUp, playerIsMoving.not(), playerIsCarryingObject));
    parent.addAnimation(playerAS.setPosLen(8,3,1).addConditions(playerGoesDown, playerIsMoving.not(), playerIsCarryingObject));
    
    parent.addAnimation(playerA.setPosLen(8,0,8).addConditions(playerGoesLeft, playerIsMoving, playerIsCarryingObject));
    parent.addAnimation(playerA.setPosLen(8,1,8).addConditions(playerGoesRight, playerIsMoving, playerIsCarryingObject));
    parent.addAnimation(playerA.setPosLen(8,2,8).addConditions(playerGoesUp, playerIsMoving, playerIsCarryingObject));
    parent.addAnimation(playerA.setPosLen(8,3,8).addConditions(playerGoesDown, playerIsMoving, playerIsCarryingObject));
    
    moveTo = new PVector(parent.getPos().x,parent.getPos().y);
    
    playerShadow = shadow.createObject(parent.getPos().x,parent.getPos().y,-0.5);
    
    playStepSound();
  }
  
  void stop(){
    moveTo.set(parent.getPos());
    playerIsMovingInt.set(0);
    movePoints = new PVector[0];
    stepSound(false);
  }
  
  void update(){
    stepMove=moveTo.copy().sub(parent.getPos()).setMag(playerSpeed);
    if (parent.getPos().dist(moveTo)>playerSpeed)parent.move(stepMove);
    else if(currentPoint+1<movePoints.length){
      parent.setPos(moveTo.copy());
      currentPoint++;
      moveTo.set(movePoints[currentPoint].x,movePoints[currentPoint].y);
      changeDirection();
    }
    else {
      parent.setPos(moveTo.copy());
      playerIsMovingInt.set(0);
      stepSound(false);
    }
    if (takenObject!=null) takenObject.setPos(parent.getPos().x,parent.getPos().y+1);
    playerShadow.setPos(parent.getPos().x, parent.getPos().y+10);
  }
  
  
  void move(PVector[] movePoints){
   if(!gameEnded && movePoints!=null){
     currentPoint=0;
     this.movePoints=movePoints;
     moveTo.set(movePoints[currentPoint].x,movePoints[currentPoint].y);
     changeDirection();
     playerIsMovingInt.set(1);
     stepSound(true);
   }
  }
  
  void changeDirection(){
    PVector relativeDir = moveTo.copy();
     relativeDir.sub(player.getPos());
     float angle=degrees(moveTo.copy().sub(player.getPos()).heading()+PI);
     if (angle<=240 && angle>=120) dir.set(0);
     else if (angle<300 && angle>240) dir.set(2);
     else if (angle<120 && angle>60) dir.set(3);
     else dir.set(1);
  }
  
  void takeObject(GameObject obj){
   if (takenObject==null  && !gameEnded) {
     ((TrashController) obj.script[0]).removeShadow();
     takeObjectSound.play();
     takenObject=obj;
     stop();
     playerIsCarryingObjectInt.set(1);
     parent.resetFrame();
     
     Animation ObjectA = takenObject.createAnimation().setFrameTime(0.125f).setPosLen(0,0,1);
     Animation ObjectAS = takenObject.createAnimation().setPosLen(0,0,1);
     
     obj.addAnimation(ObjectA.setYDeviation(objectDeviation[0]).addConditions(playerGoesLeft, playerIsMoving));
     obj.addAnimation(ObjectA.setYDeviation(objectDeviation[1]).addConditions(playerGoesRight, playerIsMoving));
     obj.addAnimation(ObjectA.setYDeviation(objectDeviation[2]).addConditions(playerGoesUp, playerIsMoving));
     obj.addAnimation(ObjectA.setYDeviation(objectDeviation[3]).addConditions(playerGoesDown, playerIsMoving));
     
     obj.addAnimation(ObjectAS.setYDeviation(new float[]{-96}).addConditions(playerGoesLeft, playerIsMoving.not()));
     obj.addAnimation(ObjectAS.setYDeviation(new float[]{-96}).addConditions(playerGoesRight, playerIsMoving.not()));
     obj.addAnimation(ObjectAS.setYDeviation(new float[]{-96}).addConditions(playerGoesUp, playerIsMoving.not()));
     obj.addAnimation(ObjectAS.setYDeviation(new float[]{-96}).addConditions(playerGoesDown, playerIsMoving.not()));
     takenObject.setPos(parent.getPos().x,parent.getPos().y+1);
     if (spawnedObject==obj) {
       spawnedObject=null;
       ((SpawnerController) spawner.script[0]).spawn();
     }
   }
  }
  
  void dropObject(int binId){
    if(binId!=4){
     stop();
    }
   if (takenObject!=null && !gameEnded){
     if (((TrashController) takenObject.script[0]).trashType==binId){
       takenObject.remove();
       parent.resetFrame();
       playerIsCarryingObjectInt.set(0);
       if (((TrashController) takenObject.script[0]).trashType==4){
        stop();
        ((MusicController)player.script[1]).breakMusic();
        int r=int(random(2));
        switch (r){
         case 0: 
          setDelay(cj::show,0.1);
          setDelay(hwgaSound::play,smokeSound.getLength()/2);
          setDelay(cjSound::play,smokeSound.getLength()+hwgaSound.getLength()/2-smokeSound.getLength()/2);
          setDelay(((MusicController)player.script[1])::playRandomMusic,cjSound.getLength());
          break;
         case 1:
           setDelay(db::show,0.1);
          fusrodahSound.play();
          setDelay(((MusicController)player.script[1])::playRandomMusic,fusrodahSound.getLength());
          break;
        }
        smokeSound.play();
        smoke.playAnimation(smoke.createAnimation().setGrid(6,1).setFrameTime(0.1).setPosLen(1,0,5)); 
       } else {
         dropSound.play();
         ((SpawnerController) spawner.script[0]).addScore();
       }
       takenObject=null;
     } else wrongBinSound.play();
   }
  }
  
  void playStepSound(){
   if(stepsSoundArePlaying){
     steps[int(random(0,6))].play();
     stepsDelay=setDelay(this::playStepSound,0.4);
   }
  }

  void stepSound(boolean s){
   if(!stepsSoundArePlaying && s) {
     stepsSoundArePlaying=s;
     if (stepsDelay!=null)stepsDelay.remove();
     stepsDelay=setDelay(this::playStepSound,0.2);
   }else{
     stepsSoundArePlaying=s; 
   }
  }
}
