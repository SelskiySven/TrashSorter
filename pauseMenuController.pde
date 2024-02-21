class PauseMenuController extends Template implements OnObjectClass{
 void keyPressed(){
  if (keyCode==27){
   if (parent.isShown()) {
     parent.hide();
     gameIsRunning=true;
     volume.hide();
   }else {
     parent.show();
     gameIsRunning=false;
     volume.show();
   }
  }
 }
}