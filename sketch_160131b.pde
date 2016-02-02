PShape shape;
PVector vertices[];
PVector mousePos;

float r;
//=====================
// Debug
int debug = 0;
PVector f1, f2;

//=====================

PVector CreateVector(PVector v1, PVector v2) {
  return new PVector(v2.x - v1.x, v2.y - v1.y);
  
}

float DotProduct(PVector a, PVector b) {
  return (a.x*b.x) + (a.y*b.y);
  
}

float VectorLength(PVector v) {
  return DotProduct(v, v);
  
}

boolean isHitLine(PVector p[], PVector mp, float er) {
  PVector p1, p2;
  float dot, k, pqd2, pmd2, phd2, d2;
  
  PVector point = new PVector(mp.x, mp.y);
  
  final int n[][] = {{0,1,2,3}, {1,2,3,0}};
  for(int i = 0; i < shape.getVertexCount(); i++) {
    p1 = CreateVector(p[n[0][i]], p[n[1][i]]);
    p2 = CreateVector(p[n[0][i]], point);
    
    dot = DotProduct(p1, p2);
    pqd2 = VectorLength(p1);
    pmd2 = VectorLength(p2);
    
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
  
  shape = createShape(RECT, 0, 0, 140, 260);
  vertices = new PVector[shape.getVertexCount()];
  
}


void draw() {
  background(255);
  noFill();
  
  mousePos = new PVector(mouseX, mouseY);
  r = 20;
  shape(shape, width / 2, height / 2);
  ellipse(mousePos.x, mousePos.y, r*2, r*2);
  
  for(int i = 0; i < shape.getVertexCount(); i++) {
    vertices[i] = shape.getVertex(i);
    vertices[i].x = vertices[i].x + width / 2;
    vertices[i].y = vertices[i].y + height / 2;
    
  }
   
}

void mouseReleased() {
  if(isHitLine(vertices, mousePos, r)) {
    debug += 1;
    println("Hit count[" + debug + "]");
    
  }
  
}