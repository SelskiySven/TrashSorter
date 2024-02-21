class MusicController extends Template implements OnObjectClass{
  Delay musicDelay;
  Sound currentMusic;
  
  void setup(){
    playRandomMusic();
  }
  
  void playRandomMusic(){
      int i = (int)random(0,3);
      currentMusic = music[i];
      currentMusic.play();
      musicDelay=setDelay(this::playRandomMusic,music[i].getLength(),true);
  }
  
  void breakMusic(){
    currentMusic.stop();
    musicDelay.remove();
  }
}