class TextBox 
{
  /*
  this class handles the drawing and testing of the mouse over state.
  
  */
  
  
  String[] trackNames;
  PVector pos;
  int typeHeight;
  int alignType; // 0 = left, 1 = right
  color myColor;
  float lineHeight;
  boolean selected = false;
  boolean locked = true;
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
  
  
  // defaults  
  
  
  void display()
  {
    // char[] chars = new char[]{'C','h','œ','w','m','e','i','n'};
    // textFont(createFont("DroidSans", typeHeight, true, chars));
    textFont(createFont("DroidSans.ttf", typeHeight));
    noStroke();
    
    drawBoundingBox();
    
    fill(myColor);
    if (alignType == 0) textAlign(LEFT);
    if (alignType == 1) textAlign(RIGHT);

    //text("Chœwmein", pos.x, pos.y);
  
    float pointY = pos.y;
    for (int i = 0; i < trackNames.length; i++){    
       text(trackNames[i], pos.x, pointY);
       pointY += lineHeight;
    }  
          
  }
  
  
  // commodities.
  
  
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
  
  
  // getter setter.
  
  
  void setXY(PVector nPos)
  {
      pos = nPos;
          
  }
  
  
  PVector getXY()
  {
     return pos; 
    
  }
  
}
