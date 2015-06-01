Player p;

void setup(){
   size(800,800);
   p = new Player();
}

class Barrier{
    float xcor;
    float ycor;
    

class Player{
    float xcor;
    float ycor;
    
    Player(){
      xcor=width/2;
      ycor=height/2;
    }
    
    void setxcor(float x){
      xcor+=x;
    }
    
    void setycor(float y){
      ycor+=y;
    }    
    
    void draw(){
      ellipseMode(CENTER);
      fill(200);
      ellipse(xcor,ycor,20,20);
      keyPressed();
    }    
  
    void keyPressed(){
      if (keyPressed){
        if (key == 'a' || key == 'A' || key == LEFT){
          setxcor(-1);
        }
        if (key == 'w' || key == 'W' || key == UP){
          setycor(-1);
        }
        if (key == 's' || key == 'S' || key == DOWN){
          setycor(1);  
        }
        if (key == 'd' || key == 'D' || key == RIGHT){
          setxcor(1);
        }
      }
    }
}

void draw(){
    background(255);  
    p.draw();  
    keyPressed();
}
