import 'package:flutter/foundation.dart';
import 'src/custom_dio.dart';
import 'src/custom_dio_options.dart';
import 'package:get/get.dart';

import '../constants.dart';

class DioManager {
  static void setUpDioOptions({
    String? token,
  }) {
    final dioOptions = CustomDioOptions(
      baseUrl: AppConstants.host,
      isProductionMode: kReleaseMode,
      headers: {
        "Authorization": token != null ? "Bearer $token" : "Bearer NO TOKEN",
        "Key": AppConstants.apiKey,
        "Language": Get.locale?.languageCode ?? 'en',
        "Content-Type": "application/json"
      },
    );
    CustomDio.setInitData(dioOptions);
  }
}
