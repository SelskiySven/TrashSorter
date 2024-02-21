class Texture{
 PImage _texture = new PImage();
 boolean _animated, _forcedPlaying;
 Animation[] _animation = new Animation[maxAnimationsOnObject];
 int _animationCount, _frame, _lastAnimation, _forcedAnimationTimes=0;
 Animation _forcedAnimation;
 float _resize=1;
 
 Texture(PImage file, boolean animated, Animation[] animation, int animationCount, float resize){
  _texture=file;
  _animated=animated;
  _animation=animation;
  _animationCount=animationCount;
  _resize = resize;
 }
 
 Texture(PImage file){
  _texture = file;
 }
 
 void _draw(float x, float y, boolean updateFrame, boolean objectInCamera){
  if (_forcedPlaying){
      _forcedAnimation._draw(x,y,_frame); 
      if (!_forcedAnimation._isAnimationPlaying(_frame+1)){
        _forcedAnimationTimes--;
        if (_forcedAnimationTimes==0){
         _frame=0; 
         _forcedPlaying=false;
        }
      }
    if (updateFrame)_frame++;
    } else if (_animated){
      for (int i=0; i<_animationCount; i++){
        if (_animation[i]._checkConditions()) {
          if (!(_lastAnimation!=i && _animation[_lastAnimation]._isFramePlaying(_frame))){
            _lastAnimation=i;
          }
          if(objectInCamera)_animation[_lastAnimation]._draw(x,y,_frame);
          break;
        }
      }
      if (updateFrame)_frame++;
    if (_frame>Integer.MAX_VALUE-1000 || (!_animation[_lastAnimation]._isAnimationPlaying(_frame) && !_forcedPlaying)) _frame=0;
  } else{
    image(_texture, x-_texture.width*_resize/2, y-_texture.height*_resize,_texture.width*_resize,_texture.height*_resize);
  }
 }
 
 Animation _createAnimation(){
   return new Animation(_texture, _resize);
 }
 
 void _resize(float newSize){
   _resize=newSize;
   for (int i=0;i<_animationCount;i++){
    _animation[i]._resize=newSize; 
   }
 }
 
 void _addAnimation(Animation anim){
   _animated=true;
   _animation[_animationCount] = anim;
   _animationCount++;
 }
 
 void _breakAnimation(){_frame=0;}
 
 void _forcedAnimation(Animation anim){_forcedAnimation(anim,1);}
 
 void _forcedAnimation  (Animation anim, int count){
  _forcedAnimation=anim; //<>//
  _forcedPlaying=true;
  _frame=0;
  _forcedAnimationTimes=count;
 }
 
 Texture _copy(){
  return new Texture(_texture, _animated, _animation, _animationCount, _resize);
 }
}