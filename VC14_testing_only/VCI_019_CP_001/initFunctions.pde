// m a s s   i n i t s



void resetDrawSettings(){
  background(252);
  smooth();
    
}


void initGraphicsObjects(){
  float textBox1X = 300 - 230;
  float textBox2X = APP_WIDTH - 300 - 230;
  tPosA = new PVector(textBox1X, 370.0);
  tPosB = new PVector(textBox2X + 140, 370.0);

  // Lowest layer first.
  gobjsA.add(new SVGObject(new PVector(centerA.x, 520), "da_logo.svg"));
  gobjsA.add(new TextObject("SIDE_A.txt", tPosA, "DroidSans.ttf", tHeight, 0, myCol));
  gobjsA.add(new TextObject("LOGO_A.txt", new PVector(90, 250), "NovaRound.ttf", 60, 0, myCol));
  gobjsA.add(new TextObject("info.txt", new PVector(centerA.x, 450), "NovaRound.ttf", 10, 2, myCol));
  
    
  gobjsB.add(new SVGObject(new PVector(centerB.x,490), "wonk2.svg"));
  gobjsB.add(new TextObject("SIDE_B.txt", tPosB, "DroidSans.ttf", tHeight, 1, myCol));  
   
  
  /*
  // mechanism to updateBody.
  GraphicsObject testOb = gobjs.get(1);
  if (testOb instanceof TextObject){
     TextObject textObject = (TextObject) testOb;
     textObject.updateBody(getTrackNames("More.txt"));
    
  }
  */
  
  /*
  
  // mechanism to increaseScale.
  GraphicsObject testOb = gobjsB.get(0);
  if (testOb instanceof SVGObject){
     SVGObject svgObject = (SVGObject) testOb;
     for(int i = 0; i < 140; i++){
       svgObject.increaseScale();
     }
  }
  
  */
  
  
  
  
  
}


void initSwitchButtons(){
  float midButtonsPosX = (APP_WIDTH/2) - midButton;
  sbCrosshair = new SwitchButton(1, "", new PVector(midButtonsPosX, buttonStartY));
  sbBleed = new SwitchButton(1, "", new PVector(midButtonsPosX, buttonStartY + buttonSpacing));
  sbContour = new SwitchButton(1, "", new PVector(midButtonsPosX, buttonStartY + buttonSpacing*2));
  sbGrid = new SwitchButton(1, "", new PVector(midButtonsPosX, buttonStartY + (buttonSpacing*3)));
  buttons = new SwitchButton[]{sbCrosshair, sbBleed, sbContour, sbGrid};

}


void initColourPickers(){
  float leftButtonsPosX = (APP_WIDTH/2)-37;
  float rightButtonsPosX = leftButtonsPosX + 57;

  colLabelLeft = new ColourPicker(0, leftLabelColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*-1)), "Label A");
  colLabelRight = new ColourPicker(1, rightLabelColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*-1)), "Label B");

  colCrosshairLeft = new ColourPicker(0, leftCrosshairColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*0)), "");
  colBleedLeft = new ColourPicker(0, leftBleedColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*1)), "");
  colContourLeft = new ColourPicker(0, leftContourColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*2)), "");
  colGridLeft = new ColourPicker(0, leftGridColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*3)), "");
  
  colCrosshairRight = new ColourPicker(1, rightCrosshairColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*0)), "");
  colBleedRight = new ColourPicker(1, rightBleedColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*1)), "");
  colContourRight = new ColourPicker(1, rightContourColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*2)), "");
  colGridRight = new ColourPicker(1, rightGridColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*3)), "");
  
  colourPickers = new ColourPicker[]{  colCrosshairLeft, colBleedLeft, colContourLeft, colGridLeft, 
                                        colCrosshairRight, colBleedRight, colContourRight, colGridRight,
                                      colLabelLeft, colLabelRight}; 

}


void initValueChangers(){
  PVector locRowChanger = new PVector((APP_WIDTH/2)-37, LABEL_DIAMETER + 40);
  PVector locColChanger = new PVector(locRowChanger.x+57, locRowChanger.y);
  gridRowChanger = new ValueChanger(locRowChanger, "Row", 2, 15, 10);
  gridColumnChanger = new ValueChanger(locColChanger, "Column", 2, 15, 10);
  changers = new ValueChanger[]{gridRowChanger, gridColumnChanger};

}


void initLayersMechanism(){
  labelALayers = new LayerViewObject(new PVector(10, uiTopY+30), gobjsA);
  // labelALayers.addLayer();

  
  labelBLayers = new LayerViewObject(new PVector(APP_WIDTH - LAYER_VIEW_WIDTH - 10, uiTopY+30), gobjsB);
  // labelBLayers.addLayer();

}


void displayColourPickers(){
   for (ColourPicker colourPicker : colourPickers){
       colourPicker.display();
   } 
    
}

