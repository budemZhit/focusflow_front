bool isNumber(String s) {
  return int.tryParse(s) != null || double.tryParse(s) != null;
}