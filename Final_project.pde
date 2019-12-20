int numCrt = 300; 
int numFood = 1;
float goalX = 750;
float goalY = 750;
boolean locGoal = true;
boolean foodGoal = false;
boolean displayCrtNum = false;
boolean displayDataNum = true;
boolean displayCrt = true;
boolean moveableGoal = true;
int hugeMutChance = 2;
int skipping = 50;
float mapBordLow = 0.05;
float mapBordHigh = 0.95;


int chance = 0;
int milSeconds = 50;
int genNum = 0;
boolean sorted = false;
int synaxValue = 0;
boolean skipple = false;
boolean mouseClackle = false;
float crtAvg = 0;


Creature[] crt = new Creature[numCrt];

void setup() {
  fullScreen();
  //size(1000,1000);
  frameRate(20*skipping);
  smooth();
  for (int i=0; i<crt.length; i++) {
    crt[i] = new Creature(random(0), random(0));
  }
}

void draw() {
  if (moveableGoal == true) {
    goalX = mouseX;
    goalY = mouseY;
  }

  background(200);
  fill(100, 100, 255);
  rectMode(CORNERS);
  rect(width*mapBordLow, height*mapBordLow, width*mapBordHigh, height*mapBordHigh);

  for (int i=0; i<crt.length; i++) {
    crt[i].move();
  }  


  if (milSeconds == 50) {
    genNum += 1;
    milSeconds = 0;

    average();
    sortIt();
    generateIt();
  }


  skipGen();

  //display and constraint functions. Keeps the board nice and neat.
  updateAll();
  displayCrt();
  displayGoal();
  displayData();

  milSeconds += 1;
}

class Creature {
  float x, y;
  float size;
  color colour;
  float speed;
  float dir;

  float goalDistance;

  int pos;
  boolean done;

  Creature(float x, float y) {
    this.x = x;
    this.y = y;


    dir = radians(random(0, 360));

    goalDistance = sqrt(pow((x-goalX), 2) + pow((y-goalY), 2));
    colour = color(random(255), random(255), random(255));
    size = 10;
    speed = random(-4, 4);


    pos = crt.length;
  }


  void move() {
    x += speed*cos(dir);
    y += speed*sin(dir);
  }

  void update() {
    x = constrain(x, width*mapBordLow, width*mapBordHigh);
    y = constrain(y, height*mapBordLow, height*mapBordHigh);

    goalDistance = sqrt(pow((x-goalX), 2) + pow((y-goalY), 2));
  }

  void display() {
    if (displayCrt == true) {
      stroke(0);
      strokeWeight(1);
      fill(colour);
      ellipse(x, y, size, size);
    }

    if (displayCrtNum) {
      textSize(15);
      fill(255);
      text((int)goalDistance, x, y);
    }
  }
}

void displayCrt() {
  //draws creatures
  for (int i=0; i<crt.length; i++) {
    crt[i].display();
  }
}

void updateAll() {

  for (int i=0; i<crt.length; i++) {
    crt[i].update();
  }
}

void displayGoal() {

  if (locGoal == true) {
    strokeWeight(1);
    fill(255, 0, 0);
    ellipse(goalX, goalY, 20, 20);
  }
}

void sortIt() {
  if (sorted == false) {
    for (int i=0; i<crt.length; i++) {
      for (int w=0; w<crt.length; w++) {
        if (locGoal == true) {
          if (crt[i].goalDistance > crt[w].goalDistance) {
            crt[i].pos -= 1;
          }
        }
      }
    }

    for (int z=0; z<crt.length; z++) {
      for (int i=0; i<crt.length; i++) {
        for (int w=0; w<crt.length; w++) {
          if (crt[i].pos == crt[w].pos && crt[i] != crt[w]) {
            crt[i].pos -= 1;
          }
        }
      }
    }
  }
  sorted = true;
}


void generateIt() {
  println("");
  println("Generation:"+genNum);
  println("");
  synaxValue = 0;
  for (int i=0; i<crt.length; i++) {
    println("Creature#"+(synaxValue+1)+" - Angle:"+crt[i].dir+" GoalDistance:"+crt[i].goalDistance);
    synaxValue += 1;
    boolean tmp = false; 
    if (crt[i].pos < int(round(crt.length/2))) {
      for (int w=0; w<crt.length; w++) {
        if (crt[w].done == false && crt[w].pos >= int(round(crt.length/2)) && tmp == false) {
          crt[i].speed = crt[w].speed + random(-0.1, 0.1);
          crt[i].dir = crt[w].dir + random(-0.05, 0.05);
          crt[i].colour = crt[w].colour;

          randomizer();
          if (chance < hugeMutChance) {
            crt[i].speed += random(-1, 1);
            crt[i].colour = color(random(255), random(255), random(255));
          }
          randomizer();
          if (chance < hugeMutChance) {
            crt[i].dir += random(-1, 1);
            crt[i].colour = color(random(255), random(255), random(255));
          }

          crt[w].done = true;
          crt[i].done = true;
          tmp = true;
        }
      }
    }
  }

  for (int i=0; i<crt.length; i++) {
    crt[i].done = false;
    sorted = false;
    crt[i].pos = crt.length;  
    crt[i].x = random(0);
    crt[i].y = random(0);
  }
}

void skipGen() {
  if (mousePressed == true && mouseClackle == false) {
    mouseClackle = true;
    if (skipple == true) {
      skipple = false;
    } else if (skipple == false) {
      skipple = true;
    }
  }
  if (mousePressed == false) {
    mouseClackle = false;
  }
  if (skipple == true) {
    skipping = 100;
  }
  if (skipple == false) {
    skipping = 1;
  }
}


void displayData() {
  if (displayDataNum == true) {
    textSize(32);
    fill(255);
    text("MilSeconds:"+milSeconds+" Generation:"+genNum+" Average:"+int(crtAvg), width*mapBordLow, height*(mapBordHigh+0.04));
  }
}

void average() {
  float bAverage = 0;
  for (int i=0; i<crt.length; i++) {
    bAverage += crt[i].goalDistance;
  }
  crtAvg = bAverage/crt.length;
}

void randomizer() {
  chance = int(random(0, 101));
}
