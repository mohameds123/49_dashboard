import 'package:get/get.dart';

import '../../../../../../core/app_state.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../../../data/model/doctor_model.dart';
import '../../../../../../data/model/rating_model.dart';

class DoctorDetailsController extends GetxController {
  final String doctorId;
  final state = CustomState().obs;

  late DoctorModel doctor;

  late final ratingsPagingController =
      PagingController<int, RatingModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchRatingsPage);

  DoctorDetailsController(this.doctorId);

  String mainCategoryId = '';

  Future<void> getDoctorData() async {
    try {
      state.value = CustomLoadingState();
      final result = await CustomDio()
          .get(AppConstants.mainHost + '/services/health/get-doctor/$doctorId');

      doctor = DoctorModel.fromMap(result.data['data']);
      state.value = CustomLoadedState();
    } catch (e) {
      state.value = CustomErrorState(e.toString());
    }
  }

  Future<void> _fetchRatingsPage(int pageKey) async {
    try {
      final result = await CustomDio().get(
        AppConstants.mainHost + '/ads/get-ratings',
        query: {
          'userId': doctor.userId,
          'categoryId': doctor.categoryId,
          'page': pageKey,
        },
      );

      if (((result.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>)['main_category_id']
          .toString()
          .isNotEmpty) {
        mainCategoryId = ((result.data as Map<String, dynamic>)['data']
            as Map<String, dynamic>)['main_category_id'] as String;
      }

      final newItemsResult = (((result.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>)['ratings'] as List)
          .map((e) => RatingModel.fromMap(e as Map<String, dynamic>))
          .toList();

      final newItems = newItemsResult
          .where((e) => !ratingsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        ratingsPagingController.appendLastPage(newItems);
      } else {
        ratingsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      ratingsPagingController.error = error;
    }
  }

  @override
  void onInit() {
    getDoctorData();
    super.onInit();
  }

  @override
  void onClose() {
    ratingsPagingController.dispose();
    super.onClose();
  }
}
