class RoomController extends Template implements OnObjectClass{
  Prefab floor;
  GameObject[] roomArea;
  Line[][][] intresection;
  
  //void update(){
  //  stroke(0,255,0);
  //  for (int i=0;i<intresection.length;i++){
  //    for (int j=i;j<intresection[i].length;j++){
  //      if (intresection[i][j]!=null){
  //     for (int k=0;k<intresection[i][j].length;k++){
  //        line(intresection[i][j][k].p1.x,intresection[i][j][k].p1.y,intresection[i][j][k].p2.x,intresection[i][j][k].p2.y);
  //        textSize(12);
  //        fill(0,0,255);
  //        text(Integer.toString(i)+" "+Integer.toString(j),intresection[i][j][k].p1.x,intresection[i][j][k].p1.y);
  //     }
  //      }
  //    }
  //  }
  //  noStroke();
  //  fill(0,0,255);
  //  PVector vec=findPoint(new PVector(mX,mY));
  //  circle(vec.x,vec.y,10);
  //}
  
  
  RoomController(int sizeX, int sizeY, int posX, int posY, int... more){
    roomArea=new GameObject[more.length/4+1];
    floor=new Prefab(sizeX,sizeY, null);
    roomArea[0]=floor.createObject(posX,posY,0);
    for (int i=0;i<more.length;i+=4){
      floor=new Prefab(more[i],more[i+1], null);
      roomArea[i/4+1]=floor.createObject(more[i+2],more[i+3],0);
    }
    intresection = new Line[roomArea.length][roomArea.length][];
    for (int i=0;i<roomArea.length;i++){
     for (int j=i;j<roomArea.length;j++){
      intresection[i][j]=createLine(roomArea[i],roomArea[j]);
      intresection[j][i]=intresection[i][j];
     }
    }
  }
  
  //void addArea(int sizeX, int sizeY, int posX, int posY){
  //  floor=new Prefab(sizeX,sizeY, null);
  //  GameObject[] newRoomArea=new GameObject[roomArea.length+1];
  //  for (int i=0;i<roomArea.length;i++) newRoomArea[i]=roomArea[i];
  //  newRoomArea[roomArea.length]=floor.createObject(posX,posY,0);
  //  roomArea=newRoomArea;
  //  intresection = new Line[roomArea.length][roomArea.length][];
  //  for (int i=0;i<intresection.length;i++){
  //   for (int j=i;j<intresection.length;j++){
  //    intresection[i][j]=createLine(roomArea[i],roomArea[j]);
  //    intresection[j][i]=intresection[i][j];
  //   }
  //  }
  //}
  
  //PVector startPos, endPos;
  
  //void keyPressed(){
  // if (keyCode==80) startPos = new PVector(mX,mY);
  // if (keyCode==76){
  //  for (int i=0;i<roomArea.length;i++){
  //   print((int)roomArea[i].getSize().x+","+(int)roomArea[i].getSize().y+","+(int)roomArea[i].getPos().x+","+(int)roomArea[i].getPos().y+","); 
  //  }
  // }
  //}
  //void keyReleased(){
  // if (keyCode==80) {
  //   endPos = new PVector(mX,mY);
  //   PVector size = endPos.copy().sub(startPos);
  //   PVector pos=startPos.copy().add(size.x/2,size.y);
  //   addArea(abs((int)size.x),abs((int)size.y),(int)pos.x,(int)pos.y);
  // }
  //}
  
  
  void onClick(){
   if (parent.checkClick(mX, mY)) ((PlayerController) player.script[0]).move(findWay(findPoint(player.getPos()),findPoint(new PVector(mX,mY+60)))); 
  }
  
