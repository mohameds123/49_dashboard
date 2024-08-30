import 'dart:convert';
import 'dart:developer';

// import 'package:kiro_hotel/Features/Auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/users_profile/data/models/user_auth_model.dart';

String userKeyNameSharedPref = "userAuthKey";
class SharedPreferencesHelper {

  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<UserAuthModel> getUserMode() async {
    // if (SharedPreferencesHelper.prefs.containsKey(userKeyNameSharedPref)) {
    String jsonString =
        SharedPreferencesHelper.prefs.get(userKeyNameSharedPref).toString();
    UserAuthModel retrievedUser = UserAuthModel.fromJson(jsonDecode(jsonString));
    log(retrievedUser.toJson().toString());
    return retrievedUser;
    // }
  }

  static Future<void> setData(key, val) async {
    await prefs.setString(key, val);
  }

  static dynamic getData(key){
    return prefs.get(key);
  }
}
