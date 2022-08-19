

class DataTime {
  static String intToDigits(int value) {
    if (value <= 9) return "0$value";
    return "$value";
  }
  static String dateToHour(DateTime dateTime) {
    var time = dateTime.toLocal();
    return "${intToDigits(time.hour)}"
        ":${intToDigits(time.minute)}";
  }
}