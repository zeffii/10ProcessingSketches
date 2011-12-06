// mainly unimplemented so far, very messy.

class ColourPicker{

  String cTitle;  // cTitle not correctly implemented anymore. don't use untill you do.
  float r, g, b, a;
  PVector pos;
  int direction;

  // Constructor
  ColourPicker(int dDir, color colChoice, PVector assemblyPos, String colorName){
    r = red(colChoice);
    g = green(colChoice);
    b = blue(colChoice);
    a = alpha(colChoice);
    cTitle = colorName;
    pos = assemblyPos;
    direction = dDir;
    
  }  
  
  
  void display(){
    
    color elementColour = color(r, g, b, a);
    
    if (direction==0){
      
      float colourBoxLeftX = pos.x - buttonSpacing; 
      rectMode(CORNER);
      fill(elementColour);
      noStroke();
      rect(colourBoxLeftX, pos.y, buttonSpacing*2, buttonSize, 4);
      
      float hexBoxLeftX = colourBoxLeftX-(buttonSpacing*3)-9;
      rectMode(CORNER);
      noFill();
      stroke(230, 230, 230);
      rect(hexBoxLeftX, pos.y, buttonSpacing*3, buttonSize, 4);
  
      textAlign(RIGHT);  // will not be constant
      fill(20,20,20);
      textFont(createFont("DroidSans", uiTypeHeight));
      text(cTitle, pos.x, pos.y  + (lineHeight-baseLeading) - lineHeight);  
  
      float hexStringY = pos.y  + buttonSpacing - baseLeading - 3;
      textAlign(LEFT);  // will not be constant
      String colorHex = "#" + hex(elementColour, 6);
      text(colorHex, hexBoxLeftX + (baseLeading*1.567), hexStringY);  

    }

    if (direction==1){
      
      float colourBoxLeftX = pos.x - 3; 
      rectMode(CORNER);
      fill(elementColour);
      noStroke();
      rect(colourBoxLeftX, pos.y, buttonSpacing*2, buttonSize, 4);
      
      float hexBoxLeftX = colourBoxLeftX+(buttonSpacing*3)-12;
      rectMode(CORNER);
      noFill();
      stroke(230, 230, 230);
      rect(hexBoxLeftX, pos.y, buttonSpacing*3, buttonSize, 4);
  
      textAlign(LEFT);  // will not be constant
      fill(20,20,20);
      textFont(createFont("DroidSans", uiTypeHeight));
      text(cTitle, pos.x, pos.y  + (lineHeight-baseLeading) - lineHeight);  
  
      float hexStringY = pos.y  + buttonSpacing - baseLeading - 3;
      textAlign(LEFT);  // will not be constant
      String colorHex = "#" + hex(elementColour, 6);
      text(colorHex, hexBoxLeftX + (baseLeading*1.567), hexStringY);  

    }












    
    noStroke();
  }
  
   
  
}


// slider class?
