class Bullet extends Player{
    float[] coor = new float[4];
    color c;
    float speed;
    float angle;
    Bullet(float x, float y){
      coor[0]=(x)-5;
      coor[1]=y-5;
      coor[2]=x+5;
      coor[3]=y+5;
      c = color(65,125,216);
      speed=3;
    }
    void setAngle(float theta){
     angle = theta;
    }
    float getAngle(){
      return angle;
    }
}
