boolean gameOver = false;
int size = 40;
int boxSize; 
boolean drawMode = true;
boolean gameTime = false;
int[][] grid = new int [size][size];
ArrayList<Integer>iDeath = new ArrayList<Integer>();
ArrayList<Integer>jDeath = new ArrayList<Integer>();
int counter = 0;
int greenTimer;
ArrayList<Integer>iLifegreen = new ArrayList<Integer>();
ArrayList<Integer>jLifegreen = new ArrayList<Integer>();
ArrayList<Integer>iLifered = new ArrayList<Integer>();
ArrayList<Integer>jLifered = new ArrayList<Integer>();
Square leftSide;  
Square rightSide;
Blueprints glider;
Blueprints lwss;
int redTimer;
int gameTimer;
boolean redOver = false;
Blueprints rpenta;
Blueprints pulsar;
int counter1 = 0;
void setup() {

  size(1100, 800);
  boxSize = height / size;
  leftSide = new Square(true, 0, 0);
  rightSide = new Square(false, 780, 0);
  glider = new Blueprints("Glider", 825, 500);
  lwss = new Blueprints("LWSS", 945, 500);
  rpenta = new Blueprints("R-Pentamino", 825, 660);
  pulsar = new Blueprints("Pulsar", 945, 660);
}


void draw() {
  background(0);

  fill(255, 255, 255);
  text("Conway's Game of Life 2P", 825, 50); 

  text("Made by Daniel B. with help from Jonas R.", 810, 100);
  text("Ported to the web by Jonas R.", 845, 125);
  if (!redOver || !(greenTimer >= 3600)) {
    glider.setTemp();
    glider.display();
    lwss.setTemp();
    lwss.display();
    rpenta.setTemp();
    rpenta.display();
    pulsar.setTemp();
    pulsar.display();
  }
  if (counter >= 7 && !drawMode) {
    gameoflife();
    gameofdeath();
    counter = 0;
  }
  if (gameTime && !redOver)
    redTimer += 1;
  counter += 1;
  strokeWeight(1);
  for (int i = 0; i < size; i++) { 
    for (int j = 0; j < size; j++) {
      if (grid[i][j] == 1) {
        stroke(0);
        fill(255, 0, 0);
      } else if (grid[i][j] == 2) {
        stroke(0);
        fill(0, 255, 0);
      } else if (grid[i][j] == 0) {
        stroke(0);
        fill(255);
      }
      rect(j*20, i*20, boxSize, boxSize);
    }
  }
  if (redTimer  >= 3600) {
    redOver = true;
    redTimer = 0;
    gameTime = false;
  }
  if (redOver && greenTimer >= 3600) {

    if (getGreenBlocks() == 0  && getRedBlocks() == 0 || gameTimer >= 4800 && getGreenBlocks() == getRedBlocks()) {
      fill(0, 0, 0);


      gameOver = true;
      grid = tie();
      display();
      stop();
    } else if (getGreenBlocks() == 0 ||( (80 - int(gameTimer/60)) <= 0 && getRedBlocks() > getGreenBlocks())) {
      gameOver = true;
      grid = redWin();
      display();
      stop();
    } else if (getRedBlocks() == 0 ||( (80 - int(gameTimer/60)) <= 0 && getGreenBlocks() > getRedBlocks())) {

      gameOver = true;
      grid = greenWin();
      display();
      stop();
    }
  }

  fill(255, 255, 255);

  text("Instructions:", 850, 350);
  if (greenTimer >= 3600) {

    gameTimer += 1;
    fill(255, 255, 255);

    text("\u2660 Shift to end game", 825, 375);
    drawMode = false;
    fill(255, 255, 255);

    text("Game time left: " + (80 - int(gameTimer/60)), 850, 200);
    if (!gameOver) {
      text(getRedBlocks() + " red blocks", 850, 250);
      text(getGreenBlocks() + " green blocks", 850, 300);
    }
  }
  if (redTimer < 3600 && !redOver) {
    glider.good = true;
    lwss.good = true;
    rpenta.good = true;
    pulsar.good = true;

    fill(255, 255, 255);
    text("\u2660 Enter to start your turn", 825, 375);
    text("\u2660 Arrow Keys to move", 825, 400);
    text("\u2660 Space to place and remove blocks", 825, 425);
    text("\u2660 Shift to end your turn", 825, 450);
    fill(255, 255, 255);

    text("Red time left: " + (60-int(redTimer/60)), 850, 200);
    text("Green time left: 60", 850, 225);
    stroke(0, 0, 0);
    rightSide.display();
    fill(0);
    rect(0, 0, 400, 800);
  }

  if (greenTimer < 3600 && redOver) { 
    glider.good = false;
    lwss.good = false;
    rpenta.good = false;
    pulsar.good = false;

    fill(255, 255, 255);
    text("\u2660 Enter to start your turn", 825, 375);
    text("\u2660 WASD to move", 825, 400);
    text("\u2660 Space to place and remove blocks", 825, 425);
    text("\u2660 Shift to end your turn", 825, 450);
    fill(0); 
    rect(400, 0, 400, 800);
    fill(255, 255, 255);

    text("Red time left: 0", 850, 200);
    text("Green time left: " + (60-int(greenTimer/60)), 850, 225);
    stroke(0, 0, 0);
    leftSide.display();
  }

  if (greenTimer < 3600 && redOver && gameTime) {
    greenTimer += 1;
  }

  stroke(0, 0, 0);
  strokeWeight(3);
  line(400, height, 400, 0);
}


