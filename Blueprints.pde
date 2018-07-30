class Blueprints {
  int xsize;
  int ysize;
  // int boxSize;
  int x;
  int y;
  String name;
  boolean good = true;
  int[][] sizeGrid;
  Blueprints(String topName, int  startx, int starty) {
    name = topName;
    //  size = Startsize;
    x = startx;
    y = starty;
  }
  void setTemp() {
    if (name == "Glider") {
      xsize = 5;
      ysize = 5;
      sizeGrid  = new int[ysize][xsize];
      sizeGrid[1][2] = 1;
      sizeGrid[2][3] = 1;
      sizeGrid[3][1] = 1;
      sizeGrid[3][2] = 1;
      sizeGrid[3][3] = 1;
    }

    if (name == "LWSS") {
      xsize = 7;
      ysize = 6;
      sizeGrid = new int[ysize][xsize];
      sizeGrid[1][1] = 1;
      sizeGrid[1][4] = 1;
      sizeGrid[2][5] = 1;
      sizeGrid[3][1] = 1;
      sizeGrid[3][5] = 1;
      sizeGrid[4][2] = 1;
      sizeGrid[4][3] = 1;
      sizeGrid[4][4] = 1;
      sizeGrid[4][5] = 1;
    }
    if (name == "R-Pentamino") {
      xsize = 5;
      ysize = 5;
      sizeGrid = new int[ysize][xsize];
      sizeGrid[1][2] = 1;
      sizeGrid[1][3] = 1;
      sizeGrid[2][1] = 1;
      sizeGrid[2][2] = 1;
      sizeGrid[3][2] = 1;
    }
    if (name == "Pulsar") {

      xsize = 7;
      ysize = 5;
      sizeGrid = new int[ysize][xsize];
      sizeGrid[1][1] = 1;
      sizeGrid[2][1] = 1;
      sizeGrid[3][1] = 1;
      sizeGrid[1][2] = 1;
      sizeGrid[3][2] = 1;
      sizeGrid[1][3] = 1;
      sizeGrid[3][3] = 1;
      sizeGrid[1][4] = 1;
      sizeGrid[3][4] = 1;
      sizeGrid[1][5] = 1;
      sizeGrid[2][5] = 1;
      sizeGrid[3][5] = 1;
    }
  }


  void display() {

    for (int i = 0; i < ysize; i++) {

      for (int j = 0; j < xsize; j++) {

        if (sizeGrid[i][j] == 1) {
          if (good) {
            fill(255, 0, 0);
          }
          if (!good) {
            fill(0, 255, 0);
          }
        } else {
          fill(255, 255, 255);
        }
        rect(x + (j * 20), y + (i * 20), boxSize, boxSize);
      }
    }
    textSize(15);
    fill(255, 255, 255);
    text(name, x, y - 15);
  }
}
