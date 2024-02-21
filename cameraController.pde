class CameraController extends Template implements OnObjectClass{
  void update(){
   if (!parent.checkClick(player.getCorner(0.5,0.5)) && parent.getParent()==sceneController.scene()) sceneController.scene().cameraMove(player.getCorner(0.5,0.5).sub(parent.getClosestPoint(player.getCorner(0.5,0.5))));
  }
}
