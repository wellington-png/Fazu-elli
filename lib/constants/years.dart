class YearData {
  static final List<Map<int, String>> years = [
    {2015: '2015'},
    {2016: '2016'},
    {2017: '2017'},
    {2018: '2018'},
    {2019: '2019'},
    {2020: '2020'},
    {2021: '2021'},
    {2022: '2022'},
    {2023: '2023'},
    {2024: '2024'},
    {2025: '2025'},
    {2026: '2026'},
    {2027: '2027'},
    {2028: '2028'},
    {2029: '2029'},
    {2030: '2030'},
  ];

  static String getYear(int year) {
    return years.firstWhere((element) => element.keys.first == year)['$year']!;
  }

  static int getYearIndex(String year) {
    return years.firstWhere((element) => element.values.first == year).keys.first;
  }

  static String getYearFromDateTime(DateTime dateTime) {
    return getYear(dateTime.year);
  }
}