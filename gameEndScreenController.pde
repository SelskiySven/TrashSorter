class GameEndScreenController extends Template implements OnObjectClass{
 float font=1;
 String clc = new String("Click here to restart...");
 int count;
  void update(){
    if(font<80){
      font+=0.5;
      parent.setTextSize((int)font);
    } 
    if (font==80) {
      setDelay(this::addLetter,0.5);
      font++;
    }
   }
   
   void addLetter(){
     parent.text+=clc.charAt(count);
     count++;
     if (count<clc.length()) setDelay(this::addLetter,0.2);
   }
   
   void onClick(){
    if (font>80){
     soundController.removeAll();
     gameEnded=false;
     sceneController.clear();
     spawnedObject=null;
     sc.clear();
     sc2.clear();
     Setup();
    }
   }
}
