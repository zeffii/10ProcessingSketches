// drawing switches (mostly booleans, most likely to be modified most)
boolean crosshairVisible = true;
boolean bleedVisible = false; //true;
boolean gridVisible = false; //  false;
boolean outerLimitsVisible = false;
float leftAlignX = 281.0;  // start of tracklisting
float typeInitY = 1316.0;  // start of tracklisting
float logoCenterY = 1530;  //depends
float descriptionYPos = 1690;


// storing current working path
String path = "";


// typographic constants
int typeHeight = 65; // for copy text
int typeDescriptionHeight = 40;  // for information
float lineRatio = 1.167;
float lineHeight = float(typeHeight) * lineRatio;
float lineDescriptionHeight = float(typeDescriptionHeight) * lineRatio;
float textAdjustY = typeHeight + 3;


// drawing variables, fluff, background fx
PVector centerSideB = new PVector(3000.0, 1000.0);
PVector centerSideA = new PVector(1000.0, 1000.0);
boolean drawSideBClipLimits = false;
boolean BGNEEDED = true;
boolean useRoundedTextBackground = true;
int roundedBGmode = 1;  // 0 or 1 are slightly different flavours, ignored if useRoundedTextBackground is false;
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


// outline for design, printing aids
float outerRadius = 980;
float crossHairRadius = 20.0;
float bleedRadius = 924.53;         // 53 = 980   50 = 


// random image properties
boolean randomImage = false; // false; //true;
boolean randomImagePosition = true;
boolean randomImageRotate = false;  // do not set rotate and position both to random.
boolean semiRandomTintFX = false; //true;
boolean displayAfterwards = true;
String selectedImageName = "";


// grid drawing
int gridRows = 12;
int gridCols = 12; 
float totalWidth = outerRadius * 2;
float totalHeight = outerRadius * 2;
float gridRowHeight = totalHeight / (gridRows);
float gridColWidth = totalWidth / (gridCols);
color gridColor = color(244, 0, 30, 130);
