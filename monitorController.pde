class MonitorController extends Template implements OnObjectClass{
  void onClick(){
   if(!parent.checkClick(mX,mY)) sc2.load();
  }
}