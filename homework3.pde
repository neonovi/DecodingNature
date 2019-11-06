CA ca;  
int[] ruleset = {0, 0, 2, 2, 1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2};
void setup() {
  size(1280, 640);
  background(0);
 
  ca = new CA(ruleset);            
}

void draw() {

  ca.render();    
  ca.generate(); 

  int red=#FF0000;
  int green = #00FF00;
  int blue = #0000FF;
  int counter =0;
  int counter1 =0;
  int hite=0;
  noStroke();
  fill(255);
  rect(0,height-90, 360, 95 );
  rect(360,height-30, 450, 30);
  stroke(0);
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
  String s= "Ruleset #: ";
  stroke(0);
  for (int i=0; i<27; i++){
    s+= str(ca.rules[i]);}
  fill(0);
  textSize(20);
  text(s, 360, height-10);
  
}

void mousePressed() {
  background(0); 
  ca.randomize(); 
  ca.restart();
}

class CA {

  int[] cells; 
  int generation;
  int scl; // 

  int[] rules;

  CA(int[] r) {
    rules = r; 
    scl = 2; 
    cells = new int[width/scl]; 
    restart();
  }


  void setRules(int[] r) {
    rules = r;
  }

 
  void randomize() {
    for (int i = 0; i < 27; i++) {
      rules[i] = int(random(3));
    }
  }


  void restart() {
    for (int i = 0; i < cells.length; i++) {
      cells[i] = int(random(3));
    }
    cells[cells.length/2] = 1; 
    generation = 0;
  }


  void generate() {
 
    int[] nextgen = new int[cells.length]; 

    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1];
      int me = cells[i]; 
      int right = cells[i+1]; 
      nextgen[i] = executeRules(left, me, right); 
    }

    for (int i = 1; i < cells.length-1; i++) {
      cells[i] = nextgen[i];
    }
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

  boolean finished() {
    if (generation > height/scl) {
      return true;
    } else {
      return false;
    }
  }
}
