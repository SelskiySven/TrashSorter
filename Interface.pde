interface OnObjectClass{
 void _init(GameObject obj);
 void update();
 void setup();
 void onClick();
 void onMove();
 void onDrag();
 void onPress();
 void onRelease();
 void onScroll(MouseEvent e);
 void keyPressed();
 void keyReleased();
}

class Template implements OnObjectClass{
  GameObject parent;
  void _init(GameObject obj){parent = obj;}
  void setup(){}
  void update(){}
  void onClick(){}
  void onMove(){}
  void onDrag(){}
  void onPress(){}
  void onRelease(){}
  void onScroll(MouseEvent e){}
  void keyPressed(){}
  void keyReleased(){}
}
