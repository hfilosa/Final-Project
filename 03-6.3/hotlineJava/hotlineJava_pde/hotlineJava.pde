Player p;
Enemy e;
Barrier[] walls = new Barrier[50];

void setup(){
   size(800,800);
   p = new Player();
   e = new Enemy(0,0,400,400, 250,250);
   for (int i=0;i<walls.length;i++){
     float xcor=random(800);
     float ycor=random(800);
     float w=random(10,50);
     float l=random(10,50);
     walls[i] = new Barrier(xcor,ycor,w,l);
     walls[i].draw();
   }
}

boolean collision(float[] a, float[] b){
  //coor[0] = left wall, coor[1] = top wall, coor[2] = right wall, coor[3] = bottom wall
  return a[2] > b[0] && a[3] > b[1] && b[2] > a[0] && b[3] > a[1];
  // return bBoxRight > aBoxLeft && bBoxBottom > aBoxTop && aBoxRight > bBoxLeft && aBoxBottom > bBoxTop;
}

class Barrier{
    float[] coor = new float[4];
    void draw(){
      rectMode(CORNERS);
      fill(10);
      rect(coor[0],coor[1],coor[2],coor[3]);
    }
    Barrier(float x,float y, float w, float l){
      coor[0]=x-(w/2);
      coor[1]=y-(l/2);
      coor[2]=x+(w/2);
      coor[3]=y+(l/2);
    }
    float[] getCoors(){
      return coor;
    }
}

class Player{
    float[] coor = new float[4];
    color c;
    float speed;
    Player(){
      coor[0]=(width/2)-10;
      coor[1]=(height/2)-10;
      coor[2]=(width/2)+10;
      coor[3]=(height/2)+10;
      c = color(100,200,0);
      speed=3;
    }
    float getSpeed(){
      return speed;
    }
    void setxcor(float x){
      coor[0]+=x;
      coor[2]+=x;
    }
    float getxcor(){
      return coor[0];
    }
    void setycor(float y){
      coor[1]+=y;
      coor[3]+=y;
    }    
     float getycor(){
      return coor[1];
    }
    float[] getCoors(){
      return coor;
    }
    void printCoors(){
          println("You are at" + " " + p.getxcor() + "," + " " + p.getycor());
    }
    void setColor(int r, int g, int b){
      c = color(r,g,b);
    }
    void draw(){
      ellipseMode(CORNERS);
      noStroke();
      fill(c);
      ellipse(coor[0],coor[1],coor[2],coor[3]);
    }    
}

class Enemy{
  //Holds coordinates to draw triangle
  float[] coor = new float[6];
  //Holds the hitbox of the triangle,hitbox[0-1] are x1,y1 --> Top left; hitbox[2-3] are x2,y2 --> bottom right
  float[] hitbox = new float[4];
  Enemy(float x1, float y1, float x2, float y2, float x3, float y3){
    coor[0]=x1;
    coor[1]=y1;
    coor[2]=x2;
    coor[3]=y2;
    coor[4]=x3;
    coor[5]=y3;
    hitbox[0]=min(x1,x2,x3);
    hitbox[1]=min(y1,y2,y3);
    hitbox[2]=max(x1,x2,x3);
    hitbox[3]=max(y1,y2,y3);
  }
  void draw(){
    fill(10);
    triangle(coor[0],coor[1],coor[2],coor[3],coor[4],coor[5]);
    fill(10);
    rectMode(CORNERS);
    fill(40);
    rect(hitbox[0],hitbox[1],hitbox[2],hitbox[3]);
    println(coor);
  }
}

void draw(){
    background(255);  
    p.draw();
    e.draw();
    p.setColor(100,200,0);    
    for (Barrier wall : walls){
      wall.draw();
    }
        e.draw();
    if (keyPressed){
      keyPressed();
    }

}

void keyPressed(){
        boolean collision=false;
        float speed = p.getSpeed();
        float reverse=speed;
        boolean vertical=false;
        if (key == 'a' || key == 'A' || key == LEFT){
          p.setxcor(speed*-1);
        }
        if (key == 'w' || key == 'W' || key == UP){
          vertical=true;
          p.setycor(speed*-1);
        }
        if (key == 's' || key == 'S' || key == DOWN){
          vertical=true;
          reverse=(speed*-1);
          p.setycor(speed);  
        }
        if (key == 'd' || key == 'D' || key == RIGHT){
          reverse=(speed*-1);
          p.setxcor(speed);
        }
        float[] coor = p.getCoors();
        for (Barrier wall : walls){
          if (collision(coor,wall.getCoors())){
            if (vertical) p.setycor(reverse);
            else p.setxcor(reverse);
          }
          println("You are at" + " " + p.getxcor() + "," + " " + p.getycor());
        }
        
}
