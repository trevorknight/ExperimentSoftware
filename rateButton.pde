class rateButton {
    
  // Variables
  String name;
  int x;
  int y;
  int w;
  int h;

  //Constructor
  rateButton(int tempx, int tempy, int tempw, int temph, String templabel) {
    x = tempx;
    y = tempy;
    w = tempw;
    h = temph;
    name = templabel;
  }
  
  void display() {
    rectMode(CENTER);
    textMode(CENTER);
    strokeWeight(2);
    stroke(0);
    fill(255);
    rect(x,y,w,h);
    if (!played) {
      fill(160);
      stroke(160);
    }
    else {
      fill(0);
      stroke(0);
    }
    textAlign(CENTER);
    text(name,x,y+5);
  }
  
  boolean pressed() {
    return (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2);
  }
}
  

