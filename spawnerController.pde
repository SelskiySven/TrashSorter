class SpawnerController extends Template implements OnObjectClass{
  int countForSpawn, gameEndShootCount=0, score=0;
  Animation shoot, sensorControl;
  boolean flyObjects=false, waitingForSpawn=false;
  SharedInt objectCount=new SharedInt(0);
  
  void setup(){
   shoot=spawner.createAnimation().setGrid(6,1).setPosLen(0,0,6).setFrameTime(1/6f);
   sensorControl = sensor.createAnimation().setGrid(7,1);
   sensor.addAnimation(sensorControl.setPosLen(0,0,1).addConditions(new Condition(objectCount,0)));
   sensor.addAnimation(sensorControl.setPosLen(1,0,1).addConditions(new Condition(objectCount,1)));
   sensor.addAnimation(sensorControl.setPosLen(2,0,1).addConditions(new Condition(objectCount,2)));
   sensor.addAnimation(sensorControl.setPosLen(3,0,1).addConditions(new Condition(objectCount,3)));
   sensor.addAnimation(sensorControl.setPosLen(4,0,1).addConditions(new Condition(objectCount,4)));
   sensor.addAnimation(sensorControl.setPosLen(5,0,1).addConditions(new Condition(objectCount,5)));
   sensor.addAnimation(sensorControl.setPosLen(5,0,2).setFrameTime(0.5f).addConditions(new Condition(objectCount,6,8)));
   addObject();
  }
  
  void update(){
    if (objectCount.get()>7 && !gameEnded) {
      gameEnd();
      setDelay(this::showGameEndScreen,3);
    }
  }
  
  void spawn(){
    if(objectCount.get()>0 && spawnedObject==null && !waitingForSpawn || gameEnded){
     setDelay(shootSound::play,0.1);
     waitingForSpawn=true;
     parent.playAnimation(shoot);
     setDelay(this::spawnObject,0.5);
     objectCount.set(objectCount.get()-1);
    }
  }
  
  void spawnObject(){
      waitingForSpawn=false;
      int trashType=int(random(3)), trashSprite = int(random(3));
      spawnedObject=parent.getParent().addObject(trash[trashType][trashSprite],parent.getPos().x+36, parent.getPos().y-1,0).addClass(new TrashController(trashType));
      if (flyObjects) {
        spawnedObject.layer = 2;
       ((TrashController)spawnedObject.script[0]).fly(); 
      } 
  }
  void gameEnd(){
    gameEnded=true;
    flyObjects=true;
    if(gameEndShootCount<5){
      spawn();
      setDelay(this::gameEnd,1);
      gameEndShootCount++;
    }
  }
  
  void showGameEndScreen(){
    new Prefab(800,800,null).createObject(400,800,2).setTextFont(createFont("fonts/cavestory.ttf",80)).setTextSize(1).setTextColor(color(168,255,168)).setTextAlign(CENTER,CENTER).setText("Your Score: "+score+"\n").setTextLeading(200).addClass(new GameEndScreenController());
  }
  
  void addScore(){score+=10; }
  
  void addObject(){
    if (!gameEnded){
      if (sceneController.scene()==parent.getParent()){
        objectCount.set(objectCount.get()+1);
        spawn();
      }
      setDelay(this::addObject, 3);
    }
  }
}
