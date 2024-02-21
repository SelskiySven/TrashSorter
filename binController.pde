class BinController extends Template implements OnObjectClass{
  int trashType;
  boolean checkCollision=false;
  
  BinController(int _trashType){
   trashType=_trashType; 
  }
  
  void update(){
   if (checkCollision && parent.checkCollision(player)){
    ((PlayerController) player.script[0]).dropObject(trashType);
      checkCollision=false;
   }
  }
  
  void onClick(){
    checkCollision=parent.checkClick(mX,mY);
  }
}
