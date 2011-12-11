class TextObject extends GraphicsObject {

  String[] trackNames;
  String filename;
  int typeHeight;
  int alignType; // 0 = left, 1 = right
  color myColor;
  float lineHeight;
  PFont designFont;

  // Constructor
  TextObject(String _filename, PVector pos, String fontName, int _typeHeight, int _alignType, color _myColor) {
    super(pos);
    trackNames = getTrackNames(_filename);
    filename = _filename;
    designFont = createFont(fontName, _typeHeight); 
    typeHeight = _typeHeight;
    alignType = _alignType;
    myColor = _myColor;
    lineHeight = _typeHeight * 1.1675;
  }


  void display() {

    //if (!hidden){
    textFont(designFont);
    noStroke();
    fill(myColor);
    
    float textAlignX = pos.x;
    if (alignType == 0) textAlign(LEFT);
    
    if (alignType == 1) {
      textAlign(RIGHT); 
      textAlignX = pos.x + getLongestFrom(trackNames);
    }
      
    float pointY = pos.y;
    for (int i = 0; i < trackNames.length; i++) {    
      text(trackNames[i], textAlignX, pointY);
      pointY += lineHeight;
    }

    bbleft = pos.x;
    bbright = pos.x + getLongestFrom(trackNames);
    bbtop = pos.y - lineHeight;
    bbbottom = pos.y + lineHeight * (trackNames.length-1);

    if (selected) drawBoundingBox();

    //}
  }


  float getLongestFrom(String[] tNames) {
    float longestLength = 0.0;

    for (String s : tNames) {
      if (textWidth(s) > longestLength) {
        longestLength = textWidth(s);
      }
    }
    return longestLength;
    
  }


  // should take a filename directly instead.
  void updateBody(String[] tNames) {

    if (tNames.length > 0) {
      this.trackNames = tNames;
    }
    else {
      print("check the content of the String array, might be an empty file");
    }
    
  }


  String nature(){
    return "textobject";
  }
  
  
  String getFileName(){
    return filename; 
  }

  // set local design font
  
  
  // set typeHeight
  
}

