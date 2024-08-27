import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/app_state.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../../../data/model/dynamic/dynamic_ad_model.dart';

class DynamicAdDetailsController extends GetxController {
  final state = CustomState().obs;

  final String adId;
  late DynamicAdModel dynamicAdModel;

  final adViews = Rxn<int>();

  final pageController = PageController();
  final currentSliderIndex = Rx(0);

  DynamicAdDetailsController(this.adId);

  @override
  void onInit() {
    _getAd();
    _getViews();
    super.onInit();
  }

  Future<void> _getAd() async {
    try {
      state.value = CustomLoadingState();

      final result = await CustomDio()
          .get(AppConstants.mainHost + '/ads/get-single-ad/$adId');
      dynamicAdModel = DynamicAdModel.fromMap(
        (result.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
      );
      state.value = CustomLoadedState();
    } catch (e) {
      state.value = CustomErrorState(e.toString());
    }
  }

  Future<void> _getViews() async {
    try {
      final result = await CustomDio()
          .get(AppConstants.mainHost + '/ads/get-views/${adId}');

      adViews.value = (result.data as Map<String, dynamic>)['data'] as int;
    } catch (e) {}
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
