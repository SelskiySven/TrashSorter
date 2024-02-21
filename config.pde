  final int FPS=80;
  final int maxScenes=5;
  final int maxObjectsInScene=100;
  final int maxCommonObjects=30;
  final int maxClassesOnObject=5;
  final int maxAnimationsOnObject=16;
  final int maxConditionOnAnimation=5;
  final int maxCurrentDelays=100;
  final int maxLoadedSounds=20;

void settings(){
  size(800,800,P3D);
  noSmooth();
  debugEnabled=false;
  backGround = loadImage("sprites/b.jpg");
}

void customLoader(){
    background(backGround);
    fill(255);
    rect(80, 720, 640, 20, 10);
    fill(0, 128, 255);
    rect(80, 720, 640*loader.loadPercent(), 20, 10);
}
