class MonthData {
  static final List<Map<int, String>> months = [
    {1: 'Janeiro'},
    {2: 'Fevereiro'},
    {3: 'Março'},
    {4: 'Abril'},
    {5: 'Maio'},
    {6: 'Junho'},
    {7: 'Julho'},
    {8: 'Agosto'},
    {9: 'Setembro'},
    {10: 'Outubro'},
    {11: 'Novembro'},
    {12: 'Dezembro'},
  ];

  static String getMonth(int month) {
    return months.firstWhere((element) => element.keys.first == month)['$month']!;
  }

  static int getMonthIndex(String month) {
    return months.firstWhere((element) => element.values.first == month).keys.first;
  }

  static String getMonthYear(int month, int year) {
    return '${getMonth(month)} de $year';
  }

  static String getMonthYearFromDateTime(DateTime dateTime) {
    return '${getMonth(dateTime.month)} de ${dateTime.year}';
  }
}

