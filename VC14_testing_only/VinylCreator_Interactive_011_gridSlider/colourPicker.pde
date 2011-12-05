class ColourPicker{

  String cTitle;
  float r, g, b, a;
  PVector pos;

  // UI standards
  float typeHeight = 12;
  float lineHeight = typeHeight * 1.4;
  float buttonSize = lineHeight;
  float baseLeading = 4;
  
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
    
    fill(20,20,20);
    textFont(createFont("DroidSans", typeHeight));
    text(cTitle, pos.x, pos.y  + (lineHeight-baseLeading) - lineHeight);  
    
//    rectMode(CORNER);
//    fill(255,0,0);
//    noStroke();
//    rect(pos.x, pos.y, lineHeight, buttonSpacing*4, 4);
//    
//    fill(0,255,0);
//    noStroke();
//    rect(pos.x + buttonSpacing, pos.y, lineHeight, buttonSpacing*4, 4);
//    
//    fill(0,0,255);
//    noStroke();
//    rect(pos.x + (buttonSpacing * 2), pos.y, lineHeight, buttonSpacing*4, 4);
    
    rectMode(CORNER);
    fill(r, g, b, a);
    noStroke();
    rect(pos.x, pos.y, buttonSpacing*4, buttonSize, 4);
    
  }
  
   
  
}


// slider class
