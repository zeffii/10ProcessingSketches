//path to this sketch
String path;

// center point
PVector centerA, centerB;

// not sure
String[] tNamesA, NamesB;
PVector tPosA, tPosB;

// contains the GraphicsObjects in order of display.
ArrayList<GraphicsObject> gobjsA, gobjsB; //, gobjsAB;

// UI
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
