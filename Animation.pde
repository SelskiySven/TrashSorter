class Animation {
 PVector _grid = new PVector(1,1), _size;
 int _row, _col, _frames=1;
 float _frameTime=1f/FPS;
 PImage _texture;
 Condition[] _condition = new Condition[maxConditionOnAnimation];
 int _conditionCount=0;
 float[] _xDeviation = new float[1], _yDeviation = new float[1];
 float _resize = 1;
 
 Animation(float gridX, float gridY, float sizeX, float sizeY, int row, int column, int frames, float frameTime, PImage texture, Condition[] condition, int conditionCount, float[] xDeviation, float[] yDeviation, float resize){
   _grid = new PVector(gridX,gridY);
   _size = new PVector(sizeX,sizeY);
   _row=row;
   _col=column;
   _frames=frames;
   _frameTime=frameTime;
   _texture=texture;
   _condition=condition;
   _conditionCount=conditionCount;
   _xDeviation=xDeviation;
   _yDeviation=yDeviation;
   _resize = resize;
 }
 
 Animation(PImage texture, float resize){
   _resize = resize;
   _texture=texture;
   _size = new PVector(texture.width,texture.height);
 }
 
 Animation setGrid(int columns, int rows){
  return new Animation(columns, rows, _texture.width/columns, _texture.height/rows, _row, _col, _frames, _frameTime, _texture, _condition, _conditionCount, _xDeviation, _yDeviation, _resize);
 }
 
 Animation setXDeviation(float... xDeviation){
   return new Animation(_grid.x, _grid.y, _size.x, _size.y, _row, _col, _frames, _frameTime, _texture, _condition, _conditionCount, xDeviation, _yDeviation, _resize);
 }
 
 Animation setYDeviation(float... yDeviation){
   return new Animation(_grid.x, _grid.y, _size.x, _size.y, _row, _col, _frames, _frameTime, _texture, _condition, _conditionCount, _xDeviation, yDeviation, _resize);
 }
 Animation setFrameTime(float frameTime){
   return new Animation(_grid.x, _grid.y, _size.x, _size.y, _row, _col, _frames, frameTime, _texture, _condition, _conditionCount, _xDeviation, _yDeviation, _resize);
 }
 Animation setPosLen(int col,int row, int frames){
   return new Animation(_grid.x, _grid.y, _size.x, _size.y, row, col, frames, _frameTime, _texture, _condition, _conditionCount, _xDeviation, _yDeviation, _resize);
 }
 Animation addConditions(Condition... condition){
   Condition[] conditions = new Condition[5];
   int cc=0;
   for (int i=0;i<condition.length;i++){
    conditions[cc]=condition[i];
    cc++;
   }
   return new Animation(_grid.x, _grid.y, _size.x, _size.y, _row, _col, _frames, _frameTime, _texture, conditions, cc, _xDeviation, _yDeviation, _resize);
 }
 
 void _draw(float x, float y, int frame){
   frame=int(frame/(FPS*_frameTime));
   pushMatrix();
   translate(x+_xDeviation[frame%_xDeviation.length],y+_yDeviation[frame%_yDeviation.length]);
   beginShape();
   texture(_texture);
   vertex(-_size.x/2*_resize,-_size.y*_resize,(_col+frame%_frames)/(_grid.x),_row/(_grid.y));
   vertex(_size.x/2*_resize,-_size.y*_resize,(_col+frame%_frames+1)/(_grid.x),_row/(_grid.y));
   vertex(_size.x/2*_resize,0,(_col+frame%_frames+1)/(_grid.x),(_row+1)/(_grid.y));
   vertex(-_size.x/2*_resize,0,(_col+frame%_frames)/(_grid.x),(_row+1)/(_grid.y));
   endShape(CLOSE); 
   popMatrix();
 }
 
 boolean _checkConditions(){
  boolean result=true;
  for (int i=0;i<_conditionCount;i++) {
    result=result && _condition[i].check();
  }
  return result;
 }
 
 boolean _isFramePlaying(int frame){
  return (frame%(FPS*_frameTime)!=0);
 }
 
 boolean _isAnimationPlaying(int frame){
  float currentFrame=(float)frame/FPS/_frameTime;
  return (currentFrame%_frames!=0 || currentFrame%_xDeviation.length!=0 || currentFrame%_yDeviation.length!=0 || frame==0);
 }
}
