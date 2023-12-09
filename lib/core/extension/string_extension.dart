extension EmailValidator on String? {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this!);
  }

  String replaceTurkishCharacters() {
    return this!
        .replaceAll('İ', 'I')
        .replaceAll('ı', 'i')
        .replaceAll('Ç', 'C')
        .replaceAll('ç', 'c')
        .replaceAll('Ş', 'S')
        .replaceAll('ş', 's')
        .replaceAll('Ğ', 'G')
        .replaceAll('ğ', 'g')
        .replaceAll('Ü', 'U')
        .replaceAll('ü', 'u')
        .replaceAll('Ö', 'O')
        .replaceAll('ö', 'o');
  }

  String toSnakeCase() {
    return this!.replaceAllMapped(RegExp('([A-Z])'), (match) => '_${match[0]}').toLowerCase();
  }
}

extension StringToFormattedDateExtension on String {
  String toFormattedDate() {
    // "MM/dd/yyyy" formatındaki tarihi DateTime'a çevirme
    List<String> dateParts = split('-');
    DateTime dateTime = DateTime(int.parse(dateParts[2]), int.parse(dateParts[0]), int.parse(dateParts[1]));
    // "dd/MM/yyyy" formatına çevirme
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  DateTime toDateTime() {
    List<String> dateParts = split('-');
    return DateTime(int.parse(dateParts[2]), int.parse(dateParts[0]), int.parse(dateParts[1]));
  }

  //convert dd-mm-yyyy to yyyy/mm/dd
  String toYearMonthDay() {
    // if 1-9 add 0
    List<String> dateParts = split('-');
    if (dateParts[1].length == 1) {
      dateParts[1] = "0${dateParts[1]}";
    }
    return "${dateParts[2]}-${dateParts[0]}-${dateParts[1]}";
  }
}
