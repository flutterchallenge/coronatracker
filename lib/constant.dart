import 'package:intl/intl.dart';

class Constants {
  static final String BASE_URL = "https://covidapi.yubarajpoudel.com";

  static DateTime stringToDateTime(String dateTime, String format) {
    try {
      DateTime time =  DateFormat(format).parse(dateTime);
      print("year = ${time.year}, month = ${time.month}, day = ${time.day}");
      return time;
    } catch(e) {
      print("error, ${e.toString()}");
    }
  }
}

