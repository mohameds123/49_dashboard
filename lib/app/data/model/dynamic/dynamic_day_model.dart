
import 'package:get/get.dart';

class DynamicDayModel {
  final int index;

  String get name => Get.locale?.languageCode == 'ar' ? daysAr[index] : daysEn[index];

  const DynamicDayModel(this.index);
}

const daysEn = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const daysAr = [
  'الأثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس',
  'الجمعة',
  'السبت',
  'الأحد',
];
