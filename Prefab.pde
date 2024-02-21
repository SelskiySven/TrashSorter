class Prefab{
  PVector _size;
  Texture _texture;
  OnObjectClass[] script = new OnObjectClass[5];
  int _scriptCount, _textSize=18, _alignX=LEFT, _alignY=TOP, _leading=20;
  String text = new String();
  PFont _font = createFont("Calibri", 18);
  boolean _ignorePause, _updateOutsideCamera=false, _relativePosition=true;
   color _textColor = color(0);
  
   Prefab(int x, int y, PImage file, OnObjectClass... script) {
    _size = new PVector(x, y);
    this.script = new OnObjectClass[script.length];
    if (file != null) _texture = new Texture(file);
    else _texture = new Texture(createImage(1, 1, ARGB));
    _scriptCount = script.length;
    for (int i = 0; i < _scriptCount; i++) this.script[i] = script[i];
  }

  Prefab(int x, int y, color textureColor, OnObjectClass... script) {
    PImage img = createImage(x, y, ARGB);
    img.loadPixels();
    for (int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = textureColor;
    }
    img.updatePixels();
    _texture = new Texture(img);
    _size = new PVector(x, y);
    this.script = new OnObjectClass[script.length];
    _scriptCount = script.length;
    for (int i = 0; i < _scriptCount; i++) this.script[i] = script[i];
  }
  
  
Animation createAnimation(){
   return _texture._createAnimation();
 }
 
 void addAnimation(Animation anim){
  _texture._addAnimation(anim); 
 }
 
 GameObject createObject(float x, float y, double z){
   return sceneController.scene().addObject(this,x,y,z);
 }
 
 Prefab ignorePause(boolean pausable){_ignorePause=pausable;return this;}
 
 Prefab setTextSize(int size){_textSize=size;return this;}
 
 Prefab setTextAlign(int alignX){_alignX=alignX;return this;}  
 
 Prefab setTextAlign(int alignX, int alignY){_alignX=alignX;_alignY=alignY;return this;}
 
 Prefab setTextFont(PFont font){_font=font;return this;}
 
 Prefab setText(String text){this.text=text;return this;}
 
 Prefab setTextColor(color textColor){_textColor=textColor;return this;}
 
 Prefab setTextLeading(int leading){_leading=leading;return this;}
 
 Prefab updateOutsideCamera(boolean update){_updateOutsideCamera=update;return this;}
 
 Prefab relativePosition(boolean position){_relativePosition=position;return this;}
 
 Prefab resizeTexture(float newSize){_texture._resize(newSize); return this;}
}
