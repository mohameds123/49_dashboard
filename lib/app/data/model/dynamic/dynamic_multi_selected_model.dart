import 'package:get/get.dart';

class DynamicMultiSelectionsModel {
   String nameAr;
   String nameEn;

   DynamicMultiSelectionsModel({
    required this.nameAr,
    required this.nameEn,
  });

  String get name => Get.locale?.languageCode == 'ar' ? nameAr : nameEn;

  factory DynamicMultiSelectionsModel.fromMap(Map<String, dynamic> map) {
    return DynamicMultiSelectionsModel(
      nameAr: map['ar'] as String,
      nameEn: map['en'] as String,
    );
  }
}
