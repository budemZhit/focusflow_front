int leftClick(int mouth, year) {
  if (mouth <= 1) {
    mouth = 13;
    year -=1;
  }
  return mouth - 1;
}

int reightClick(int mouth, int year) {
  if (mouth >= 12) {
    mouth = 0;
    year +=1;
  }
  return mouth + 1;
}