  PVector[] findWay(PVector initialPoint, PVector finalPoint){
    int[] startArea = new int[roomArea.length];
    int[] finalArea = new int[roomArea.length];
    for (int i=0;i<roomArea.length;i++){
      if (roomArea[i].checkClick(initialPoint.x,initialPoint.y)) startArea[i]=1;
    }
    for (int i=0;i<roomArea.length;i++){
      if (roomArea[i].checkClick(finalPoint.x,finalPoint.y)) finalArea[i]=1;
    }
    int[][][] allWays = new int[100][][];
    int waysCount=0;
    int singleWaysCount=0;
    for (int i=0;i<startArea.length;i++){
     if (startArea[i]==1)allWays[waysCount]=findPossibleWays(new int[]{i},finalArea,new int[roomArea.length]);
     if (allWays[waysCount]!=null) waysCount++;
    }
    for (int i=0;i<waysCount;i++) singleWaysCount+=allWays[i].length;
    int[][] ways = new int[singleWaysCount][];
    singleWaysCount=0;
    for (int i=0;i<waysCount;i++){
     for (int j=0;j<allWays[i].length;j++){
       ways[singleWaysCount]=allWays[i][j];
       singleWaysCount++;
     }
    }
    float minWayLength=Float.MAX_VALUE;
    PVector[] minWay = null;
    for (int i=0;i<ways.length;i++){
     PVector[] currentWay=findCurrentWay(initialPoint,finalPoint,ways[i]);
     float currentWayLength=0;
     for (int j=0;j<currentWay.length-1;j++) currentWayLength+=PVector.dist(currentWay[j],currentWay[j+1]);
     if (currentWayLength<minWayLength){
      minWay=currentWay;
      minWayLength=currentWayLength;
     }
    }
    if (minWay==null) return null;
    PVector[] finalWay = new PVector[minWay.length-2];
    for (int i=2;i<minWay.length;i++) finalWay[i-2]=minWay[i];
    return finalWay;
  }
  
  PVector[] findCurrentWay(PVector initialPoint, PVector finalPoint, int[] points){
    Line currentLine=new Line(initialPoint, finalPoint);
    PVector[] way={initialPoint,finalPoint};
    for (int i=0;i<points.length-1;i++){
     if (!currentLine.isIntresectedWithAnyOfThis(intresection[points[i]][points[i+1]])){
       PVector intermediatePoint = currentLine.findClosestPoint(intresection[points[i]][points[i+1]]);
       int[] pointsBefore = subset(points,0,i+1);
       currentLine=new Line(intermediatePoint,finalPoint);
       way = findCurrentWay(initialPoint,intermediatePoint,pointsBefore);
     }
    }
    PVector[] finalWay=new PVector[way.length+1];
    for (int i=0;i<way.length;i++)finalWay[i]=way[i]; 
    finalWay[way.length]=finalPoint;
    return finalWay;
  }
  
  int[][] findPossibleWays(int[] way, int[] end, int[] visited){
    int currentRoom = way[way.length-1];
    int[] copyVisited = new int[visited.length];
    for (int i=0;i<visited.length;i++) copyVisited[i]=visited[i];
    copyVisited[currentRoom]=1;
    if (end[currentRoom]==1) return new int[][] {way};
    int[][][] ways = new int[100][][];
    int wayCount=0;
    for (int i=0;i<roomArea.length;i++){
       if (intresection[currentRoom][i]!=null && visited[i]!=1){
         int[] currentWay=new int[way.length+1];
         for (int j=0;j<way.length;j++) currentWay[j]=way[j];
         currentWay[currentWay.length-1]=i;
         ways[wayCount]=findPossibleWays(currentWay, end, copyVisited);
         if (ways[wayCount]!=null) wayCount++;
       }
    }
    if (ways[0]==null) return new int[0][];
    else{
     int singleWayCount=0;
     for (int i=0;i<wayCount;i++) singleWayCount+=ways[i].length;
     int[][] newWays = new int[singleWayCount][];
     singleWayCount=0;
     for (int i=0;i<wayCount;i++){
      for (int j=0;j<ways[i].length;j++){
       newWays[singleWayCount]=ways[i][j];
       singleWayCount++;
      }
     }
     return newWays;
    }
  }
  
  PVector findPoint(PVector vec){
    if (isInRoom(vec)) return vec;
    float minDistance = Float.MAX_VALUE;
    PVector closestPoint = null;
    for (int i=0;i<roomArea.length;i++){
      PVector currentPoint = roomArea[i].getClosestPoint(vec);
      float distance = PVector.dist(vec,currentPoint);
      if (distance<minDistance) {
        closestPoint = currentPoint;
        minDistance = distance;
      }
    }
    return closestPoint;
  }
  
  Boolean isInRoom(PVector vec){
   for (int i=0;i<roomArea.length;i++){
     if (roomArea[i].checkClick(vec.x,vec.y)) return true;
   }
   return false;
  }
}