void main() {
  print(getYears(5));
}

/// 获取前后[num]的年份
List<int> getYears(int num) {
  List<int> years = <int>[];
  int currentYear = new DateTime.now().year;
  for (int year = currentYear - num; year <= currentYear + num; year++) {
    years.add(year);
  }
  return years;
}

/// 获取月份
List<int> getMonth() {
  List<int> months = <int>[];
  for (int month = 1; month <= 12; month++) {
    months.add(month);
  }
  return months;
}

List<int> getDays(int month){

}