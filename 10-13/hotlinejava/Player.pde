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
    void setSpeed(float SPEED){
      speed = SPEED;
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

