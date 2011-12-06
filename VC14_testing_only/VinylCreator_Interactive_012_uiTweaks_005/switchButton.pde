class SwitchButton
{
  String buttonText = "";
  PVector pos;
  boolean state = true;
  float rw, rh;
  boolean inRange = false;
  int direction = 0;  // fallback value
  float labelX;
  
  float bbleft, bbright, bbtop, bbbottom;  

  // constructor
  SwitchButton(int tDir, String bText, PVector bPos){
    buttonText = bText;
    pos = bPos;
    direction = tDir;
        
    bbleft = bPos.x;
    bbright = bPos.x + buttonSize;
    bbtop = bPos.y;
    bbbottom = bPos.y + buttonSize; 
  }  
  
  
  void display(){
    
    // button setup
    noStroke();
    
    if (state){
      fill(220, 220, 220);
    }else{
      stroke(200,200,200);
      fill(255, 255, 255);
    }
        
    rectMode(CORNER);
    rect(pos.x, pos.y, lineHeight, lineHeight, 4);
    
    // text
    fill(20,20,20);
    
          
    if (direction == 0){
      textAlign(LEFT);
      labelX = pos.x + buttonSize + verticalSpacer;  
    }
  
    if (direction == 1){
      textAlign(RIGHT);
      labelX = pos.x - verticalSpacer;
    }
        
    textFont(createFont("DroidSans", uiTypeHeight));
    text(buttonText, labelX, pos.y  + (lineHeight-baseLeading));
      
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
