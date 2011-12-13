// constants for now.
float OUTER_MOST_RADIUS = 290.0;
float OFFSET_FROM_EDGES = 10.0;
float BLEED_RADIUS = 273.5849;  // 290+290 : 106   x/2 = 100
float LABEL_DIAMETER = OUTER_MOST_RADIUS * 2; 
int APP_WIDTH = int(10.0 + LABEL_DIAMETER + 30.0 + LABEL_DIAMETER + 10.0); // depends
int APP_HEIGHT = 830;
int LAYER_VIEW_WIDTH = 460;


// for mouse functions.
float xOffset = 0.0; 
float yOffset = 0.0; 


// Design view 
int tHeight = 18; // typographic typeheight  
color myCol = color(60,60,60);  // color for textbox, hopefully you will never read this.
int gridRows = 12;
int gridCols = 12;
String[] placeHolder = new String[]{"detroit\n","pump\n"};  


// UI standards
int uiTypeHeight = 12;  // more like a constant..
float lineHeight = uiTypeHeight * 1.4;
float baseLeading = 4;
float buttonSize = lineHeight;
float midButton = buttonSize * 0.5;
float verticalSpacer = 4;
float buttonSpacing = 20.0;
float doubleButtonSpace = buttonSpacing * 2;
float buttonStartY = 715.0 + buttonSpacing;


// ui area
float uiTopY = 300 + OUTER_MOST_RADIUS + 20;  //300 = centerA.y

  
// UI colours
color signColour = color(40, 40, 40);
color buttonFill = color(210, 210, 210);
color uiGridColour = color(230, 230, 230);


// default Design view 
color leftLabelColour = color(253, 253, 253);
color rightLabelColour = color(253, 253, 253);

color leftBleedColour = color(170, 170, 255);
color rightBleedColour = color(170, 170, 255);

color leftGridColour = color(244, 20, 130, 20);
color rightGridColour = color(244, 20, 130, 20);

color leftContourColour = color(170, 70, 255);
color rightContourColour = color(170, 70, 255);

color leftCrosshairColour = color(120, 170, 255);
color rightCrosshairColour = color(120, 170, 255);

