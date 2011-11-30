
String path = "";

// typographic constants
int typeHeight = 65; // for copy text
int typeDescriptionHeight = 40;  // for information
float lineRatio = 1.167;
float leftAlignX = 274.0;
float typeInitY = 1370.0;

// drawing variables, fluff, background fx 
boolean useRoundedTextBackground = true;
int roundedBGmode = 1;  // 0 or 1 are slightly different flavours, ignored if useRoundedTextBackground is false;
boolean drawSideBClipLimits = false;

// text (track names)
String albumName = "Wicked_Batch_of_a_Test" + ".pdf";
String track1A = "1A. Via Osmosis (Original Mix) 3:42";
String track2A = "2A. Carpool Tunnel Syndrome (Disjointed Mix) 7:23";
String track1B = "1B. Via Osmosis (Stigma Mix) 4:35";
String track2B = "2B. Insufficient Parameters (boolean Mix) 5:13";

// text production and license details
String multilineString1 = "All tracks are licensed to Artificial recordings, additional mastering";
String multilineString2 = "done by Totally Ridiculous Dynamics at Trendy studios";
float descriptionYPos = 1730;

// outline for design, printing aids
boolean outer = true;
boolean inner = false;
boolean crossHair = true;
float outerRadius = 980;
float innerRadius = 60;

// random image properties, to declare images for selecting add them to drawRaster
boolean randomImagePosition = false;
boolean randomImage = false; //true;
boolean randomRotateImage = true;
boolean semiRandomTintFX = false; //true;
boolean displayAfterwards = true;
