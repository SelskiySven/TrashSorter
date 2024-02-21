  class Scene{
    GameObject[] _object = new GameObject[maxObjectsInScene];
    int _objectCount=0;
    Camera _cam = new Camera();
    
    Scene(){
     sceneController._addScene(this); 
    }
    
    void _remove(){
      for (int i=0;i<_objectCount;i++){
       if (_object[i]._remove){
         _objectCount--;
         _object[i]=_object[_objectCount];
         break;
       }
      }
    }
    
    void _onClick(){
     for (int i=0;i<_objectCount;i++) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].onClick(); 
      }
     }
    }
    void _onPress(){
     for (int i=0;i<_objectCount;i++) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].onPress(); 
      }
     }
    }
    void _onRelease(){
     for (int i=0;i<_objectCount;i++) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].onRelease(); 
      }
     }
    }
    void _onDrag(){
     for (int i=0;i<_objectCount;i++) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].onDrag(); 
      }
     }
    }
    void _onMove(){
     for (int i=0;i<_objectCount;i++) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].onMove(); 
      }
     }
    }
    void _onScroll(MouseEvent e){
     for (int i=0;i<_objectCount;i++) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].onScroll(e); 
      }
     }
    }
    void _keyPressed(){
     for (int i=0;i<_objectCount;i++) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].keyPressed(); 
      }
     }
    }
    void _keyReleased(){
     for (int i=0;i<_objectCount;i++) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].keyReleased(); 
      }
     }
    }
    
    void _update(){
     _draw();
     for (int i=_objectCount-1;i>=0;i--) {
      for (int j=0;j<_object[i]._scriptCount;j++){
       if ((gameIsRunning || _object[i]._ignorePause) && (_object[i]._updateOutsideCamera || _cam.objectInCamera(_object[i]))) _object[i].script[j].update(); 
      }
     }
    }
    
    void _draw(){
     double[] posY = new double[_objectCount];
     for (int i=0;i<_objectCount;i++) posY[i]=_object[i].getPos().y+_object[i].layer*height;
     for (int i=0;i<_objectCount;i++){
        int minIndex=_getMinIndex(posY);
         if(_object[minIndex].isShown())_object[minIndex]._draw();
         posY[minIndex]=Integer.MAX_VALUE;
      }
    }
    
    int _getMinIndex(double[] arr){
     int minIndex=0;
     double minValue=Double.MAX_VALUE;
      for (int i=0;i<arr.length;i++){
       if (arr[i]<minValue){
        minIndex=i;
        minValue=arr[i];
       }
     }
     return minIndex;
    }
    
    void load(){sceneController._loadScene(this);}
    void cameraSetPos(float x, float y){_cam._setPos(x,y);}
    void cameraMove(float x, float y){_cam._move(x,y);}
    void cameraSetPos(PVector vec){cameraSetPos(vec.x,vec.y);}
    void cameraMove(PVector vec){cameraMove(vec.x,vec.y);}
    
    GameObject addObject(Prefab prefab, float x, float y, double z){
      GameObject newObject = new GameObject(x,y,z,prefab, this);
      _object[_objectCount]=newObject;
      _objectCount++;
      return newObject;
    }
    
    void addObject(GameObject object){
      _object[_objectCount]=object;
      _objectCount++;
    }
    
    void clear(){_objectCount=0;}
  }