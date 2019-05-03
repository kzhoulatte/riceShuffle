PImage img;
String text;
int humidity;

void setup() {
  size(400, 400);
  img = loadImage("a.png");
  background(0);
  image(img,100,100);
}

void draw() {
  
  
  
  String[] lines = loadStrings("humidity.txt");
  humidity = lines.length;
  String city = lines[0];
  
  
  textSize(30);
  fill(255);
  text(city, 50, 50);
  
  textSize(30);
  fill(255);
  text(humidity, 50, 20);
  
  int x1 = (int) random(0,width);
  int y1 = (int) random(0,height);
  
  float change = map(humidity,0,100,1,33);
  int x2 = round(x1 + random(-change, change));
  int y2 = round(y1 + random(-change, change));

  float cropSize = map(humidity,0,100,0,5);

  int w = 8+(int)cropSize;
  int h = 3+int(cropSize/3);

  copy(x1,y1, w,h, x2,y2, w,h);
  
}
