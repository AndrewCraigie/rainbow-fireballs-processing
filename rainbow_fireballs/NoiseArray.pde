// NoiseArray
// Class to create an array of noise values between 0 and 255 
// The array will be created and intepreted as a 2D array of w * h values
// The array can be 'scrolled' by incrementing 'rows' and adding a new one at the end

class NoiseArray {

  int [] noise_array;
  int w;
  int h;
  int scroll_index = 0;

  PImage noise_image;           // Image for visualizing noise array for testing

  // Noise variables
  float noise_brightness;       // 255 for testing 40.0 for production
  float xoff = 0.0;
  float rowyoff = 0.0;          // Keep track of y offset globally to ensure seamless pattern
  float noise_increment;        // e.g. 0.04 Increase for coarser, decrease for finer noise

  NoiseArray (int array_width, int array_height, float bright, float increment) {

    w = array_width;
    h = array_height;
    noise_brightness = bright;
    noise_increment = increment;

    initialize_noise_array(w, h);
  }

  void initialize_noise_array(int array_width, int array_height) {

    // Create new array
    noise_array = new int[(array_width * array_height)];
    float xof = 0;
    float yof = 0;

    // Create noise by rows
    for (int y = 0; y < array_height; y++) {
      
      yof += noise_increment;
      xof = 0;
      rowyoff += noise_increment; // Update class y offset so pattern is seamless

      for (int x = 0; x < array_width; x++) {
        xof += noise_increment;
        int index = x + y * array_width;
        float bright = noise(xof, yof) * noise_brightness;
        noise_array[index] = int(bright);
      }
    }
    
    
  }

  int [] make_noise_row(int row_width) {

    // Create array of length row_width
    int [] row_array = new int[row_width];

    rowyoff += noise_increment;  // Incrementing class y offset for seamless array
    float xoff = 0.0;   

    for (int x = 0; x < row_width; x++) {
      xoff += noise_increment; 
      float bright = noise(xoff, rowyoff) * noise_brightness;
      row_array[x] = int(bright);
      
    }

    return row_array;
  }

  void scroll() {

    // TODO: allow for scrolling up or down (maybe left/right too)

    // Remove a 'row' of values from the start of the cooling array
    arrayCopy(noise_array, w, noise_array, 0, (noise_array.length - w));

    // Create a new row of noise
    int [] new_noise_row = make_noise_row(w);

    // Add new row of noise to end of array (splice doesn't seem to work so use loop)
    for (int i = noise_array.length - w; i < noise_array.length; i++) {
      int rowIndex = i % w;     // Using modulo to 'wrap' values around
      noise_array[i] = new_noise_row[rowIndex];
    }
  }

  int [] get_array () {
    
    // Return the noise_array
    return noise_array;
  }

  PImage to_image() {
    // Useful for visualising the noise array whilst testing

    noise_image = createImage(w, h, RGB);
    noise_image.loadPixels();
    // Load array values into image pixels
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        int index = x +  y  * w;
        noise_image.pixels[index] = color(noise_array[index]);
      }
    }
    noise_image.updatePixels();
    return noise_image;
  }
  
  int get_value_at(int index){
     return noise_array[index]; 
  }
  
}
