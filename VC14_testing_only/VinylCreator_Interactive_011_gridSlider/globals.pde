float OUTER_MOST_RADIUS = 290.0;
float OFFSET_FROM_EDGES = 10.0;
float BLEED_RADIUS = 273.5849;  // 290+290 : 106   x/2 = 100
float LABEL_DIAMETER = OUTER_MOST_RADIUS * 2; 
int APP_WIDTH = int(10.0 + LABEL_DIAMETER + 30.0 + LABEL_DIAMETER + 10.0); // depends
int APP_HEIGHT = 800;
float xOffset = 0.0; 
float yOffset = 0.0; 
float buttonSpacing = 20.0;
float buttonStartX = 680.0;

// just in case sides are totally different.
color leftBleedColour = color(170,170,255);
color rightBleedColour = color(170,170,255);
color myCol = color(60,60,60);
color leftGridColour = color(244, 20, 130, 20);
color rightGridColour = color(244, 20, 130, 20);

// typographic constants, rename please.
int tHeight = 20;

// grid drawing
int gridRows = 12;
int gridCols = 12;

PVector centerA, centerB;
