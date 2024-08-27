import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'helper/do_space/dospace_bucket.dart';
import 'helper/do_space/dospace_spaces.dart';

 class AppConstants {
  static const storage = FlutterSecureStorage();

  static const apiKey =
      'sdsgdsmbxnldfgRDSFSasfgsdnogsndiogewnieownfeifnefdfnewfsikdnsakidnasiiewguef';

  //static const mainHost = 'http://192.168.1.215:3000';
  //static const mainHost = 'http://172.20.10.4:3000';
  static const mainHost =
      kDebugMode ? 'http://192.168.1.39:3000' : 'https://api.49hub.com';

  static const host = '$mainHost/dashboard/';
  static const baseUrl = 'https://49dev.com';
  static const mapPicture =
      'https://49-space.fra1.digitaloceanspaces.com/main/1/map.jpg';

  static const imageBaseUrl = 'https://49-space.fra1.digitaloceanspaces.com/';

  static const tokenStorageKey = 'token';
  static const isSuperAdminStorageKey = 'super_admin';

  static final Bucket spaceBucket = Spaces(
    region: "fra1",
    accessKey: "DO00CY8B3U72UWK2LNMN",
    secretKey: "4t6MyMi6Gi/N3cDNNtiRubegVfWukD06X/9CTnDlsdw",
  ).bucket('49-space');
}
