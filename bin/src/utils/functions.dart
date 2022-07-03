class Functions {
  static String getDate(DateTime date) {
    // String _date = date.day.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    return ('${date.year}-$month-$day');
  }

  static DateTime? stringToDateTime(
      {String? date, bool mdy = true, bool dmy = false, ymd = false}) {
    if (date == null) return null;
    List<String> dateSplit = date.split((date.contains('-')) ? '-' : '/');
    if (dmy) {
      return DateTime.parse(
          '${dateSplit[2]}-${dateSplit[1]}-${dateSplit[0]} 00:00:00');
    }
    if (ymd) {
      return DateTime.parse(
          '${dateSplit[0]}-${dateSplit[1]}-${dateSplit[2]} 00:00:00');
    }
    if (mdy) {
      return DateTime.parse(
          '${dateSplit[2]}-${dateSplit[0]}-${dateSplit[1]} 00:00:00');
    }
    return null;
  }

  static double? stringtoDouble(String? value) {
    if (value == null) return null;
    return double.parse(value);
  }
}
