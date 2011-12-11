// mainly unimplemented so far, very messy.

class ColourPicker{

  String cTitle; // draws above the colourbox.
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
    textFont(labelFont);
    float stringWidth = textWidth(cTitle);
    float hexBoxLeftX = 0.0;
    float labelPosX = 0.0;
      
    if (direction==0){
      
      float colourBoxLeftX = pos.x - buttonSpacing; 
      rectMode(CORNER);
      fill(elementColour);
      noStroke();
      rect(colourBoxLeftX, pos.y, buttonSpacing*2, buttonSize, 4);
      
      hexBoxLeftX = colourBoxLeftX-(buttonSpacing*3)-9;
      rectMode(CORNER);
      noFill();
      stroke(230, 230, 230);
      rect(hexBoxLeftX, pos.y, buttonSpacing*3, buttonSize, 4);
      textAlign(RIGHT);
      
      labelPosX = pos.x + buttonSize + 2;

    }

    if (direction==1){
      
      float colourBoxLeftX = pos.x - 3; 
      rectMode(CORNER);
      fill(elementColour);
      noStroke();
      rect(colourBoxLeftX, pos.y, buttonSpacing*2, buttonSize, 4);
      
      hexBoxLeftX = colourBoxLeftX+(buttonSpacing*3)-12;
      rectMode(CORNER);
      noFill();
      stroke(230, 230, 230);
      rect(hexBoxLeftX, pos.y, buttonSpacing*3, buttonSize, 4);
      textAlign(LEFT);

      labelPosX = pos.x - 3;
    }

    // label description string.
    fill(20,20,20);
    text(cTitle, labelPosX, pos.y  + (lineHeight-baseLeading) - lineHeight);  

    // colour description in hex.
    float hexStringY = pos.y  + buttonSpacing - baseLeading - 3;
    textFont(monoFont);
    textAlign(LEFT);
    String colorHex = "#" + hex(elementColour, 6);
    text(colorHex, hexBoxLeftX + (baseLeading*1.567), hexStringY);  
    
    // finished.
    noStroke();

  }
  
}


// slider class?

