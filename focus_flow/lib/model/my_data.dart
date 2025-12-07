class MyData {
  int month;
  int year;

  MyData(this.month, this.year);

  MyData previewMouth(MyData selected) {

    if (selected.month == 1) {
      selected.year -= 1;
      selected.month = 13;
      if (selected.year < 2024){
        return MyData(1 , 2024);
      }
    }
    selected.month -= 1;
    return selected;
  }

  MyData nextMouth(MyData selected) {
    if (selected.month == 12) {
      selected.year += 1;
      selected.month = 0;
    }
    selected.month += 1;
    return selected;
  }

  void currentDate() {
    final now = DateTime.now();
    year = now.year;
    month = now.month;
  }

  static MyData fromCurrentDate() {
    final now = DateTime.now();
    return MyData(now.year, now.month);
  }

  @override
  String toString() => "MyData(year: $year, month: $month)";
}
