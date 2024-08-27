import 'dart:core';

import 'package:intl/intl.dart';

extension DateParsing on String {
  DateTime toDate() {
    DateTime dateTime = DateTime.now();
    if (this.isNotEmpty) {
      try {
        dateTime =
            DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(this, true).toLocal();
      } catch (e) {
        print("$e");
      }
    }
    return dateTime;
  }
}
