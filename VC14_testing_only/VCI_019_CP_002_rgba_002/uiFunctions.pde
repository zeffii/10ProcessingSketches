void findConstructionColourAndChange(){
   // not too fond of hardcoding like this..  
 
   int numToSet = 0;
   
   for(int i = 0; i < colourPickers.length; i++){
      if (colourPickers[i].currentlyModifiedColour){
         numToSet = i; 
      }
   }
   
   // there has to be a better way.
   if (numToSet == 0) leftCrosshairColour = newElementColour;
   if (numToSet == 1) leftBleedColour = newElementColour;                 //    colBleedLeft 
   if (numToSet == 2) leftContourColour = newElementColour;                 //    colContourLeft 
   if (numToSet == 3) leftGridColour = newElementColour;                 //    colGridLeft
   if (numToSet == 4) rightCrosshairColour = newElementColour;                 //    colCrosshairRight
   if (numToSet == 5) rightBleedColour = newElementColour;                 //    colBleedRight
   if (numToSet == 6) rightContourColour = newElementColour;                 //    colContourRight 
   if (numToSet == 7) rightGridColour = newElementColour;                 //    colGridRight
   if (numToSet == 8) leftLabelColour = newElementColour;                 //    colLabelLeft 
   if (numToSet == 9) rightLabelColour = newElementColour;                 //    colLabelRight
   
   
   colourPickers[numToSet].setColour(newElementColour); 
  
}










