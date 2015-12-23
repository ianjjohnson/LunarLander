
/**
 * This is the class that generates and renders the 
 * landscape for the lander
 */
  class Landscape {
  float[] heights;
  int screen_width, screen_height;
  int resolution = 100;
  int pad_width = 8; // measured in chunks
  float chunk_size;
  int pad_start_i;
  float pad_height;
  PFont newFont4;
  /** 
   * Constructor method
   *
   * Uses Brownian motion to generate the landscape within parameters
   */
  public Landscape(int s_width, int s_height) {
    screen_width = s_width;
    screen_height = s_height;
    heights = new float[resolution+1];
    chunk_size = screen_width / resolution;
    pad_width = 8; // measured in chunks
    
    // Left-most point
    heights[0] = random(200,300);

    pad_start_i = floor(random(5,resolution-6));
    
    // Generate the landscape randomly (will be kept throughout round)
    for (int i=1; i <= resolution; i++) {
      float delta;
      if (heights[i-1] < 200) {
        delta = random(0,30);
      } else if (heights[i-1] >= screen_height - 50) {
        delta = random(-30,0);
      } else {
        delta = random(-30,30);
      }
      
      heights[i] = heights[i-1] + delta;
      
      // we've reached the beginning of the pad on x-axis, so draw a straight line for a while
      while (i >= pad_start_i && i < pad_start_i + pad_width) {
        heights[i] = heights[i-1];
        pad_height = heights[i]; // remember pad height for later
        i++;
      }
      
      if (heights[i] == 0.0f) {
        heights[i] = heights[i-1] + delta;
      }
      
      if (i >= pad_start_i -3 && i < pad_start_i + pad_width + 3) {
       // println( "height[" + i + "] = " + heights[i] );
      }
    }
  }

  /**
   * Returns the highest y of the landscape 
   * between the two x values (a must be <= b)
   */
  float maxHeightInRange(float a, float b) {
    int leftmost_chunk = floor(a/chunk_size);
    int rightmost_chunk = ceil(b/chunk_size);
    float max = 480;
    for (int c = leftmost_chunk; c <= rightmost_chunk; c++ ) {
      if (heights[c] < max) {
        max = heights[c];
      }
    }
    return max;
  }

  void draw() {
    for (int i=0; i < resolution; i++) {
      // println("drawing line (" + chunk_size*i + ", " + heights[i] + ", " + chunk_size*(i+1) + ", " + heights[i+1] + ")");
      // @todo Thicker line for landing pad?
      line (chunk_size*i, heights[i], chunk_size*(i+1), heights[i+1]);
    }
    // println ("Drawing text at " + pad_start_i * chunk_size + ", " + pad_height);
    fill(0);
    newFont4 = createFont("FFScala" , 12);
    textFont (newFont4);
    text("Land Here", pad_start_i * chunk_size - 3, pad_height + 15);
    }
  }
