class MuteController extends Template implements OnObjectClass{
  SharedInt mutedInt = new SharedInt(0);
  Condition muted = new Condition(mutedInt,1);
 void setup(){
  parent.addAnimation(parent.createAnimation().setGrid(2,1).setPosLen(0,0,1).addConditions(muted.not()));
  parent.addAnimation(parent.createAnimation().setGrid(2,1).setPosLen(1,0,1).addConditions(muted));
 }
 void onClick(){
  if (parent.checkClick(mX,mY)){
   if (muted.check()){
    mutedInt.set(0); 
    soundController.globalUnMute();
   } else {
    mutedInt.set(1); 
    soundController.globalMute();
   }
  }
 }
}