class Globals {
  static String convertColor(String color) {
    String newColor = color.replaceAll('#', '0xff');
    return newColor;
  }
}
