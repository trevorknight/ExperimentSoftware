class PlayButton {
  float x;
  float y;
  float d;

  PlayButton (float x_, float y_, float d_) {
    x = x_;
    y = y_;
    d = d_;
  }

  boolean contains(float mx, float my) {
    if (dist(mx, my, x, y) < d/1.25) {
      return true;
    } 
    else {
      return false;
    }
  }

  void displayStopped(float mx, float my) {
    noFill();
    stroke(0);
    strokeWeight(1);
    ellipseMode(CENTER);
    ellipse(x, y, d, d);
    if (contains(mx, my)) {
      fill(42, 211, 28);
    }
    else {
      noFill();
    }
    triangle(x-17, y-22, x-17, y+22, x+25, y);
  }

  void displayPlaying(float mx, float my) {
    noFill();
    stroke(0);
    strokeWeight(1);
    ellipseMode(CENTER);
    ellipse(x, y, d, d);
    if (contains(mx, my)) {
      fill(240, 22, 22);
    }
    else {
      noFill();
    }
    rectMode(CENTER);
    rect(x, y, d/2, d/2);
    stroke(240, 22, 22);
  }
}

