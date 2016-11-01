import peasy.*;

int DOTS = 50;
float MAX_SPEED = 3.0;
float DIST2 = 50 * 50;

PeasyCam cam;
ArrayList<Dot> dots = new ArrayList<Dot>(DOTS);

void setup() {
  size(640, 360);
  cam = new PeasyCam(this, 100);
  for (int i = 0 ; i < DOTS ; i++) {
    dots.add(new Dot());
  }
}

void draw() {
  background(0);
  for (Dot dot : dots) {
    dot.draw();
  }
  for (int i = 0 ; i < DOTS ; i++) {
    Dot idot = dots.get(i);
    for (int j = i + 1 ; j < DOTS ; j++) {
      Dot jdot = dots.get(j);
      if (sq(idot.x - jdot.x) + sq(idot.y - jdot.y) < DIST2) {
        line(idot.x, idot.y, jdot.x, jdot.y);
      }
    }
  }
}

class Dot {
  PVector pos;
  PVector vel;
  color c;
  
  Dot() {
    pos = PVector.random2D();
    pos.mult(height);
    vel = PVector.random2D();
    vel.mult(MAX_SPEED);
    c = color(random(0, 256), random(0, 256), random(0, 256));
  }
  
  void draw() {
    pos.add(vel);
    // wrap
    pos.x = (pos.x + width) % width; 
    pos.y = (pos.y + height) % height;
    fill(0);
    stroke(c);
    strokeWeight(5);
    point(pos.x, pos.y);
  }
}