import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String toBackendDate() {
    return "$month-$day-$year";
  }

  String toFrontendDate() {
    return "$day/$month/$year";
  }

  String getDayName() {
    switch (weekday) {
      case 1:
        return "Pazartesi";
      case 2:
        return "Salı";
      case 3:
        return "Çarşamba";
      case 4:
        return "Perşembe";
      case 5:
        return "Cuma";
      case 6:
        return "Cumartesi";
      case 7:
        return "Pazar";
      default:
        return "";
    }
  }

  String format(String format, String locale) {
    return DateFormat(format, locale).format(this);
  }
}