void keyPressed() {
  if (gameTime && redTimer <= 3600) {
    rightSide.move();
  } 
  if (gameTime && greenTimer <= 3600 && redOver) {
    leftSide.move();
  }  

  if (key == ' ' && redOver && gameTime) {
    if (grid[leftSide.ypos/boxSize][leftSide.xpos/boxSize] == 2) {
      grid[leftSide.ypos/boxSize][leftSide.xpos/boxSize] = 0;
    } else if (grid[leftSide.ypos/boxSize][leftSide.xpos/boxSize] == 1) {
      grid[leftSide.ypos/boxSize][leftSide.xpos/boxSize] = 0;
    } else if (grid[leftSide.ypos/boxSize][leftSide.xpos/boxSize] == 0) {
      grid[leftSide.ypos/boxSize][leftSide.xpos/boxSize] = 2;
    }
  }

  if (key == ' ' && !redOver) {
    if (grid[rightSide.ypos/boxSize][rightSide.xpos/boxSize] == 1) {
      grid[rightSide.ypos/boxSize][rightSide.xpos/boxSize] = 0;
    } else if (grid[rightSide.ypos/boxSize][rightSide.xpos/boxSize] == 2) {
      grid[rightSide.ypos/boxSize][rightSide.xpos/boxSize] = 0;
    } else if (grid[rightSide.ypos/boxSize][rightSide.xpos/boxSize] == 0) {
      grid[rightSide.ypos/boxSize][rightSide.xpos/boxSize] = 1;
    }
  }
  if (keyCode == SHIFT) {
    if (greenTimer < 3600 && redOver) {
      greenTimer = 3600;
    } else if (greenTimer >= 3600 && redOver && gameTime) {
      gameTimer = 4800;
    }
    if (redTimer < 3600 && gameTime) {
      redTimer = 3600;
      gameTime = false;
    }
  }

  if (keyCode == ENTER) {
    counter = 0;
    gameTime = true;
  }
}


