  import beads.*;

class Sound{

 AudioContext _ac = AudioContext.getDefaultContext();
 SamplePlayer _player=null;
 Sample _sample;
 Gain _gain;
 float _volume;
 String _filePath;
 boolean  _isMuted = false, _async;
 
 Sound(String file, float volume){
   this(file,volume,true);
 }
 
 Sound(String file, float volume, boolean waitForTheEnd){
   _async=!waitForTheEnd;
   if (waitForTheEnd) loader._addLoading();
   soundController._add(this);
   new Thread(() -> {
    _gain=new Gain(1,volume);
    _volume=volume;
    _filePath=sketchPath("data/"+file).replace('\\','/');
    _sample=SampleManager.sample(_filePath);
    _player = new SamplePlayer(_sample);
    if (waitForTheEnd) loader._addLoaded();
    _gain.addInput(_player);
   }).start();
   _ac.start();
 }
 
 void play(){
   if(!_ac.isRunning()) _ac.start();
     if (_isMuted) _gain=new Gain(2,0);
     else _gain=new Gain(2,_volume);
     _player = new SamplePlayer(SampleManager.sample(_filePath));
     _gain.addInput(_player);
     _ac.out.addInput(_gain);
 }
 
 void setVolume(float volume){_gain.setGain(volume);_volume=volume;}
 void stop(){_player.kill();}
 void mute(){_gain.setGain(0); _isMuted=true;}
 void unmute(){_gain.setGain(_volume); _isMuted=false;}
 
 double getLength(){
  return _sample.getLength()/1000; 
 }
}