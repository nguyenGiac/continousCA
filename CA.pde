// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
// Wolfram Cellular Automata

// A class to manage the CA

class CA {

  float[] cells;     // An array of 0s and 1s 
  int generation;  // How many generations?

  //int[] ruleset = {0, 1, 0, 1, 1, 0, 1, 0};     // An array to store the ruleset, for example {0,1,1,0,1,1,0,1}

  int w = 1;

  CA() {
    cells = new float[width/w];
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;    // We arbitrarily start with just the middle cell having a state of "1"
    generation = 0;
  }

  // The process of creating the new generation
  void generate() {
    // First we create an empty array for the new values
    float[] nextgen = new float[cells.length];
    // For every spot, determine new state by examing current state, and neighbor states
    // Ignore edges that only have one neighor
    for (int i = 1; i < cells.length-1; i++) {
      float left = cells[i-1];   // Left neighbor state
      float me = cells[i];       // Current state
      float right = cells[i+1];  // Right neighbor state
      nextgen[i] = rules(left, me, right); // Compute next generation state based on ruleset
    }
    // The current generation is the new generation
    cells = nextgen;
    generation++;
    
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for (int i = 0; i < cells.length; i++) {
      float f =  map(cells[i],0,1,0,255);
      fill(f);
      noStroke();
      rect(i*w, generation*w, w, w);
    }
  }



  // Implementing the Wolfram rules
  // Could be improved and made more concise, but here we can explicitly see what is going on for each case
  float rules (float a, float b, float c) {
    float average = ((a + b + c)/3)+.25;
    String strAvg = str(average);
    if(strAvg.indexOf(".") > 0){
      String fractional = strAvg.substring(strAvg.indexOf("."));
      return float(fractional);
    } else {
      return float(strAvg);
    }
    
  }
}
