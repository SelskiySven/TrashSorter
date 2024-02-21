class LoaderCheck{
  
  int _totalResources=0, _loadedResources=0;
  
  void _addLoading(){_totalResources++;}
  void _addLoaded(){_loadedResources++;}
  boolean _isEverythingLoaded(){
    if (_loadedResources>=_totalResources){
      _loadedResources=_totalResources;
      return true;
    } else return false;
  }
  float loadPercent(){return (float)_loadedResources/_totalResources;}
  
}