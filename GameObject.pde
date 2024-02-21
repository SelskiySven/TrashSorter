 class GameObject{
 PVector _pos, _size;
 Texture _texture;
 boolean _remove=false, _ignorePause, _updateOutsideCamera, _relativePosition = true, _hidden=false, _isCommon=false;
 int _scriptCount, _textSize, _alignX, _alignY, _leading;
 double layer;
 OnObjectClass[] script = new OnObjectClass[maxClassesOnObject];
 Scene _parent;
 String text = new String();
 PFont _font = createFont("Calibri", 18);
 color _textColor = color(0);
 
 GameObject(float x, float y, double z, Prefab prefab, Scene parent){
   _pos=new PVector(x,y);
   _size=prefab._size.copy();
   _texture=prefab._texture._copy();
   layer=z;
   _scriptCount=prefab._scriptCount;
   for (int i=0;i<_scriptCount;i++) {
     script[i]=prefab.script[i];
     script[i]._init(this);
     if(!loader._isEverythingLoaded())setDelay(script[i]::setup,0);
     else script[i].setup();
   }
   _textSize=prefab._textSize;
   _alignX=prefab._alignX;
   _alignY=prefab._alignY;
   _leading=prefab._leading;
   _ignorePause=prefab._ignorePause;
   _font=prefab._font;
   text=prefab.text;
   _updateOutsideCamera=prefab._updateOutsideCamera;
  _parent = parent;
 }
 
 Scene getParent(){
  return _parent; 
 }
 
 GameObject makeCommon(){sceneController._addCommonObject(this); _isCommon=true; return this;}
 GameObject hide(){_hidden=true; return this;}
 GameObject show(){_hidden=false; return this;}
 boolean isShown() {return !_hidden;}
 
 PVector getPos(){
   if (_relativePosition) return _pos.copy();
   else return _pos.copy().add(_parent._cam.pos.copy());
 }
 
 PVector getAbsolutePos(){
  return new PVector(getPos().x-_parent._cam.pos.x,getPos().y-_parent._cam.pos.y);
 }
 
 PVector getCorner(float x, float y){
  return new PVector(getPos().x-getSize().x/2+getSize().x*x, getPos().y-getSize().y+getSize().y*y) ;
 }
 
 PVector getClosestPoint(PVector vec){
   float closestX = constrain(vec.x,getPos().x-getSize().x/2,getPos().x+getSize().x/2);
   float closestY = constrain(vec.y,getPos().y-getSize().y,getPos().y);
   return new PVector(closestX,closestY);
 }
 
 PVector getSize(){ return _size.copy();}
 
 boolean checkClick(PVector vec){ return checkClick(vec.x,vec.y);}
 
 boolean checkClick(float x, float y){
  return (x<=getPos().x+_size.x/2 && x>=getPos().x-_size.x/2 && y<=getPos().y && y>=getPos().y-_size.y);
 }
 
 boolean checkCollision(GameObject obj){
   return (
   getPos().x+_size.x/2>=obj.getPos().x-obj._size.x/2 && 
   getPos().y>=obj.getPos().y-obj._size.y && 
   obj.getPos().x+obj._size.x/2>=getPos().x-_size.x/2 && 
   obj.getPos().y>=getPos().y-_size.y);
 }
 
 void _draw(){
   _texture._draw(getAbsolutePos().x, getAbsolutePos().y, gameIsRunning||_ignorePause, sceneController.scene()._cam.objectInCamera(this));
   _printText();
   if (debugEnabled){
     fill(0,255,0);
     circle(getAbsolutePos().x,getAbsolutePos().y,5);
     stroke(255,0,0);
     fill(0,0,0,0);
     rect(getAbsolutePos().x-_size.x/2,getAbsolutePos().y-_size.y,_size.x,_size.y);
     noStroke();
   }
 }
 
 void _printText(){
   fill(_textColor);
   textFont(_font);
   textSize(_textSize);
   textAlign(_alignX, _alignY);
   textLeading(_leading);
   text(text, getAbsolutePos().x-_size.x/2, getAbsolutePos().y-_size.y, _size.x,_size.y); 
 }
 
 GameObject addClass(OnObjectClass script){
  this.script[_scriptCount]=script;
  this.script[_scriptCount]._init(this);
  if(!loader._isEverythingLoaded())setDelay(this.script[_scriptCount]::setup,0);
  else this.script[_scriptCount].setup();
  _scriptCount++;
  return this;
 }
 
 void moveToScene(Scene scene){
  remove(false);
  _parent=scene;
  _parent.addObject(this);
 }
 
 Animation createAnimation(){ return _texture._createAnimation();}
 
 void addAnimation(Animation anim){_texture._addAnimation(anim);}
 
 void remove(){this.remove(true);}
 void remove(boolean full){
   _remove=true;
   _parent._remove();
   if (full) {
     sceneController._remove();
     _isCommon=false;
   }
   _remove=false;
 }
 
 void resetFrame(){_texture._breakAnimation();}
 
 void playAnimation(Animation anim){_texture._forcedAnimation(anim);}
 
 GameObject ignorePause(boolean pausable){_ignorePause=pausable;return this;}
 
 GameObject setTextSize(int size){_textSize=size;return this;}
 
 GameObject setTextAlign(int alignX){_alignX=alignX;return this;}
 
 GameObject setTextAlign(int alignX, int alignY){_alignX=alignX;_alignY=alignY;return this;}
 
 GameObject setTextFont(PFont font){_font=font;return this;}
 
 GameObject setText(String text){this.text=text;return this;}
 
 GameObject setTextColor(color textColor){_textColor=textColor;return this;}
 
 GameObject setTextLeading(int leading){_leading=leading;return this;}
 
 GameObject updateOutsideCamera(boolean update){_updateOutsideCamera=update;return this;}
 
 GameObject relativePosition(boolean position){_relativePosition=position;return this;}
 
 GameObject resizeTexture(float newSize){_texture._resize(newSize); return this;}
 
 void move(float x, float y){_pos.add(x,y);}
 
 void setPos(float x, float y){_pos.set(x,y);}
 
 void move(PVector vec){_pos.add(vec);}
 
 void setPos(PVector vec){_pos.set(vec);}
}