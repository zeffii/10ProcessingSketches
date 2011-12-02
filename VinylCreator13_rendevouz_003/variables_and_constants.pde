// storing current working path
String path = "";


// typographic constants
float lineRatio = 1.167;
int typeHeight = 65; // for copy text
int typeDescriptionHeight = 40;  // for information
float lineHeight = float(typeHeight) * lineRatio;
float lineDescriptionHeight = float(typeDescriptionHeight) * lineRatio;
float textAdjustY = typeHeight + 3;
float leftAlignX = 274.0;  // start of tracklisting
float typeInitY = 1370.0;  // start of tracklisting


// drawing variables, fluff, background fx
boolean BGNEEDED = true;
boolean useRoundedTextBackground = true;
int roundedBGmode = 1;  // 0 or 1 are slightly different flavours, ignored if useRoundedTextBackground is false;
boolean drawSideBClipLimits = false;
PVector centerSideB = new PVector(3000.0, 1000.0);
PVector centerSideA = new PVector(1000.0, 1000.0);
float boxHeight = 178;  // this should instead be determined by typeHeight! TODO.


// text (track names)
String albumName = "Wicked_Batch_of_a_Test" + ".pdf";
String track1A = "1A. Via Osmosis (Original Mix) 3:42";
String track2A = "2A. Carpool Tunnel Syndrome (Disjointed Mix) 7:23";
String track1B = "1B. Via Osmosis (Stigma Mix) 4:35";
String track2B = "2B. Insufficient Parameters (boolean Mix) 5:13";


// text production and license details
String multilineString1 = "All tracks are licensed to Artificial recordings, additional mastering";
String multilineString2 = "done by Totally Ridiculous Dynamics at Trendy studios";
float descriptionYPos = 1700;
float logoCenterY = 1597;


// outline for design, printing aids
boolean outer = false;
boolean inner = false;
boolean crossHair = true;
float outerRadius = 980;
float innerRadius = 60;
float bleedRadius = 924.53;         // 53 = 980   50 = 
boolean BLEED_VISIBLE = true;


// random image properties
boolean randomImage = false; // false; //true;
boolean randomImagePosition = true;
boolean randomImageRotate = false;  // do not set rotate and position both to random.
boolean semiRandomTintFX = false; //true;
boolean displayAfterwards = true;
String selectedImageName = "";


// grid drawing 
float totalWidth = outerRadius * 2;
float totalHeight = outerRadius * 2;
int gridRows = 3;
int gridCols = 8; 
float gridRowHeight = totalHeight / (gridRows);
float gridColWidth = totalWidth / (gridCols);
color gridColor = color(244, 0, 30, 130);
