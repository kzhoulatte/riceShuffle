class Crop {
  int tileCount = 4;
  PImage[] imageTiles = new PImage[tileCount];

  int tileWidth, tileHeight;

  int cropX = 0;
  int cropY = 0;

  float pX;
  float pY;
  float d;

  int ii;
  //int frameNum = 10;
  PImage[] images0 = new PImage[10];
  PImage img0;

  Crop(int frameNum, int start, int tempX, int tempY, int tempW, int tempH, int tempD) {

    pX = tempX;
    pY = tempY;
    tileWidth = tempW;
    tileHeight = tempH;
    d = tempD;
    if (start==0) {
      for (int i = 0; i< frameNum; i++) {
        images0[i] = loadImage(i+".png");
      }
    } else {
      images0[frameNum] = loadImage(frameNum+".png");
    }
  }

  void display() {
    // reassemble image
    int i = 0;
    for (int gridX = 0; gridX < tileCount; gridX++) {
      image(imageTiles[i], pX+random(-d, d), pY+random(-d, d));
      i++;
    }
  }

  void cropTiles(int num) {

    imageTiles = new PImage[tileCount];
    int i = 0;
    for (int gridX = 0; gridX < tileCount; gridX++) {
      cropX = (int) random(pX-tileWidth/6, pX+tileWidth/6);
      cropY = (int) random(pY-tileHeight/6, pY+tileHeight/6);
      ii = (int) random(0, num);
      //print(ii);
      img0 = images0[ii];
      img0.resize(width, img0.height*width/img0.width);
      blend(bg, 0, 0, 1080, 1920, 0, 0, 1080, 1920, LIGHTEST);
      imageTiles[i++] = img0.get(cropX, cropY, tileWidth, tileHeight);
    }
  }
}
