import 'package:get/get.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/sub_category_model.dart';
import '../../sub_category/controllers/sub_category_controller.dart';

class AddSubCategoryController extends GetxController {
  final String mainCategory;

  AddSubCategoryController(this.mainCategory);

  String nameAr = '';
  String nameEn = '';
  String picture = '';

  double dailyPrice = 0;
  double portion = 0;
  double providerPortion = 0;
  double paymentFactor = 0;
  double grossMoney = 0;
  double totalOverHead = 0;
  double overHeadFactor = 0;

  void addCategory() async {
    try {
      if (nameAr.isEmpty || nameEn.isEmpty || picture.isEmpty) {
        return CustomAlert.showError(
            'Cannot Add Without Name Ar Or Name En Or Picture');
      } else {
        CustomAlert.customLoadingDialog();

        final path = await AppConstants.spaceBucket
            .uploadFile(picture, 'image/jpg', 'jpg');

        if (path != null) {
          final result = await CustomDio().post(
            'super-admin/sub-categories',
            body: {
              'parent': mainCategory,
              'name_ar': nameAr,
              'name_en': nameEn,
              'picture': path,
              'daily_price': dailyPrice,
              'portion': portion,
              'provider_portion': providerPortion,
              'payment_factor': paymentFactor,
              'gross_money': grossMoney,
              'total_over_head': totalOverHead,
              'over_head_factor': overHeadFactor,
            },
          );
          final category = SubCategoryModel.fromMap(result.data['data']);
          Get.find<SubCategoryController>().subCategories.add(category);
          Get.back();
          CustomAlert.snackBar(msg: 'Sub Category Added');
        } else
          Get.back();
      }
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }
}
