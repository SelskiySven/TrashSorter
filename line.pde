class Line{
 PVector p1,p2;
 
 Line(float x1, float y1, float x2, float y2){
  p1 = new PVector(x1,y1);
  p2 = new PVector(x2,y2);
 }
  Line (PVector a, PVector b){
  p1 = new PVector(a.x,a.y);
  p2 = new PVector(b.x,b.y);
 }
 
 boolean isParralelWith(Line line){
   if (p1.x!=p2.x && line.p1.x!=line.p2.x){
     float m1=(p2.y-p1.y)/(p2.x-p1.x);
     float m2=(line.p2.y-line.p1.y)/(line.p2.x-line.p1.x);
     return (m1==m2);
   } else return (p1.x==p2.x && line.p1.x==line.p2.x);
 }
 
 float distanceToPoint(PVector point) {
  float normalLength = dist(p1.x, p1.y, p2.x, p2.y);
  float area = abs((p2.x - p1.x) * (p1.y - point.y) - (p1.x - point.x) * (p2.y - p1.y));
  return area / normalLength;
 }
 
 PVector findClosestPoint(Line... line){
  float minValue = Float.MAX_VALUE;
  PVector point=null;
  for (int i=0;i<line.length;i++){
   if (distanceToPoint(line[i].p1)<minValue){
    point=line[i].p1.copy();
    minValue=distanceToPoint(line[i].p1);
   }
   if (distanceToPoint(line[i].p2)<minValue){
    point=line[i].p2.copy();
    minValue=distanceToPoint(line[i].p2);
   }
  }
  return point;
 }
 
 
 boolean isIntresectedWithAnyOfThis(Line... lines){
  for (int i=0;i<lines.length;i++){
   if (getIntresectionPoint(lines[i])!=null) return true; 
  }
  return false;
 }
 
 PVector getIntresectionPoint(Line line){
  if (p1.x!=p2.x && line.p1.x!=line.p2.x){
   float m1=(p2.y-p1.y)/(p2.x-p1.x);
   float m2=(line.p2.y-line.p1.y)/(line.p2.x-line.p1.x);
   float c1=p1.y-m1*p1.x;
   float c2=line.p1.y-m2*line.p1.x;
   if(m1==m2) {
     if ((c1==c2) && (p1.x>min(line.p1.x,line.p2.x) && p1.x<max(line.p1.x,line.p2.x)) || (p2.x>min(line.p1.x,line.p2.x) && p2.x<max(line.p1.x,line.p2.x))){
       if (p1.x>min(line.p1.x,line.p2.x) && p1.x<max(line.p1.x,line.p2.x)){
        return p1.copy(); 
       } else {
        return p2.copy(); 
       }
     } else{
      return null; 
     }
   }
   float x=(c2-c1)/(m1-m2);
   float y=m1*x+c1;  
   if (x>min(p1.x,p2.x) && x<max(p1.x,p2.x) && x>min(line.p1.x,line.p2.x) && x<max(line.p1.x,line.p2.x)) return new PVector(x,y);
   else return null;
  }else if(p1.x==p2.x && line.p1.x==line.p2.x) {
    if (p1.x==line.p1.x&&((line.p1.y>min(p1.y,p2.y) && line.p1.y<max(p1.y,p2.y)) || (line.p2.y>min(p1.y,p2.y) && line.p2.y<max(p1.y,p2.y)))){
     if (p1.y>min(line.p1.y,line.p2.y) && p1.y<max(line.p1.y,line.p2.y)){
        return p1.copy(); 
       } else {
        return p2.copy(); 
       }
     } else{
      return null; 
     }
  }
  else{
   float x,c,m,ay,by,ax,bx;
   if(p1.x==p2.x){
    x=p1.x;
    m=(line.p2.y-line.p1.y)/(line.p2.x-line.p1.x);
    c=line.p1.y-m*line.p1.x;
    ay=p1.y;
    by=p2.y;
    ax=line.p1.x;
    bx=line.p2.x;
   } else{
    x=line.p1.x;
    m=(p2.y-p1.y)/(p2.x-p1.x);
    c=p1.y-m*p1.x;
    ay=line.p1.y;
    by=line.p2.y;
    ax=p1.x;
    bx=p2.x;
   }
   float y=x*m+c;
   if (y>=min(ay,by) && y<=max(ay,by) && x>=min(ax,bx) && x<=max(ax,bx)) return new PVector(x,y);
   else return null;
  }
 }
}

Line[] createLine(GameObject a,GameObject b){
  if (a==b) return null;
  PVector[] intresectionPoints = new PVector[4];
  int intresectionCount=0;
  Line[] aLines=new Line[4];
  Line[] bLines=new Line[4];
  aLines[0]=new Line(a.getCorner(0,0),a.getCorner(0,1));
  aLines[1]=new Line(a.getCorner(0,1),a.getCorner(1,1));
  aLines[2]=new Line(a.getCorner(1,1),a.getCorner(1,0));
  aLines[3]=new Line(a.getCorner(1,0),a.getCorner(0,0));
  bLines[0]=new Line(b.getCorner(0,0),b.getCorner(0,1));
  bLines[1]=new Line(b.getCorner(0,1),b.getCorner(1,1));
  bLines[2]=new Line(b.getCorner(1,1),b.getCorner(1,0));
  bLines[3]=new Line(b.getCorner(1,0),b.getCorner(0,0));
  for (int i=0;i<4;i++){
   for (int j=0;j<4;j++){
    if(aLines[i].getIntresectionPoint(bLines[j])!=null && !aLines[i].isParralelWith(bLines[j])) {
     intresectionPoints[intresectionCount]=aLines[i].getIntresectionPoint(bLines[j]);
     intresectionCount++;
    }
   }
  }
  if (intresectionCount==0){
   for (int i=0;i<4;i++){
    for (int j=0;j<4;j++){
     if(bLines[i].getIntresectionPoint(aLines[j])!=null && !bLines[i].isParralelWith(aLines[j])) {
      intresectionPoints[intresectionCount]=bLines[i].getIntresectionPoint(aLines[j]);
      intresectionCount++;
     }
    }
   }
  }
  if (intresectionCount==0) return null;
  else if(intresectionCount==2) return new Line[]{new Line(intresectionPoints[0],intresectionPoints[1])};
  else return new Line[]{new Line(intresectionPoints[0],intresectionPoints[1]),new Line(intresectionPoints[2],intresectionPoints[3])};
}
