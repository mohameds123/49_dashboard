import 'package:get/get.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/main_category_model.dart';


class MainCategoryController extends GetxController {
  final mainCategories = RxList<MainCategoryModel>();

  void getData() async {
    try {
      final result =
          await CustomDio().get('super-admin/main-categories');

      mainCategories.value = (result.data['data'] as List)
          .map((e) => MainCategoryModel.fromMap(e))
          .toList();
      mainCategories.sort((a, b) => a.index.compareTo(b.index));
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
