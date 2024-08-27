import 'package:get/get.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/app_manager_model.dart';

class AppManagerController extends GetxController {
  final appManagerModel = Rxn<AppManagerModel>();

  void getData() async {
    try {
      final result = await CustomDio().get('super-admin/app-manager');

      appManagerModel.value = AppManagerModel.fromMap(result.data['data']);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void saveData() async {
    try {
      CustomAlert.customLoadingDialog();
      final result = await CustomDio()
          .put('super-admin/app-manager', body: appManagerModel.value!.toMap());

      appManagerModel.value = AppManagerModel.fromMap(result.data['data']);
      Get.back();
      CustomAlert.snackBar(msg: 'Updated');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
