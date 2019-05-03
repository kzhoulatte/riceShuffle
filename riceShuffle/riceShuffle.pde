import processing.video.*;
Movie what;

PImage bg;

Crop c0;
Crop c1;
Crop c2;
Crop c3;
Crop c4;

int timestart = millis();
int num =1;
int maxnum = 10;

void setup() {
  size(1080, 1920); 
  background(0);
  what = new Movie(this, "what_1.mp4");
  what.loop();

  bg = loadImage("bg.png");

  //image(img, 0, 0);

  
  c3 = new Crop(maxnum, 0,int(width/1.7), int(height/30), (int)random(int(width/3.8), int(width/3.8+5)), (int)random(int(height/4.2), int(height/4.2+10)), 1);
  c2 = new Crop(maxnum, 0,int(width/6.3), int(height/12), (int)random(int(width/2.1), int(width/2.1)+5), (int)random(int(height/3), int(height/3)+5), 3);
  c1 = new Crop(maxnum, 0,int(width/2.4), int(height/3.6), (int)random(int(width/2), int(width/2)+3), (int)random(int(height/2.3), int(height/2.3)+3), 8);
  c4 = new Crop(maxnum, 0,int(width/1.8), int(height/2.25), (int)random(int(width/3.2), int(width/3.2)+30), (int)random(int(height/4.8), int(height/4.8)+30), 3);
  c0 = new Crop(maxnum, 0,int(width/8), int(height/2.6), (int)random(int(width/2.5), int(width/2.5)+30), (int)random(int(height/3.2), int(height/3.2)+5), 5);
  
  
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  
  background(0);
  
  int timenow = millis();
  int timefly = timenow-timestart;
  //print(num+"\n");
  
  if (timefly > 20000 && num<10){
  timestart = timenow;
  num = num+1;
  print(timefly+"\n");
  print(num+"\n");
  
  }
    
  

  c1.cropTiles(num);
  c1.display(); 

  c3.cropTiles(num);
  c3.display(); 

  c4.cropTiles(num);
  c4.display();

  c2.cropTiles(num);
  c2.display();

  c0.cropTiles(num);
  c0.display();
  
  image(what, 30, height-340, 1080, 180);
}
