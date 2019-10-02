
class Stars {
  float mass;
  PVector location;
  float G;
  
  Stars(float x, float y) {
    location = new PVector(x, y);
    mass = 40;
    G = 0.4;
  }

  PVector attract(Planets m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();

    distance = constrain(distance, 10.0, 25.0);

    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display() {
    noStroke();
    fill(175, 200);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}


class Planets {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;

  Planets(float x, float y, float vx, float vy, float ma) {
    mass = ma;
    location = new PVector(x, y);
    velocity = new PVector(vx, vy);
    acceleration = new PVector(0, 0);
  }
  void applyForce(PVector force, float mass) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    noStroke();
    fill(175);
    fill(random(255), random(255), random(255));
    ellipse(location.x, location.y, mass*16, mass*16);
  }
}


int Planetss = 10000;
Planets[] m = new Planets[Planetss];
boolean flag = false;
int numPlanets=0;
float X_move=0;
float Y_move=0;
Stars a;
PVector line_start;
PVector line_end;
PVector velocity1;
PGraphics pg;
int iterator=0;
float initMass=0.5;
float multi = 0.05;

void setup() {
  fullScreen();
  //size(1280, 720);
  line_start = new PVector(0, 0);
  line_end = new PVector(0, 0);
  velocity1 = new PVector(0, 0);
  a = new Stars(width/2, height/2);
  background(255);
  frameRate(60);
}

void mousePressed()
{
  if (iterator%2 ==0)
  {
    line_start = new PVector(mouseX, mouseY);
    line_end = new PVector(mouseX, mouseY);
  }
  if (iterator%2 ==1)
  {
    line_end = new PVector (mouseX, mouseY);
    velocity1.x = line_end.x-line_start.x;
    velocity1.y = line_end.y-line_start.y;
    stroke(255,0,0);
    strokeWeight(5);
    line(line_start.x, line_start.y, line_end.x, line_end.y);
    m[numPlanets] = new Planets (mouseX, mouseY, velocity1.x/30, velocity1.y/30, initMass);
    numPlanets++;
  }
  iterator++;
}

void keyPressed()
{
  if (keyCode == 32)
  {
    numPlanets = 0;
  }
  if (keyCode == 47)
  {
    m[numPlanets] = new Planets (mouseX, mouseY, velocity1.x/30, velocity1.y/30, initMass);
    numPlanets++;
  }
}

void draw() {


  pushMatrix();
  fill(0, 40);
  noStroke();
  rect(0, 0, width, height);
  popMatrix();
  PVector force;
  String s = "number of planets: "+numPlanets;
  textSize(16);
  fill(128);
  text("To spawn a planet, click twice", 10, 30);
  text("'space' to reset", 10, 50);
  text("The distance between your clicks is the initial velocity of a planet", 10, 70);
  text(s, 10, 90);
  text("Initial mass", width/2-50, 80);
  initMass = initMass + multi;
  if (initMass >= 5 || initMass <=0.5)
  {
    multi *= -1;
  }
  fill(255, 0, 0);
  noStroke();
  rect(width/2-50, 10, initMass*100, 50);
  for (int i=0; i<numPlanets; i++)
  {
    force = a.attract(m[i]);
    m[i].applyForce(force, initMass);
    m[i].update();
  }
  a.display();
  for (int i=0; i<numPlanets; i++)
  {
    m[i].display();
  }
  velocity1.x=0;
  velocity1.y=0;
}
