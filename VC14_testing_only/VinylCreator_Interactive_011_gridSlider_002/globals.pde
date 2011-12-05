// constants for now.
float OUTER_MOST_RADIUS = 290.0;
float OFFSET_FROM_EDGES = 10.0;
float BLEED_RADIUS = 273.5849;  // 290+290 : 106   x/2 = 100
float LABEL_DIAMETER = OUTER_MOST_RADIUS * 2; 
int APP_WIDTH = int(10.0 + LABEL_DIAMETER + 30.0 + LABEL_DIAMETER + 10.0); // depends
int APP_HEIGHT = 800;

// center point declaration.
PVector centerA, centerB;

// for mouse functions.
float xOffset = 0.0; 
float yOffset = 0.0; 

// just in case sides are totally different background colours.
color leftBleedColour = color(170,170,255);
color rightBleedColour = color(170,170,255);
color leftGridColour = color(244, 20, 130, 20);
color rightGridColour = color(244, 20, 130, 20);
color myCol = color(60,60,60);  // wtf?  used for textbox items, hopefully you will never read this.

// Design view - typographic typeheight for textbox default declaration
int tHeight = 20;  

// UI standards
int uiTypeHeight = 12;  // more like a constant..
float lineHeight = uiTypeHeight * 1.4;
float baseLeading = 4;
float buttonSize = lineHeight;
float verticalSpacer = 4;
float buttonSpacing = 20.0;
float buttonStartX = 680.0;

// grid drawing
int gridRows = 12;
int gridCols = 12;

