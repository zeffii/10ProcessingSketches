class ValueChanger{
  // own
  int lowestValue, highestValue, defaultValue, currentValue;
  float lowX, lowY, lowerButtonLocY, midwayX;
  float plusButtonLowX, plusButtonHighX, plusButtonLowY, plusButtonHighY;
  float minusButtonLowX, minusButtonHighX, minusButtonLowY, minusButtonHighY;
  float[] plusButton;
  float[] minusButton;
      
  String uiLabel;
  PVector pos;
  
  // constructor
  ValueChanger(PVector itemLocation, String label, int low, int high, int defaultValue){
    currentValue = defaultValue;
    lowestValue = low;
    highestValue = high;
    uiLabel = label;
    pos = itemLocation;
    
    lowX = pos.x + buttonSize;
    lowY = pos.y + buttonSize;
    lowerButtonLocY = pos.y + doubleButtonSpace;
    midwayX = pos.x + midButton; 
    
    plusButtonLowX = pos.x; 
    plusButtonHighX = pos.x + buttonSize;
    plusButtonLowY = pos.y;
    plusButtonHighY = pos.y + buttonSize;
    plusButton = new float[]{plusButtonLowX, plusButtonHighX, plusButtonLowY, plusButtonHighY}; 

    minusButtonLowX = pos.x; 
    minusButtonHighX = pos.x + buttonSize; 
    minusButtonLowY = lowerButtonLocY;
    minusButtonHighY = lowerButtonLocY + buttonSize;
    minusButton = new float[]{minusButtonLowX, minusButtonHighX, minusButtonLowY, minusButtonHighY};
        
  }


  void display(){
    
    // unreadable and obfuscated, but seems fast.
    textFont(createFont("DroidSans", uiTypeHeight));
    textAlign(CORNER);   
    fill(20,20,20);
    float centerOfText = textWidth(uiLabel) * .5;
    float labelPositionX = midwayX - centerOfText;
    text(uiLabel, labelPositionX, pos.y + buttonSpacing + lineHeight - baseLeading);  
               
    // plus and minux boxes
    fill(buttonFill);    
    rect(pos.x, pos.y, buttonSize, buttonSize, 4);
    rect(pos.x, lowerButtonLocY, buttonSize, buttonSize, 4);
        
    stroke(signColour);
    line(pos.x + 4, pos.y + midButton, plusButtonHighX - 4, pos.y + midButton);
    line(midwayX, plusButtonHighY - 4, midwayX, pos.y + 4);
    line(pos.x + 4, lowerButtonLocY + midButton, plusButtonHighX - 4, lowerButtonLocY + midButton);
    
    noStroke();
    
  }
  
    
  boolean checkButton(float[] buttonBounds){
    if (mouseX > buttonBounds[0] && mouseX < buttonBounds[1] &&
          mouseY > buttonBounds[2] && mouseY < buttonBounds[3]){
          return true;
      } else{
          return false;
      } 
    
  }
  
  
  boolean isMinus(){
    return checkButton(minusButton);
  }
  boolean isPlus(){
    return checkButton(plusButton);
  } 
  
  void reduce(){
    if (currentValue > lowestValue) currentValue -= 1;  
  }
  
  void increase(){
    if (currentValue < highestValue) currentValue += 1;  
  }
  
  void reset(){
    currentValue = defaultValue;  
  }
  
}
