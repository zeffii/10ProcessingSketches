//path to this sketch
String path;

// center point
PVector centerA, centerB;

// initial graphics text box location.
PVector tPosA, tPosB;

// contains the GraphicsObjects in order of display.
ArrayList<GraphicsObject> gobjsA, gobjsB; //, gobjsAB;

// UI
PFont monoFont, labelFont, designFont;

SwitchButton sbCrosshair, sbContour, sbBleed, sbGrid;
SwitchButton[] buttons = new SwitchButton[4];

ColourPicker colCrosshairLeft, colCrosshairRight;
ColourPicker colContourLeft, colContourRight;
ColourPicker colBleedLeft, colBleedRight;
ColourPicker colGridLeft, colGridRight;
ColourPicker colLabelLeft, colLabelRight;
ColourPicker[] colourPickers;

ValueChanger gridRowChanger, gridColumnChanger;
ValueChanger[] changers;

LayerViewObject labelALayers, labelBLayers;



