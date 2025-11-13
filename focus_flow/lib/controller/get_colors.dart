import 'dart:ui';

Color getColor(List<Color> colors, int index){
  return colors[getReightId(colors, index)];
}

int getReightId(List<Color> colors, int index){
  return index % colors.length;
}