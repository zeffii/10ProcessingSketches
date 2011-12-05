class ValueChanger{
int lowestValue;
int highestValue; // arbitrary now, but likely to change.
int defaultValue;  // for resetting.
int currentValue;
String uiLabel;
  
  // constructor
  ValueChanger(String label, int low, int high, int defaultValue){
    currentValue = defaultValue;
    lowestValue = low;
    highestValue = high;
    uiLabel = label;
  
  }


  void display(){
    // experimenting with UI here...   
      
        
    
    
  }
  
  
  void reset(){
    currentValue = defaultValue;  
  }
  
  
  
  
  
}
