import java.util.*;

Player p;
Enemy[] enemies = new Enemy[1];
ArrayList<Barrier> walls = new ArrayList<Barrier>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

void setup(){
   size(800,800);
   p = new Player();
   enemies[0] = new Enemy(30,30,50,50);
   walls.add(new Barrier(width/2,5,800,10));
   walls.add(new Barrier(width/2,795,800,10));
   walls.add(new Barrier(5,height/2,10,800));
   walls.add(new Barrier(795,height/2,10,800));
   for (int i=0;i<4;i++){
     walls.get(i).setColor(255,255,50);
   }
   for (int i=4;i<50;i++){
     float xcor=random(800);
     float ycor=random(800);
     float w=random(10,50);
     float l=random(10,50);
     while (xcor>390 && xcor<410 || ycor>390 && ycor<410){
       xcor=random(800);
       ycor=random(800);  
     }
     walls.add(new Barrier(xcor,ycor,w,l));
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

/*This method is called to manage all the fired bullets. It works in this order:
1. Call every barrier except for the edge walls to see if a bullet has collided with them, if so delete that wall.
2. Call every enemy to see if a player bullet has collided with them, if so delete them.
3. Check if the player has been hit, if so it is game over.
*/
void bulletCollision(){
  for (int j=0;j<bullets.size();j++){
    float[] bcoors = bullets.get(j).getCoors();
    if (bcoors[0]>800 || bcoors[0]<0 || bcoors[1]>800 || bcoors[1]<0){
      bullets.remove(j);
      break;
    }
    if (wallCollision(bullets.get(j).getCoors())){
      bullets.remove(j);
      break;
      
    }
  }
}
        

float distance(float[] coors){
  float[] pcoors = p.getCoors();
  return sqrt(sq(coors[0]-pcoors[0])+sq(coors[1]-pcoors[1]));
}

void moveEnemies(){
  for (Enemy e : enemies){
    if (distance(e.getCoors())<300){
      float x=e.getCoors()[0]-p.getCoors()[0];
      if (x>0) x=(-1);
      else x=1;
      float y=e.getCoors()[1]-p.getCoors()[1];
      if (y>0) y=(-1);
      else y=1;
      e.move(x,0);
      if (wallCollision(e.getCoors())){
        e.move((-1)*x,0);
      }
      e.move(0,y);
      if (wallCollision(e.getCoors())){
        e.move((-1)*y,0);
      }
    }
  }
}

void draw(){
    background(255);  
    p.draw();
    for (Barrier wall : walls){
      wall.draw();
    }
     p.setColor(100,200,0);    
    for (Enemy e : enemies){
      e.draw();
    }
    for (Bullet b : bullets){
       b.draw();
    }
    bulletCollision();
    if (keyPressed){
      keyPressed();
      moveEnemies();
      for (Bullet b : bullets){
         b.move();
         bulletCollision(); 

      }
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

void mousePressed(){
  bullets.add(new Bullet(p.getCoors()[0]+5,p.getCoors()[1]+5,mouseX,mouseY,true));
}

