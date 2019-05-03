import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.video.*;
Movie rice;
Kinect kinect;

PImage img;
PImage code;
PImage planet;
int d;
color[] colors;

PImage depthImg;
float min = 100;
float max =1000;

int wid = 1080;
int hei = 810;
float scale = 1.6875;

void setup() {
  //size(640, 1138); //640*480 -> 1080*810
  size(1080, 1920);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  img = loadImage("text.png");
  code = loadImage("code.png");
  planet = loadImage("riceplanet.png");
  rice = new Movie(this, "yellow_planet.mov");
  rice.loop();

  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();
  kinect.enableIR(true);

  depthImg = new PImage(wid, hei);
  //depthImg = new PImage(kinect.width, kinect.height);
}

void movieEvent(Movie m) {
  m.read();
}
void draw() {
  background(0);
  image(code, 0, 0);

  depthImg.loadPixels();
  int[] depth = kinect.getRawDepth();

  float sumX = 0;
  float sumY = 0;
  float sumDepth = 0;
  float totalPixels = 0;
  int   skip=3;

  //print(kinect.width);
  //print(kinect.height);
  for (int x  = 0; x < wid; x+=3) {
    for (int y  = 0; y < hei; y+=3) {
      //print(scale);
      int xscaled = int(x/scale);
      //print(xscaled);
      int yscaled = int(y/scale);
      //print(yscaled);
      int offset = int(xscaled +yscaled*kinect.width);
      //if (offset > 640*480) {
      //  offset = 640*480-2;
      //}
      //print(offset);
      d = depth[offset];
      if (d > min && d<max) {
        sumX += x;
        sumY += y;
        sumDepth += d;
        totalPixels++;
      }
    }
  }

  float avgX = sumX/(totalPixels+1);
  float avgY = sumY/(totalPixels+1);
  int avgDepth = int(sumDepth/(totalPixels+1));

  image(planet, avgX-80, avgY+578, 120, 120);

  skip = int(map(avgDepth, min, max, 50, 5));

  for (int x  = 0; x < wid; x+=skip) {
    for (int y  = 0; y < hei; y+=skip) {
      int xscaled = int(x/scale);
      int yscaled = int(y/scale);
      int offset = int(xscaled +yscaled*kinect.width);
      //if (offset > 640*480) {
      //  offset = 640*480-2;
      //}
      d = depth[offset];
      if (d > min && d<max) {
        //depthImg.pixels[offset]=color(120,0,150);
        float Cmap = map(d, min, max, 88, 10);
        fill(55, 100, 212, Cmap);
        //strokeWeight(3);
        stroke(55, 100, 212);
        rect(x, y+1100, skip, skip);
      } else {
        depthImg.pixels[offset]=color(0, 1);
      }
    }
  }
  depthImg.updatePixels();

  float avgDmap = map(avgDepth, min, max, 30, 3);
  int tileCount = int(wid / avgDmap);
  float rectSize = wid/tileCount;

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

  // draw grid
  i = 0;
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      fill(colors[i]);
      noStroke();

      rect(gridX*rectSize, gridY*rectSize, rectSize, rectSize);
      i++;
    }
  }

  image(depthImg, 0, 0);
  image(rice, 450, 520, 550, 550);
}
