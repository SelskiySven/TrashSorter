class DelayController{
  Delay[] _delay = new Delay[maxCurrentDelays]; 
  int _delayCount = 0;
  
  void _add(Delay delay) {
    _delay[_delayCount] = delay;
    _delayCount++;
  }
  
  void _remove() {
    for (int i=0;i<_delayCount;i++) {
      if (_delay[i]._remove) {
        _delayCount--;
        _delay[i] = _delay[_delayCount]; 
        break;
      }
    }
  }
  
  void _update() {
    for (int i = 0;i < _delayCount;i++) {
      _delay[i]._update();
    } 
  }
}

Delay setDelay(Runnable function, double delay){
 return new Delay(function, delay); 
}
Delay setDelay(Runnable function, double delay, boolean ignorePause){
 return new Delay(function, delay, ignorePause); 
}
