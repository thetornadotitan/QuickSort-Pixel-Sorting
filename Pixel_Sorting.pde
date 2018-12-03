import java.util.Stack;

PImage img;

float[] hueArray;
int stepSize;

boolean lowStep = true;

Stack stack;

void setup(){
  size(1000, 1000);
  background(0);
  
  colorMode(HSB);
  
  //Load Image and strech / squash it too size
  img = loadImage("Colorful1.jpg");
  img.resize(width, height);
  
  //create Array
  hueArray = new float[width * height];
  
  //Fill array
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    hueArray[i] = hue(img.pixels[i]); 
  }
  img.updatePixels();
  
  stack = new Stack();
  stack.push(0);
  stack.push(hueArray.length);
  
  stepSize = width * height / 100;
  
  image(img, 0, 0);
   
}

void draw(){
  if(!stack.isEmpty()){
    for (int i = 0; i < stepSize; i++){
      if(!stack.isEmpty()){
        int end = (int) stack.pop();
        int start = (int) stack.pop();
        
        if(end - start >= 2){
          int p = start + ((end -start) / 2);
          p = Part(hueArray, p, start, end);
          
          stack.push(p + 1);
          stack.push(end);
          
          stack.push(start);
          stack.push(p);
        }
      }else{
        System.out.println("DONE!");
        break;
      }
    }
  }
  
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color(hueArray[i], 255, 255); 
  }
  img.updatePixels();
  
  image(img, 0, 0);
}

public int Part(float[] input, int position, int start, int end){
  int l = start;
  int h = end - 2;
  float piv = input[position];
  swap(input, position, end - 1);

  while (l < h) {
    if (input[l] < piv) {
      l++;
    } else if (input[h] >= piv) {
      h--;
    } else {
      swap(input, l, h);
    }
  }
  int idx = h;
  if (input[h] < piv) {
    idx++;
  }
  swap(input, end - 1, idx);
  return idx;
}

public void swap(float[] arr, int i, int j) {
  float temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}
