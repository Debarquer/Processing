import java.awt.image.*;
import javax.imageio.*;

class RGBHolder{
  float _r, _g, _b;

  public RGBHolder(float r, float g, float b){
    _r = r;
    _g = g;
    _b = b;
  }
}

class ImageLoader{

  ImageLoader(){
  }

  BufferedImage image;

  public RGBHolder[][] getImagePixelData(){
    int width = image.getWidth();
    int height = image.getHeight();
    RGBHolder[][] result = new RGBHolder[width][height];

    for (int row = 0; row < height; row++) {
       for (int col = 0; col < width; col++) {
          int[] tmp = new int[4];
          image.getRaster().getPixel(row, col, tmp);
          result[col][row] = new RGBHolder(tmp[0], tmp[1], tmp[2]);
       }
    }

    return result;
  }

  public void loadImage(String filePath){
    getImage(filePath);
  }

  private void getImage(String filePath) {
    // This time, you can use an InputStream to load
    print("File path: " + filePath + "\n");
    // Grab the InputStream for the image.
    File f = null;

    //read image
    try{
      f = new File("D:\\Github\\Processing\\08 - Game of Life\\GameOfLife\\resources\\testimg.jpg");
      image = ImageIO.read(f);
    }catch(IOException e){
      System.out.println(e);
    }
  }
}
