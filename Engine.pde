float mX,mY;
SceneController sceneController;
boolean debugEnabled, gameIsRunning=true;
DelayController _delayController;
LoaderCheck loader;
SoundController soundController;
void setup(){
  textureMode(NORMAL);
  blendMode(BLEND);
  noStroke();
  ((PGraphicsOpenGL)g).textureSampling(2);
  hint(DISABLE_OPENGL_ERRORS);
  frameRate(FPS);
  sceneController = new SceneController();
  _delayController = new DelayController();
  loader = new LoaderCheck();
  soundController = new SoundController();
  Setup();
}

void draw(){
  if (loader._isEverythingLoaded()){
    background(0);
    _delayController._update();
    sceneController._update();
    mX=mouseX+sceneController.scene()._cam.pos.x;
    mY=mouseY+sceneController.scene()._cam.pos.y;
  } else {
    //println(loader._loadedResources,loader._totalResources,soundController.getRealLoaded(),soundController.getRealTotal());
    if (frameCount/FPS==5){
     loader._loadedResources=soundController.getRealLoaded(); 
     loader._totalResources=soundController.getRealTotal();
    }
    customLoader();
  }
}
 
 void mouseClicked(){
  sceneController._onClick();
  if (debugEnabled) println("Clicked to ("+mX+", "+mY+")");
 }
 
 void mousePressed(){
   sceneController._onPress();
 }
 
 void mouseReleased(){
   sceneController._onRelease();
 }
 
 void mouseDragged(){
   sceneController._onDrag();
 }
 
 void mouseMoved(){
   sceneController._onMove();
 }  
 
 void mouseWheel(MouseEvent event){
   sceneController._onScroll(event);
 }
 
 void keyPressed(){
   sceneController._keyPressed();
   if (debugEnabled) println("Key pressed, keycode:"+keyCode);
   if(keyCode == ESC) key = 0;
 }
 
 void keyReleased(){
   sceneController._keyReleased();
 }
 
 
