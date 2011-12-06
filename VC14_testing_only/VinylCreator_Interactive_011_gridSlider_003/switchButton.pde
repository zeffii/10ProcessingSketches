class SwitchButton
{
  String buttonText = "";
  PVector pos;
  boolean state = true;
  float rw, rh;
  boolean inRange = false;
  
  
  float bbleft, bbright, bbtop, bbbottom;  

  // constructor
  SwitchButton(String bText, PVector bPos){
    buttonText = bText;
    pos = bPos;
    
    bbleft = bPos.x;
    bbright = bPos.x + buttonSize;
    bbtop = bPos.y;
    bbbottom = bPos.y + buttonSize; 
  }  
  
  
  void display(){
    stroke(160, 160, 160);
    
    if (state){
      fill(220, 220, 220);
    }else{
      fill(255, 255, 255);
    }
    
    rectMode(CORNER);
    rect(pos.x, pos.y, lineHeight, lineHeight, 4);
    
    fill(20,20,20);
    textFont(createFont("DroidSans", uiTypeHeight));
    text(buttonText, pos.x + buttonSize + verticalSpacer, pos.y  + (lineHeight-baseLeading));
      
  }
  
  boolean over(){
    if (mouseX > bbleft && mouseX < bbright &&
        mouseY > bbtop && mouseY < bbbottom){
      return true;
    } else{
      return false;
    }
  }
  
  
}
