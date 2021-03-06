// P_1_2_2_01.pde
/*
 * KEYS
 * 1-3                 : load different images
 * 4                   : no color sorting
 * 5                   : sort colors on hue
 * 6                   : sort colors on saturation
 * 7                   : sort colors on brightness
 * 8                   : sort colors on grayscale (luminance)
 * s                   : save png
 * p                   : save pdf
 * c                   : save color palette
 */

import generativedesign.*;
import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

PImage img;

int currentIndex = 0;
ArrayList<PImage> pictureList;
color[] colors;

String sortMode = GenerativeDesign.HUE;

void setup(){
  size(600, 700);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  noCursor();
  pictureList = new ArrayList<PImage>();

  pictureList.add(loadImage("Bild1.jpg"));
  pictureList.add(loadImage("Bild2.jpg"));
  pictureList.add(loadImage("Bild3.jpg"));
  pictureList.add(loadImage("Bild4.jpg"));
  pictureList.add(loadImage("Bild5.jpg"));
  pictureList.add(loadImage("Bild6.jpg"));
  pictureList.add(loadImage("Bild7.jpg"));
  pictureList.add(loadImage("Bild8.jpg"));
  pictureList.add(loadImage("Bild9.jpg"));
  pictureList.add(loadImage("Bild10.jpg"));
  
  //img = loadImage("pic1.jpg"); 
}


void draw(){
  if (savePDF) {
    beginRecord(PDF, timestamp()+".pdf");
    colorMode(HSB, 360, 100, 100, 100);
    noStroke();
  }
  img = pictureList.get(currentIndex);
  size(img.width, img.height);

  //int tileCount = width;
  int tileCount = width / max(mouseX, 5);
  float rectSize = width / float(tileCount);

  // get colors from image
  int i = 0; 
  colors = new color[tileCount*tileCount];
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      int px = (int) (gridX * rectSize);
      int py = (int) (gridY * rectSize);
      colors[i] = img.get(px, py);
      i++;
    }
  }

  // sort colors
  if (sortMode != null) colors = GenerativeDesign.sortColors(this, colors, sortMode);

  // draw grid
  i = 0;
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      fill(colors[i]);
      rect(gridX*rectSize, gridY*rectSize, rectSize, rectSize);
      i++;
    }
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void keyReleased(){
  if (key=='c' || key=='C') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
  if (key=='p' || key=='P') savePDF = true;
  if (key=='r' || key=='R') currentIndex = (int) random(0, pictureList.size()-1);
 
  if (key == '5') sortMode = GenerativeDesign.HUE;
  if (key == '6') sortMode = GenerativeDesign.SATURATION;
  if (key == '7') sortMode = GenerativeDesign.BRIGHTNESS;
  //if (key == '8') sortMode = null;
  if (key == '8') sortMode = GenerativeDesign.GRAYSCALE;
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}












