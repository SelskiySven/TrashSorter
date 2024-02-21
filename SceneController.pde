class SceneController{
 Scene _selectedScene;
 Scene[] _scenes = new Scene[maxScenes];
 GameObject[] _commonObjects = new GameObject[maxCommonObjects];
 int _commonObjectCount=0;
 int _scenesCount=0;
 
 void _addCommonObject(GameObject obj){
  _commonObjects[_commonObjectCount]=obj;
  _commonObjectCount++;
 }
 
 void _loadScene(Scene sc){
  _selectedScene=sc;
  for (int i=0;i<_commonObjectCount;i++) {
    _commonObjects[i].moveToScene(sc);
  }
 }
 
 void _remove(){
   for (int i=0;i<_commonObjectCount;i++){
       if (_commonObjects[i]._remove){
         _commonObjectCount--;
         _commonObjects[i]=_commonObjects[_commonObjectCount];
         break;
       }
    }
 }
 
 void _update(){_selectedScene._update();}
 void clear(){_commonObjectCount=0;_scenesCount=0;}
 void _onClick(){_selectedScene._onClick();}
 void _onPress(){_selectedScene._onPress();}
 void _onRelease(){_selectedScene._onRelease();}
 void _onDrag(){_selectedScene._onDrag();}
 void _onMove(){_selectedScene._onMove();}
 void _onScroll(MouseEvent e){_selectedScene._onScroll(e);}
 void _keyPressed(){_selectedScene._keyPressed();}
 void _keyReleased(){_selectedScene._keyReleased();}
 
 void _addScene(Scene sc){
   _scenes[_scenesCount]=sc;
   _scenesCount++;
 }
 
 Scene scene(){
  return _selectedScene; 
 }
}

class Camera{
 PVector pos = new PVector();
 
 boolean objectInCamera(GameObject obj){
   return (
   pos.x+width>=obj.getPos().x-obj._size.x/2 && 
   pos.y+height>=obj.getPos().y-obj._size.y && 
   obj.getPos().x+obj._size.x/2>=pos.x && 
   obj.getPos().y>=pos.y);
 }
 
 void _setPos(float x, float y){pos.set(x,y);}
 
 void _move(float x, float y){pos.add(x,y);}
}
