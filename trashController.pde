class TrashController extends Template implements OnObjectClass{
  Animation newAnimation;
  int trashType, flyTimeCount=0;
  boolean checkCollision;
  float vx=0,vy=0, g=0, flyTime=0, yStep;
  GameObject trashShadow;
  
  TrashController(int trashType){
   this.trashType=trashType; 
  }
  
  void setup(){
   trashShadow = parent.getParent().addObject(shadow,parent.getPos().x,parent.getPos().y+6,-0.5); 
  }
  
  void update(){
   if (checkCollision){
    if (parent.checkCollision(player)){
      ((PlayerController) player.script[0]).takeObject(parent);
      checkCollision=false;
    }
   }
   if (flyTime!=0 && (flyTimeCount)/FPS<flyTime){
     parent.move(vx/FPS,yStep/FPS);
     flyTimeCount++;
     trashShadow.move(vx/FPS, yStep/FPS);  
   }
  }
  
  void onClick(){
   checkCollision=parent.checkClick(mX,mY);
  }
  
  void fly(){
    vx=random(1,4)*50;
    vy=random(-7,-3)*50;
    flyTime=1f;
    g=9.81*50;
    yStep = vy*(flyTime)+(1/2f)*g*pow(flyTime,2);
    float[] flyDeviation = new float[int(FPS*flyTime)+1];
    flyDeviation[0] = vy/FPS;
    for (int i=1;i<flyDeviation.length;i++){
      vy+=g/FPS;
      flyDeviation[i]=flyDeviation[i-1]+(vy/FPS-yStep/FPS);
    }
    flyDeviation[flyDeviation.length-1] = 0;
    parent.playAnimation(parent.createAnimation().setYDeviation(flyDeviation));
  }
  
  void removeShadow(){
    trashShadow.remove();
  }
}
