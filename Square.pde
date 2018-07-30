class Square {
  int xpos;
  int ypos;
  boolean left;
  int movementSize = width/55;
  Square(boolean side, int startX, int startY) {
    xpos = startX;
    ypos = startY;
    left = side;
  }

  void display() {
    noFill();
    strokeWeight(2);
    rect(xpos, ypos, 20, 20);
  }


  void move() {
    if (left) {
      if (key == 'w' && ypos > 0) {
        ypos -= movementSize;
      }
      if (key == 'a' && xpos > 0) {
        xpos -= movementSize;
      }
      if (key == 's' && (ypos + movementSize) < height) {
        ypos += movementSize;
      }
      if (key == 'd' && (xpos + movementSize) < 400) {
        xpos += movementSize;
      }
    } else {
      if (key == CODED) {
        if (keyCode == UP && ypos > 0 ) {
          ypos -= movementSize;
        }
        if (keyCode == LEFT && xpos > 400) {
          xpos -= movementSize;
        }
        if (keyCode == DOWN && (ypos + movementSize) < height) {
          ypos += movementSize;
        }
        if (keyCode == RIGHT && (xpos + movementSize) < 800) {
          xpos += movementSize;
        }
      }
    }
  }
}
