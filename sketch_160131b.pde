PShape s;
PVector v[];
PVector p[];

float x, y, r;
int debug = 0;
boolean one;

PVector f1, f2;

PVector createVector(PVector v1, PVector v2) {
  return new PVector(v2.x - v1.x, v2.y - v1.y);
  
}

float dotProduct(PVector a, PVector b) {
  return (a.x*b.x) + (a.y*b.y);
  
}

float vectorLength(PVector v) {
  return dotProduct(v, v);
  
}

boolean isHitLine(PVector p[], float ex, float ey, float er) {
  PVector p1, p2;
  float dot, k, pqd2, pmd2, phd2, d2;
  
  PVector point = new PVector(ex, ey);
  
  final int n[][] = {{0,1,2,3}, {1,2,3,0}};
  for(int i = 0; i < s.getVertexCount(); i++) {
    p1 = createVector(p[n[0][i]], p[n[1][i]]);
    p2 = createVector(p[n[0][i]], point);
    
    dot = dotProduct(p1, p2);
    pqd2 = vectorLength(p1);
    pmd2 = vectorLength(p2);
    
    k = dot / pqd2;
    
    if(k < 0 || 1 < k) {
      continue;
    }
    
    phd2 = (dot*dot) / pqd2;
    d2 = pmd2 - phd2;
    
    if(d2 < er*er ) {
      return true;
      
    }
    
  }
  
  return false;
}

void setup() {
  size(640, 360, P2D);
  rectMode(CENTER);
  s = createShape(RECT, 0, 0, 140, 260);
  v = new PVector[s.getVertexCount()];
  one = false;
  
}


void draw() {
  background(255);
  noFill();
  shape(s, width / 2, height / 2);
  x = mouseX;
  y = mouseY;
  r = 20;
  ellipse(x, y, r*2, r*2);
  
  for(int i = 0; i < s.getVertexCount(); i++) {
    v[i] = s.getVertex(i);
    v[i].x = v[i].x + width / 2;
    v[i].y = v[i].y + height / 2;
    
  }
   
}

void mouseReleased() {
  one = true;
  if(isHitLine(v, x, y, r) && one) {
    debug += 1;
    println("Hit" + debug);
    
    one = false;
  }
  
}