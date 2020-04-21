import 'package:intl/intl.dart';

class Constants {
  static final String BASE_URL = "https://covidapi.yubarajpoudel.com";

  static DateTime stringToDateTime(String dateTime, String format) {
    try {
      return DateFormat(format).parse(dateTime);
    } catch(e) {

    }
  }
}

