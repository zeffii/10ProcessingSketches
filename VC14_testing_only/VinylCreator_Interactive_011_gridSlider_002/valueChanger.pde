class ValueChanger{
  // own
  int lowestValue;
  int highestValue; // arbitrary now, but likely to change.
  int defaultValue;  // for resetting.
  int currentValue;
  String uiLabel;
  PVector pos;

  // constructor
  ValueChanger(PVector itemLocation, String label, int low, int high, int defaultValue){
    currentValue = defaultValue;
    lowestValue = low;
    highestValue = high;
    uiLabel = label;
    pos = itemLocation;
  }


  void display(){
    
    // WOAH!! todo, use relative coordinates instead, this is ridiculous. what was i thinking? facepalm.
    // not using relative coordinates would make mouse _over_ functions really ugly.
    // Refactor Urgency High.
    
    // plus
    stroke(140, 140, 140);
    fill(210, 210, 210);    
    rect(pos.x, pos.y, buttonSize, buttonSize);
    stroke(50, 50, 50);
    line(pos.x + 4, pos.y + (buttonSize/2), pos.x + buttonSize - 4, pos.y + (buttonSize/2));
    line(pos.x + (buttonSize/2), pos.y + buttonSize - 4, pos.x + (buttonSize/2), pos.y + 4);
    
    // experimenting with UI here...   
    fill(20,20,20);
    textFont(createFont("DroidSans", uiTypeHeight));
    text(uiLabel, pos.x, pos.y + buttonSpacing + lineHeight - baseLeading);  
            
    // minus
    stroke(140, 140, 140);
    fill(210, 210, 210);    
    rect(pos.x, pos.y + (buttonSpacing*2), buttonSize, buttonSize);
    stroke(50, 50, 50);
    line(pos.x + 4, pos.y + (buttonSpacing*2) + (buttonSize/2), pos.x+buttonSize-4, pos.y + (buttonSpacing*2) + (buttonSize/2));
    
  }
  
  
  void reset(){
    currentValue = defaultValue;  
  }
  
  
  
  
  
}
