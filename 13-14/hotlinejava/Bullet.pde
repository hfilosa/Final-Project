class Bullet extends Player{
    float[] coor = new float[4];
    color c;
    float speed;
    //Stores the angle the bullet is traveling at
    float angle;
    //Stores whether the player fired the bullet and thus whether it can hurt the player or the enemies
    boolean friendly;
    //targetx and targety are the (x,y) coordinates of the bullets destination
    Bullet(float x, float y,float targetx, float targety, boolean f){
      coor[0]=x-5;
      coor[1]=y-5;
      coor[2]=x+5;
      coor[3]=y+5;
      c = color(65,125,216);
      speed=1;
      angle=calculateAngle(x,y,targetx,targety);
      friendly=f;
    }
    //Finds angle between point (x1,x2) and (x2,y2) where the line y=x1 is the base of the angle 
    float calculateAngle(float x1,float y1,float x2,float y2){
      float x=x2-x1;
      float y=y1-y2;
      float ratio = (y/x)%1;
      float theta = degrees(atan(y/x));
      if (x>0 && y<0) theta+=360;
      else if (x<0 && y<0) theta+=180;
      else if (x<0 && y>0) theta+=180;
      return theta;
    }
    void setAngle(float theta){
     angle = theta;
    }
    void draw(){
      ellipseMode(CORNERS);
      noStroke();
      fill(c);
      ellipse(coor[0],coor[1],coor[2],coor[3]);
    } 
    void move(){
      coor[0]+=speed*cos(radians(angle));
      coor[2]+=speed*cos(radians(angle));
      coor[1]-=speed*sin(radians(angle));
      coor[3]-=speed*sin(radians(angle));
    }
    float getAngle(){
      return angle;
    }
}
