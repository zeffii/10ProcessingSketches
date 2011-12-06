class ValueChanger{
  // own
  int lowestValue;
  int highestValue; // arbitrary now, but likely to change.
  int defaultValue;  // for resetting.
  int currentValue;
  String uiLabel;
  PVector pos;
  color signColour = color(140, 140, 140);
  
  float plusButtonLowX, plusButtonHighX, plusButtonLowY, plusButtonHighY;
  float minusButtonLowX, minusButtonHighX, minusButtonLowY, minusButtonHighY;
  
  // constructor
  ValueChanger(PVector itemLocation, String label, int low, int high, int defaultValue){
    currentValue = defaultValue;
    lowestValue = low;
    highestValue = high;
    uiLabel = label;
    pos = itemLocation;
  }


  void display(){
    
    // unreadable and obfuscated, but seems fast.
    textFont(createFont("DroidSans", uiTypeHeight));   
    fill(20,20,20);
    text(uiLabel, pos.x, pos.y + buttonSpacing + lineHeight - baseLeading);  
    
    float lowX = pos.x + buttonSize;
    float lowY = pos.y + buttonSize;
    float midButton = buttonSize * 0.5;
    float doubleButtonSpace = buttonSpacing * 2;
    float lowerButtonLocY = pos.y + doubleButtonSpace;
    float verticalX = pos.x + midButton; 
    plusButtonLowX = pos.x; 
    plusButtonHighX = pos.x + buttonSize;
    plusButtonLowY = pos.y;
    plusButtonHighY = pos.y + buttonSize;
    minusButtonLowX = pos.x; 
    minusButtonHighX = pos.x + buttonSize; 
    minusButtonLowY = lowerButtonLocY;
    minusButtonHighY = lowerButtonLocY + buttonSize;
    
    // plus and minux boxes
    fill(buttonFill);    
    rect(pos.x, pos.y, buttonSize, buttonSize, 4);
    rect(pos.x, lowerButtonLocY, buttonSize, buttonSize, 4);
        
    stroke(signColour);
    line(pos.x + 4, pos.y + midButton, plusButtonHighX - 4, pos.y + midButton);
    line(verticalX, plusButtonHighY - 4, verticalX, pos.y + 4);
    line(pos.x + 4, lowerButtonLocY + midButton, plusButtonHighX - 4, lowerButtonLocY + midButton);
    
  }
  
  
  void reset(){
    currentValue = defaultValue;  
  }
  
  
  
  
  
}
