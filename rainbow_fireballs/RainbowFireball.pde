// RainbowFireball

class RainbowFireball {

  int x;
  int y;

  int radius;

  PGraphics g;
  color c;
  float hue;

  int speed;
  int x_increment = 0;

  RainbowFireball(int ball_x, int ball_y, int ball_radius, PGraphics graphics, color ball_c, int ball_speed) {

    x = ball_x;
    y = ball_y;
    radius = ball_radius;
    g = graphics;
    c = ball_c;
    speed = ball_speed;

    hue = random(0, 360);    // Set initial color of ball randomly
    x_increment = int(random(1, 3));
  }

  void display() {

    g.beginDraw();
    g.noStroke();

    colorMode(HSB, 360, 100, 100);

    color rainbow;
    if (y <  (height + int((radius * 0.25)))) {
      float off = hue;
      hue += 0.4;
      hue %= 360;
      rainbow = color((hue + off) % 360, 100, 100);
    } else {
      // Set color of ball based on position at bottom of frame
      hue = map(x, 0, width, 0, 360);
      rainbow = color(hue, 100, 100);
      // Set size
      //radius = int(radius * 0.75);
    }

    g.fill(rainbow);
    g.ellipse(x, y, radius, radius);
    colorMode(RGB, 255, 255, 255);
    g.endDraw();
  }

  void descend() {
    y += speed;

    if (y > (height + int((radius * 0.25)))) {
      y = height + int((radius * 0.25));
    } else {
      //x++;
      x += x_increment;
    }
  }
}
