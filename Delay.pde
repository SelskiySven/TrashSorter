class Delay{
  int _counter;
  double _delay;
  Runnable _function;
  boolean _remove = false, _ignorePause;
  
  Delay(Runnable function, double delay) {
    this(function,delay,false);
  }
  
  Delay(Runnable function, double delay, boolean ignorePause) {
    _function = function;
    _delay = delay;
    _ignorePause=ignorePause;
    _delayController._add(this);
  }
  
  void _update() {
    if (gameIsRunning || _ignorePause)_counter++;
    if ((float)_counter / FPS >=  _delay) {
      _function.run(); 
      _remove = true;
      _delayController._remove();
    }
  }
  
  void remove(){
    _remove = true;
    _delayController._remove();
  }
}