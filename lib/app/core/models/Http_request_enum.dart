import 'dart:io';

import 'package:flutter/foundation.dart';

enum HttpResponseStatus {
  noInternet,
  success,
  unAuthorized,
  invalidData,
  failure
}
isConnectedToInternet() async {
  try {
    if (!kIsWeb) {
      var result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    }
    return true;
  } on SocketException catch (_) {
    return false;
  }
}