void gameoflife() {
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      int nbrz = 0;
      int grnbrz = 0;
      int rednbrz = 0;
      int up = (j-1)%size;
      int left = (i-1)%size;
      if (up<0) {
        up = size-1;
      }
      if (left<0) {
        left = size - 1;
      }
      if (grid[(i+1)%size][up] == 1 || grid[(i+1)%size][up] == 2) {
        nbrz += 1;
        if (grid[(i+1)%size][up] == 1)
          rednbrz += 1;
        else
          grnbrz += 1;
      }
      if (grid[(i+1)%size][j] == 1 || grid[(i+1)%size][j] == 2) {
        nbrz += 1;
        if (grid[(i+1)%size][j] == 1)
          rednbrz += 1;
        else
          grnbrz += 1;
      }
      if (grid[(i+1)%size][(j+1)%size] == 1 || grid[(i+1)%size][(j+1)%size] == 2) {
        nbrz += 1;
        if (grid[(i+1)%size][(j+1)%size] == 1)
          rednbrz += 1;
        else
          grnbrz += 1;
      }
      if (grid[i][up] == 1 || grid[i][up] == 2) {
        nbrz += 1;
        if (grid[i][up] == 1)
          rednbrz += 1;
        else
          grnbrz += 1;
      }
      if (grid[i][(j+1)%size] == 1 || grid[i][(j+1)%size] == 2) {
        nbrz += 1;
        if (grid[i][(j+1)%size] == 1)
          rednbrz += 1;
        else
          grnbrz += 1;
      }
      if (grid[left][up] == 1 || grid[left][up] == 2) {
        nbrz += 1;
        if (grid[left][up] == 1)
          rednbrz += 1;
        else
          grnbrz += 1;
      }
      if (grid[left][j] == 1 || grid[left][j] == 2) {
        nbrz += 1;
        if (grid[left][j] == 1)
          rednbrz += 1;
        else
          grnbrz += 1;
      }
      if (grid[left][(j+1)%size] == 1 || grid[left][(j+1)%size] == 2) {
        nbrz += 1;
        if (grid[left][(j+1)%size] == 1)
          rednbrz += 1;
        else
          grnbrz += 1;
      }
      if (nbrz < 2) {
        iDeath.add(i);
        jDeath.add(j);
      }
      if (nbrz > 3) {
        iDeath.add(i);
        jDeath.add(j);
      }
      if (nbrz == 3 && grnbrz > rednbrz) {
        iLifegreen.add(i);
        jLifegreen.add(j);
      }
      if (nbrz == 3 && grnbrz < rednbrz) {
        iLifered.add(i);
        jLifered.add(j);
      }
    }
  }
}



void gameofdeath() {
  for (int h = 0; h < iDeath.size(); h++) {
    grid[iDeath.get(h)][jDeath.get(h)] = 0;
  }
  for (int k = 0; k < iLifered.size(); k++) {
    grid[iLifered.get(k)][jLifered.get(k)] = 1;
  }
  for (int k = 0; k < iLifegreen.size(); k++) {
    grid[iLifegreen.get(k)][jLifegreen.get(k)] = 2;
  }
  iDeath.clear();
  jDeath.clear();
  iLifered.clear();
  jLifered.clear();
  iLifegreen.clear();
  jLifegreen.clear();
}

boolean drawModeFalse() {
  if (drawMode) {
    return false;
  } else {
    return true;
  }
}

int getRedBlocks() {
  int redBlox = 0;
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (grid[i][j] == 1) redBlox += 1;
    }
  }
  return redBlox;
}

int getGreenBlocks() {
  int greenBlox = 0;
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (grid[i][j] == 2) greenBlox += 1;
    }
  }
  return greenBlox;
}


int[][] greenWin() {
  int[][] currentGrid = new int[size][size];
  wan Green = new wan(true, false);
  Green.display();
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      currentGrid[i][j] = Green.grid[i][j];
    }
  }
  return currentGrid;
}

int[][] redWin() {
  int[][] currentGrid = new int[size][size];
  wan red = new wan(false, false);
  red.display();
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      currentGrid[i][j] = red.grid[i][j];
    }
  }
  return currentGrid;
}

int[][] tie() {
  int[][] currentGrid = new int[size][size];
  wan tie = new wan(false, true);
  tie.display();
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      currentGrid[i][j] = tie.grid[i][j];
    }
  }
  return currentGrid;
}


void display() {
  strokeWeight(1);
  for (int i = 0; i < size; i++) { 
    for (int j = 0; j < size; j++) {
      if (grid[i][j] == 1) {
        stroke(0);
        fill(255, 0, 0);
      } else if (grid[i][j] == 2) {
        stroke(0);
        fill(0, 255, 0);
      } else if (grid[i][j] == 0) {
        stroke(0);
        fill(255);
      } else if (grid[i][j] == 3) {
        stroke(255);
        fill(0);
      }
      rect(j*20, i*20, boxSize, boxSize);
    }
  }
}
