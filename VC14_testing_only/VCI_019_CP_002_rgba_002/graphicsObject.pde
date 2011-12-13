// super class


class GraphicsObject {
  
  // available to all subclasses
  PVector pos;
  float bbleft, bbright, bbtop, bbbottom;
  boolean hidden = false;
  boolean selected = false;
  boolean locked = true;

  // constructor
  GraphicsObject(PVector _pos) {
    pos = _pos;
  }


  void display(){}

  
  void drawBoundingBox(){
    pushStyle();
      noFill();
      stroke(2550,140,140);
      beginShape();
        vertex(bbleft, bbtop);
        vertex(bbright, bbtop);
        vertex(bbright, bbbottom);
        vertex(bbleft, bbbottom);
      endShape(CLOSE);
    popStyle();
  }

 
  boolean over() {
    if (mouseX > bbleft && mouseX < bbright &&
        mouseY > bbtop && mouseY < bbbottom){
      return true;
    } else{
      return false;
    }  
  }

 
  void setXY(PVector newpos) {
    pos = newpos;
  }

 
  PVector getXY() {
    return new PVector(pos.x,pos.y);
  }


  void hide(){
    hidden = true;   
  }
 
  
  void show(){
    hidden = false; 
  }
 
}
