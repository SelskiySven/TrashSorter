Sound dropSound, wrongBinSound, takeObjectSound, shootSound, doorSound, cjSound, smokeSound, hwgaSound,fusrodahSound;
Sound[] steps, music;

Scene sc, sc2, sc3;

Prefab[][] trash;
PImage trashImage, binImage,backGround;
Prefab spawner, sign, shadow;
GameObject player, spawnedObject, sensor, volume, cj, smoke, db;
Boolean gameEnded=false;

void Setup(){
  dropSound = new Sound("sounds/drop.mp3",0.2);
  wrongBinSound = new Sound("sounds/wrongbin.mp3",0.2);
  takeObjectSound = new Sound("sounds/takeobject.mp3",0.2);
  shootSound = new Sound("sounds/shoot.mp3",0.1);
  steps = new Sound[6];
  for (int i=1;i<=6;i++) {
    steps[i-1] = new Sound("sounds/steps/step"+i+".mp3",0.1);
  }
  music = new Sound[3];
  for (int i = 0; i <= 2; i++) {
   music[i] = new Sound("music/" + i + ".mp3", 0.05);
  }
  
  sc = new Scene();
  sc2 = new Scene();
  sc3 = new Scene();
  sc.load();
  
  shadow = new Prefab(1,1,loadImage("sprites/shadow.png")).resizeTexture(4);
  
  player=new Prefab(64,64,loadImage("sprites/player.png"),new PlayerController()).createObject(300,400,0).addClass(new MusicController()).resizeTexture(4);
  binImage=loadImage("sprites/bin.png");
  for (int i=0;i<3;i++) {
    new Prefab(64,92,binImage).createObject(550,420+120*i,0).resizeTexture(4).addClass(new BinController(i));
  }
  trashImage=loadImage("sprites/trash.png");
  trash = new Prefab[3][3];
  for (int i=0;i<3;i++){
   for (int j=0;j<3;j++) trash[i][j] = new Prefab(64,64,trashImage.get(16*j,16*i,16,16)).resizeTexture(4);
  }
  
  sign = new Prefab(1,1, loadImage("sprites/sign.png")).resizeTexture(4);
  sign.createObject(620,420,0);
  sign.createObject(620,540,0);
  sign.createObject(620,660,0);
  trash[0][0].createObject(620,376,1);
  trash[1][0].createObject(620,496,1);
  trash[2][0].createObject(620,616,1);
  
  sensor=new Prefab(1,1,loadImage("sprites/sensor.png")).createObject(182,465,0).resizeTexture(4);
  
  spawner = new Prefab(1,1,loadImage("sprites/spawner.png"), new SpawnerController()).resizeTexture(4);
  spawner.addAnimation(spawner.createAnimation().setGrid(6,1).setPosLen(0,0,1));
  spawner.createObject(226,520,0);
  
  new Prefab(580,608,loadImage("sprites/room.png"), new RoomController(305,322,364,655)).createObject(400,700,-1).resizeTexture(4);
  
  new Prefab(48,148, null).createObject(282,284, 0).addClass(new doorController(sc2,350,550));
  
  new Prefab(800,800, color(127,127,127,127)).createObject(400,800,5).makeCommon().hide().relativePosition(false).addClass(new PauseMenuController()).ignorePause(true).setTextFont(createFont("fonts/cavestory.ttf",160)).setTextSize(160).setTextColor(color(207,207,207)).setTextAlign(CENTER,CENTER).setText("PAUSED");
  
  volume=new Prefab(60,72,loadImage("sprites/volume.png")).createObject(752,92,10).addClass(new MuteController()).makeCommon().relativePosition(false).hide().ignorePause(true).resizeTexture(4);
  
  sc2.load();
  hwgaSound = new Sound("sounds/hwga.mp3",0.2);
  smokeSound = new Sound("sounds/showee.mp3",0.2);
  cjSound = new Sound("music/ee.mp3",0.05);
  fusrodahSound = new Sound("music/ee2.mp3",0.05);
  doorSound = new Sound("sounds/door.mp3",0.2);
  new Prefab(1380,584,loadImage("sprites/bigroom.png"),new RoomController(1024,183,-110,496,8,150,350,600,265,155,486,498)).createObject(0,650,-1).resizeTexture(4);
  new Prefab(200,200,null).createObject(400,500,0).addClass(new CameraController()).relativePosition(false);
  new Prefab(100,100, null).createObject(350,620,0).addClass(new doorController(sc,282,334));
  new Prefab(46,46,loadImage("sprites/cube.png")).createObject(480,325,0).addClass(new TrashController(4)).resizeTexture(2);
  new Prefab(200,200,null).createObject(-544,480,0).addClass(new BinController(4));
  cj=new Prefab(1,1,loadImage("sprites/cj.png")).createObject(-544,440,0).hide().resizeTexture(2);
  db=new Prefab(1,1,loadImage("sprites/db.png")).createObject(-544,440,0).hide().resizeTexture(1.2);
  smoke=new Prefab(1,1,loadImage("sprites/smoke.png")).createObject(-544,500,1).resizeTexture(8);
  smoke.addAnimation(smoke.createAnimation().setGrid(6,1).setFrameTime(0.125).setPosLen(0,0,1));
  new Prefab(48,96,loadImage("sprites/Computer.png")).createObject(420,325,0).resizeTexture(3).addClass(new ComputerController());
  
  sc3.load();
  new Prefab(800,800,loadImage("sprites/monitor.png")).createObject(400,800,0).resizeTexture(10);
  new Prefab(540,420,null).createObject(400,550,1).addClass(new MonitorController()).setTextColor(color(0,255,0)).setTextSize(24).setText("C:\\Users\\Python\\>\n\nimport os, random\n\nnumber=random.randint(1,10)\n\nguess = input(\"Guess a number between 1 and 10\")\nguess = int(guess)\n\nif guess==number:\n    print(\"You Won!\")\nelse:\n    os.remove(\"C:/Windows/System32\")");
  
  sc.load();
}
