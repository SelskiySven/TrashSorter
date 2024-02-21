class SoundController{
 Sound[] _sounds = new Sound[maxLoadedSounds]; 
 int _soundCount=0;
 boolean _globalMute = false;
 
 void removeAll(){
 for (int i=0;i<_soundCount;i++){
   _sounds[i].stop(); 
  }
  _soundCount=0;
 }
 
 void _add(Sound snd){
 _sounds[_soundCount]=snd;
 if (_globalMute) snd._isMuted = true;
 _soundCount++;
 }
 
 void globalMute(){
  for (int i=0;i<_soundCount;i++){
   _sounds[i].mute(); 
  }
 }
 void globalUnMute(){
  for (int i=0;i<_soundCount;i++){
   _sounds[i].unmute(); 
  }
 }
 
 boolean isEverythingLoaded(){
  for (int i=0;i<_soundCount;i++){
   if (_sounds[i]._player==null) return false;
  }
  return true;
 }
 
 int getRealTotal(){
   int count=0;
   for (int i=0;i<_soundCount;i++){
     if (!_sounds[i]._async) count++;
   }
   return count;
 }
 int getRealLoaded(){
  int count=0;
  for (int i=0;i<_soundCount;i++){
   if (_sounds[i]._player!=null && !_sounds[i]._async) count++;
  }
  return count;
 }
 
}
