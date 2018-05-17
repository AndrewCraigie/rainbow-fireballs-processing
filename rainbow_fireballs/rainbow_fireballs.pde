// Andrew Craigie
// rainbow_fireballs.pde
// Fireballs that cycle through the color spectrum

BlurringImage blur_image;
NoiseArray noise_arr;

float colourdegrees = 0.0;
float y_increment = 0.0;
ArrayList<RainbowFireball> balls = new ArrayList<RainbowFireball>();
int loops = 0;

void setup () {
  size(640, 360);

  noise_arr = new NoiseArray(width + 3, height + 3, 8, 0.04);
  blur_image = new BlurringImage(width + 3, height + 3, noise_arr);
}

void mouseDragged() {

  // Draw directly into BlurringImage.buffer1
  blur_image.graphics.beginDraw();

  // Rainbow fireball
  colorMode(HSB, 360, 100, 100);
  float off = colourdegrees;
  colourdegrees += 1.5;
  colourdegrees %= 360;
  color rainbow = color((colourdegrees + off) % 360, 97, 100);
  blur_image.graphics.fill(rainbow);

  blur_image.graphics.noStroke();
  blur_image.graphics.ellipse(mouseX, mouseY, 60, 60);
  colorMode(RGB, 255, 255, 255);
  blur_image.graphics.endDraw();
}

void updateBalls() {
  for (int i = 0; i < balls.size(); i++) {
    RainbowFireball b = balls.get(i);
    b.display();
    b.descend();
  }
}

void draw() {
  background(0);

  updateBalls();

  if (loops % 20 == 0) {
    // Add a new fireball every 30 frames

    for (int i = 0; i < int(random(1, 3)); i++) {
      int radius = int(random(20, 120));
      color c = (255);
      int speed = int(random(4, 6));
      int ballX = int(random(-400, 600));
      RainbowFireball newBall = new RainbowFireball(ballX, (0 - radius), radius, blur_image.graphics, c, speed); 
      balls.add(newBall);
    }
  }

  image(blur_image.get_image(), 0, 0);
  blur_image.blur();

  loops++;
}
