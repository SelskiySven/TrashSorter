class ComputerController extends Template implements OnObjectClass{
  Boolean checkCollision=false;
  void onClick(){
   checkCollision=parent.checkClick(mX,mY);
  }
  void update(){
   if (checkCollision && parent.checkCollision(player)) {
     sc3.load();
     ((PlayerController) player.script[0]).stop();
     checkCollision=false;
   }
  }
}