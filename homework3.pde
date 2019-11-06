CA ca;   // An instance object to describe the Wolfram basic Cellular Automata
int[] ruleset = {0, 0, 2, 2, 1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2};
void setup() {
  size(1280, 640);

  // An initial rule system
  ca = new CA(ruleset);                 // Initialize CA
  background(0);
}

void draw() {

  ca.render();    // Draw the CA
  ca.generate();  // Generate the next level

  //if (ca.finished()) {   // If we're done, clear the screen, pick a new ruleset and restart
  //delay(5000);
  //  background(0);
  //  ca.randomize();
  //  ca.restart();
  //  stroke(0);
  //}
  int red=#FF0000;
  int green = #00FF00;
  int blue = #0000FF;
  int counter =0;
  int counter1 =0;
  int hite=0;
  stroke(0);
  fill(255);
  rect(0,height-90, 360, 95 );
  for (int i=0; i<27; i++) {
    if (i<9) {
      fill(red);
      hite = 85;
    } else if (i<18 && i>=9) {
      fill(green);
      hite = 55;
    } else if (i>=18) {
      fill(blue);
      hite = 25;
    }

    rect(5+i%9*40, height-hite, 10, 10);
    if (counter%3==0) {
      fill(red);
    }
    if (counter%3==1) {
      fill(green);
    }
    if (counter%3==2) {
      fill(blue);
    }
    if (i%3==2) {
      counter+=1;
    }
    rect(15+i%9*40, height-hite, 10, 10);
    if (counter1%3==0) {
      fill(red);
    }
    if (counter1%3==1) {
      fill(green);
    }
    if (counter1%3==2) {
      fill(blue);
    }
    counter1+=1;
    rect(25+i%9*40, height-hite, 10, 10);
  }
  for (int i=0; i<9; i++) {
    if (ca.rules[i]==0) {
      fill(red);
    } else if (ca.rules[i]==1) {
      fill(green);
    } else if (ca.rules[i]==2) {
      fill(blue);
    }
    rect(15+i%9*40, height-75, 10, 10);
  }
  for (int i=9; i<18; i++) {
    if (ca.rules[i]==0) {
      fill(red);
    } else if (ca.rules[i]==1) {
      fill(green);
    } else if (ca.rules[i]==2) {
      fill(blue);
    }
    rect(15+i%9*40, height-45, 10, 10);
  }
  for (int i=18; i<27; i++) {
    if (ca.rules[i]==0) {
      fill(red);
    } else if (ca.rules[i]==1) {
      fill(green);
    } else if (ca.rules[i]==2) {
      fill(blue);
    }
    rect(15+i%9*40, height-15, 10, 10);
  }
  delay(30);
}


void mousePressed() {
  background(0); 
  ca.randomize(); 
  ca.restart();
}






class CA {

  int[] cells; // An array of 0s and 1s 
  int generation; // How many generations?
  int scl; // How many pixels wide/high is each cell?

  int[] rules; // An array to store the ruleset, for example {0,1,1,0,1,1,0,1}

  CA(int[] r) {
    rules = r; 
    scl = 2; 
    cells = new int[width/scl]; 
    restart();
  }

  // Set the rules of the CA
  void setRules(int[] r) {
    rules = r;
  }

  // Make a random ruleset
  void randomize() {
    for (int i = 0; i < 27; i++) {
      rules[i] = int(random(3));
    }
  }

  // Reset to generation 0
  void restart() {
    for (int i = 0; i < cells.length; i++) {
      cells[i] = int(random(3));
    }
    cells[cells.length/2] = 1; // We arbitrarily start with just the middle cell having a state of "1"
    generation = 0;
  }

  // The process of creating the new generation
  void generate() {
    // First we create an empty array for the new values
    int[] nextgen = new int[cells.length]; 
    // For every spot, determine new state by examing current state, and neighbor states
    // Ignore edges that only have one neighor
    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1]; // Left neighbor state
      int me = cells[i]; // Current state
      int right = cells[i+1]; // Right neighbor state
      nextgen[i] = executeRules(left, me, right); // Compute next generation state based on ruleset
    }
    // Copy the array into current value
    for (int i = 1; i < cells.length-1; i++) {
      cells[i] = nextgen[i];
    }
    //cells = (int[]) nextgen.clone();
    generation++;
  }
  void render() {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == 0) {
        fill(255, 0, 0);
      } else if (cells[i]==1) {
        fill(0, 255, 0);
      } else if (cells[i]==2) {
        fill(0, 0, 255);
      }
      noStroke(); 
      rect(i*scl, generation*scl, scl, scl);
    }
  }


  int executeRules (int a, int b, int c) {

    if (a == 0 && b == 0 && c == 0) { 
      return rules[0];
    }
    if (a == 0 && b == 0 && c == 1) { 
      return rules[1];
    }
    if (a == 0 && b == 0 && c == 2) { 
      return rules[2];
    }
    if (a == 0 && b == 1 && c == 0) { 
      return rules[3];
    }
    if (a == 0 && b == 1 && c == 1) { 
      return rules[4];
    }
    if (a == 0 && b == 1 && c == 2) { 
      return rules[5];
    }
    if (a == 0 && b == 2 && c == 0) { 
      return rules[6];
    }
    if (a == 0 && b == 2 && c == 1) { 
      return rules[7];
    }
    if (a == 0 && b == 2 && c == 2) { 
      return rules[8];
    }
    if (a == 1 && b == 0 && c == 0) { 
      return rules[9];
    }
    if (a == 1 && b == 0 && c == 1) { 
      return rules[10];
    }
    if (a == 1 && b == 0 && c == 2) { 
      return rules[11];
    }
    if (a == 1 && b == 1 && c == 0) { 
      return rules[12];
    }
    if (a == 1 && b == 1 && c == 1) { 
      return rules[13];
    }
    if (a == 1 && b == 1 && c == 2) { 
      return rules[14];
    }
    if (a == 1 && b == 2 && c == 0) { 
      return rules[15];
    }
    if (a == 1 && b == 2 && c == 1) { 
      return rules[16];
    }
    if (a == 1 && b == 2 && c == 2) { 
      return rules[17];
    }
    if (a == 2 && b == 0 && c == 0) { 
      return rules[18];
    }
    if (a == 2 && b == 0 && c == 1) { 
      return rules[19];
    }
    if (a == 2 && b == 0 && c == 2) { 
      return rules[20];
    }
    if (a == 2 && b == 1 && c == 0) { 
      return rules[21];
    }
    if (a == 2 && b == 1 && c == 1) { 
      return rules[22];
    }
    if (a == 2 && b == 1 && c == 2) { 
      return rules[23];
    }
    if (a == 2 && b == 2 && c == 0) { 
      return rules[24];
    }
    if (a == 2 && b == 2 && c == 1) { 
      return rules[25];
    }
    if (a == 2 && b == 2 && c == 2) { 
      return rules[26];
    }

    return 0;
  }

  // The CA is done if it reaches the bottom of the screen
  boolean finished() {
    if (generation > height/scl) {
      return true;
    } else {
      return false;
    }
  }
}
