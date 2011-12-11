class TextObject extends GraphicsObject {

  String[] trackNames;
  String filename;
  int typeHeight;
  int alignType; // 0 = left, 1 = right
  color myColor;
  float lineHeight;
  // PFont designFont;

  // Constructor
  TextObject(String _filename, PVector pos, int _typeHeight, int _alignType, color _myColor) {
    super(pos);
    trackNames = getTrackNames(_filename);
    filename = _filename;
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
    if (alignType == 0) textAlign(LEFT);
    if (alignType == 1) textAlign(RIGHT);

    float pointY = pos.y;
    for (int i = 0; i < trackNames.length; i++) {    
      text(trackNames[i], pos.x, pointY);
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


  void updateBody(String[] tNames) {

    if (tNames.length > 0) {
      this.trackNames = tNames;
    }
    else {
      print("check the content of the String array, might be an empty file");
    }
  }


  String nature() {
    return "textobject";
  }
  
  
  String getFileName(){
    return filename; 
  
  }

  
}
