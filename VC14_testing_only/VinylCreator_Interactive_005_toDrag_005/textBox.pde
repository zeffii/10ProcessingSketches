class TextBox 
{
  String[] trackNames;
  PVector pos;
  int typeHeight;
  int alignType; // 0 = left, 1 = right
  color myColor;
  float lineHeight;
  boolean selected;
  boolean locked;

  float bbleft, bbright, bbtop, bbbottom;  
  
  // Constructor
  TextBox(String[] tNames, PVector tPos, int tHeight, int tA, color myCol){
    trackNames = tNames;
    pos = tPos;
    typeHeight = tHeight;
    alignType = tA;
    myColor = myCol;
    lineHeight = typeHeight * 1.1675;  
    
  }
    
  void display()
  {
    textFont(createFont("DroidSans", typeHeight));
    noStroke();
    
    drawBoundingBox();
    
    fill(myColor);
    if (alignType == 0) textAlign(LEFT);
    if (alignType == 1) textAlign(RIGHT);

    float pointY = pos.y;
    for (int i = 0; i < trackNames.length; i++){    
       text(trackNames[i], pos.x, pointY);
       pointY += lineHeight;
    }  
          
  }
  
  
  float getLongestFrom(String[] tNames)
  {
    float longestLength = 0.0;
    
    for (String s : tNames){
      if (textWidth(s) > longestLength){
        longestLength = textWidth(s); 
      }
    }
    return longestLength;
    
  }
  
 
  void drawBoundingBox()
  {
    
    noFill();
    if (selected){
      stroke(240,130,130);
    }
    else{
      noStroke();
    }
    
    bbleft = pos.x;
    bbright = pos.x + getLongestFrom(trackNames);
    bbtop = pos.y - lineHeight;
    bbbottom = pos.y + lineHeight * (trackNames.length-1);
    
    beginShape();
      vertex(bbleft, bbtop);
      vertex(bbright, bbtop);
      vertex(bbright, bbbottom);
      vertex(bbleft, bbbottom);
    endShape(CLOSE);
        
  }
 
  
  boolean over()
  {
    if (mouseX > bbleft && mouseX < bbright &&
        mouseY > bbtop && mouseY < bbbottom){
      return true;
    } else{
      return false;
    }
  }
  
  
  void setXY(PVector nPos){
      pos = nPos;
          
  }
  
  PVector getXY(){
     return pos; 
    
  }
  
  
  
  
  
  
}
