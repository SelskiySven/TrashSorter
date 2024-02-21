class doorController extends Template implements OnObjectClass{
  Scene loadScene;
  int playerPosX, playerPosY;
  Boolean checkCollision=false;
  doorController(Scene _loadScene, int _playerPosX, int _playerPosY){
    loadScene=_loadScene;
    playerPosX=_playerPosX;
    playerPosY=_playerPosY;
  }

  void update(){
   if (checkCollision && parent.checkCollision(player) && ((PlayerController) player.script[0]).takenObject==null && !gameEnded){
      loadScene.load();
      player.setPos(playerPosX,playerPosY);
      player.moveToScene(loadScene);
      ((PlayerController) player.script[0]).playerShadow.remove();
      ((PlayerController) player.script[0]).playerShadow = shadow.createObject(parent.getPos().x,parent.getPos().y,-0.5);
      ((PlayerController) player.script[0]).stop();
      checkCollision=false;
      doorSound.play();
   }
  }
  
  void onClick(){
   checkCollision=parent.checkClick(mX,mY);
  }
}