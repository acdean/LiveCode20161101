import peasy.*;

int DOTS = 100;
float MAX_SPEED = 3.0;
float DIST2 = 100 * 100;

PeasyCam cam;
ArrayList<Dot> dots = new ArrayList<Dot>(DOTS);
boolean video = false;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, 300);
  for (int i = 0 ; i < DOTS ; i++) {
    dots.add(new Dot());
  }
}

void draw() {
  background(0);
  for (Dot dot : dots) {
    dot.draw();
  }
  
  beginShape(LINES);
  for (int i = 0 ; i < DOTS ; i++) {
    Dot idot = dots.get(i);
    for (int j = i + 1 ; j < DOTS ; j++) {
      Dot jdot = dots.get(j);
      if (sq(idot.pos.x - jdot.pos.x) + sq(idot.pos.y - jdot.pos.y) < DIST2) {
        stroke(idot.c);
        vertex(idot.pos.x, idot.pos.y);
        stroke(jdot.c);
        vertex(jdot.pos.x, jdot.pos.y);
      }
    }
  }
  endShape();
  
  if (video) {
    saveFrame("frame#####.png");
    if (frameCount > 500) {
      exit();
    }
  }
}

class Dot {
  PVector pos;
  PVector vel;
  color c;
  
  Dot() {
    pos = new PVector(random(-width, width), random(-height, height));
    vel = PVector.random2D();
    vel.mult(MAX_SPEED);
    c = color(random(0, 256), random(0, 256), random(0, 256));
  }
  
  void draw() {
    pos.add(vel);
    // wrap
    if (pos.x < -width) {
      pos.x = width;
    }
    if (pos.x > width) {
      pos.x = -width;
    }
    if (pos.y < -height) {
      pos.y = height;
    }
    if (pos.y > height) {
      pos.y = -height;
    }
    fill(0);
    stroke(c);
    strokeWeight(5);
    point(pos.x, pos.y);
  }
}

void keyPressed() {
  saveFrame("frame####.png");
}