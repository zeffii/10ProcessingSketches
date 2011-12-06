// mainly unimplemented so far, very messy.

class ColourPicker{

  String cTitle;
  float r, g, b, a;
  PVector pos;

  // Constructor
  ColourPicker(color colChoice, PVector assemblyPos, String colorName){
    r = red(colChoice);
    g = green(colChoice);
    b = blue(colChoice);
    a = alpha(colChoice);
    cTitle = colorName;
    pos = assemblyPos;
    
  }  
  
  
  void display(){
    
    color elementColour = color(r, g, b, a);
    
    rectMode(CORNER);
    fill(elementColour);
    noStroke();
    rect(pos.x, pos.y, buttonSpacing*4, buttonSize, 4);
    
    rectMode(CORNER);
    noFill();
    stroke(230, 230, 230);
    rect(pos.x, pos.y+buttonSpacing, buttonSpacing*4, buttonSize, 4);

    textAlign(LEFT);  // will not be constant
    fill(20,20,20);
    textFont(createFont("DroidSans", uiTypeHeight));
    text(cTitle, pos.x, pos.y  + (lineHeight-baseLeading) - lineHeight);  

    String colorHex = "#" + hex(elementColour, 6);
    text(colorHex, pos.x + (baseLeading*1.567), pos.y  + (buttonSpacing*2) - baseLeading - 3);  


    
    noStroke();
  }
  
   
  
}


// slider class?
