import java.util.*;

Player p;
Enemy[] enemies = new Enemy[1];
Barrier[] walls = new Barrier[50];

void setup(){
   size(800,800);
   p = new Player();
   enemies[0] = new Enemy(30,30,50,50);
   walls[0]= new Barrier(width/2,5,800,10);
   walls[1]= new Barrier(width/2,795,800,10);
   walls[2]= new Barrier(5,height/2,10,800);
   walls[3]= new Barrier(795,height/2,10,800);
   for (int i=0;i<4;i++){
     walls[i].setColor(255,255,50);
   }
   for (int i=4;i<walls.length;i++){
     float xcor=random(800);
     float ycor=random(800);
     float w=random(10,50);
     float l=random(10,50);
     walls[i] = new Barrier(xcor,ycor,w,l);
     walls[i].draw();
   }
   for (int i=0;i<enemies.length;i++){
     float xcor=random(790);
     float ycor=random(790);
     enemies[i]=new Enemy(xcor,ycor,xcor+10,ycor+10);
     while (wallCollision(enemies[i].getCoors())){
       xcor=random(760);
       ycor=random(760);
       enemies[i]=new Enemy(xcor,ycor,xcor+40,ycor+40);
     }
  }
}

boolean collision(float[] a, float[] b){
  //coor[0] = left wall, coor[1] = top wall, coor[2] = right wall, coor[3] = bottom wall
  return a[2] > b[0] && a[3] > b[1] && b[2] > a[0] && b[3] > a[1];
  // return bBoxRight > aBoxLeft && bBoxBottom > aBoxTop && aBoxRight > bBoxLeft && aBoxBottom > bBoxTop;
}

boolean wallCollision(float[] a){
  boolean collision=false;
  for (Barrier wall : walls){
    float[] b = wall.getCoors();
    if (a[2] > b[0] && a[3] > b[1] && b[2] > a[0] && b[3] > a[1]){
      collision=true;
    }
  }
  return collision;
}


boolean playerCollision(float[] a){
  float[] b = p.getCoors();
  return a[2] > b[0] && a[3] > b[1] && b[2] > a[0] && b[3] > a[1];
}

class Barrier{
    float[] coor = new float[4];
    color c;
    void draw(){
      rectMode(CORNERS);
      fill(c);
      rect(coor[0],coor[1],coor[2],coor[3]);
    }
    Barrier(float x,float y, float w, float l){
      c = color(0,0,0);
      coor[0]=x-(w/2);
      coor[1]=y-(l/2);
      coor[2]=x+(w/2);
      coor[3]=y+(l/2);
    }
    void setColor(int r, int g,int b){
      c = color(r,g,b);
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
    void setycor(float y){
      coor[1]+=y;
      coor[3]+=y;
    }    
    float[] getCoors(){
      return coor;
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

class Enemy extends Player{
  Enemy(float x1,float y1,float x2,float y2){
    coor[0]=x1;
    coor[1]=y1;
    coor[2]=x2;
    coor[3]=y2;
    c = color(200,0,0);
  }
  void move(float x, float y){
    setxcor(x);
    setycor(y);
  }
  void setCoors(float[] c){
    coor=c;
  }
}

class coordinate{
  float priority;
  coordinate last=null;
  float[] coor = new float[4];
  coordinate(float[] c, float p, coordinate l){
    coor=c;
    priority=p;
    last=l;
  }
  coordinate(float[] c, coordinate l){
    coor=c;
    last=l;
  }
  void setPriority(float p){
    priority=p;
  }
  float getpriority(){
    return priority;
  }
  float[] getCoors(){
    return coor;
  }
  coordinate getLast(){
    return last;
  }
  void move(float x, float y){
    coor[0]+=x;
    coor[2]+=x;
    coor[1]+=y;
    coor[3]+=y;
  }
  boolean same(float[] c){
    return (int)coor[0]==(int)c[0] && (int)coor[1]==(int)c[1] && (int)coor[2]==(int)c[2] && (int)coor[3]==(int)c[3];
  }
}

float distance(float[] coors){
  float[] pcoors = p.getCoors();
  return sqrt(sq(coors[0]-pcoors[0])+sq(coors[0]-pcoors[0]));
}

class frontier{
  LinkedList<coordinate> path = new LinkedList<coordinate>();
  frontier(coordinate coor){
    path.add(coor);
  }
  void add(coordinate coor){
    boolean inserted=false;
    for (int i=0;i<path.size();i++){
      if (((coordinate)path.get(i)).getpriority()>coor.getpriority()){
        path.add(i,coor);
        inserted=true;
      }
    }
    if (!inserted){
      path.addLast(coor);
    }
  }
  coordinate pop(){
    return path.remove();
  }
  boolean empty(){
    return path.isEmpty();
  }
}



void moveEnemies(){
  for (Enemy e : enemies){
    ArrayList<coordinate> exploredArea = new ArrayList<coordinate>();
    frontier path = new frontier(new coordinate(e.getCoors(),distance(e.getCoors()),null));
    coordinate ans=null;
    coordinate temp, x1, x2, y1, y2;
    boolean explored;
    while (!path.empty()){
      temp=path.pop();
      if (playerCollision(temp.getCoors())){
        ans=temp;
        println("!");
        break;
      }
      explored=false;
      x1 = new coordinate(temp.getCoors(),temp);
      x1.move(1,0);
      x1.setPriority(distance(x1.getCoors()));
      for (coordinate c : exploredArea){
        if (c.same(x1.getCoors())) explored=true;
      }
      if (!explored) path.add(x1);
      
      explored=false;
      y1 = new coordinate(temp.getCoors(),temp);
      y1.move(0,1);
      y1.setPriority(distance(y1.getCoors()));
      for (coordinate c : exploredArea){
        if (c.same(y1.getCoors())) explored=true;
      }
      if (!explored) path.add(y1);
      
      explored=false;
      x2 = new coordinate(temp.getCoors(),temp);
      x2.move(-1,0);
      x2.setPriority(distance(x2.getCoors()));
      for (coordinate c : exploredArea){
        if (c.same(x2.getCoors())) explored=true;
      }
      if (!explored) path.add(x2);
      
      explored=false;
      y2 = new coordinate(temp.getCoors(),temp);
      y2.move(0,-1);
      y2.setPriority(distance(y2.getCoors()));
      for (coordinate c : exploredArea){
        if (c.same(y2.getCoors())) explored=true;
      }
      if (!explored) path.add(y2);
      exploredArea.add(temp);
    }
    
    coordinate tmp1=null;
    println("1");
    println(ans.getCoors());
    println(p.getCoors());
    while (ans.getLast()!=null){
        println("2");
      tmp1=ans;
      ans=ans.getLast();
    }
    e.setCoors(tmp1.getCoors());
  }
}

void draw(){
    background(255);  
    p.draw();
    p.setColor(100,200,0);    
    for (Barrier wall : walls){
      wall.draw();
    }
     p.setColor(100,200,0);    
    for (Enemy e : enemies){
      e.draw();
    }
    if (keyPressed){
      keyPressed();
      moveEnemies();
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
        }
}
