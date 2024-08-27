import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_state.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../../../data/model/report/peer_profile_model.dart';
import '../../../../../../data/model/report/post.dart';
import '../../../../../../data/model/report/reel_model.dart';

class OtherUserProfileController extends GetxController {
  final textEditController = TextEditingController();
  final state = CustomState().obs;

  final peerProfile = Rxn<PeerProfileModel>();

  late final postsPagingController =
      PagingController<int, PostModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchPostsPage);

  late final reelsPagingController =
      PagingController<int, ReelModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchReelsPage);

  late final galleryPagingController =
      PagingController<int, PostModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchGalleryPage);

  final index = 0.obs;

  final String peerId;

  OtherUserProfileController(this.peerId);

  Future<void> _fetchPostsPage(int pageKey) async {
    try {
      final result = await CustomDio(enableLog: true).get(
        AppConstants.mainHost +
            '/social/posts/get-peer-posts/$peerId?page=$pageKey',
        query: {'type': 1},
      );

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => PostModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !postsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        postsPagingController.appendLastPage(newItems);
      } else {
        postsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      postsPagingController.error = error;
    }
  }

  Future<void> _fetchReelsPage(int pageKey) async {
    reelsPagingController.appendLastPage([]);
    /*try {
      final result = await AppConstants.dioObject
          .get('social/reels/peer-reels/$peerId?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => ReelModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !reelsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.length < AppConstants.apiPageSize;
      if (isLastPage) {
        reelsPagingController.appendLastPage(newItems);
      } else {
        reelsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (e) {
      reelsPagingController.error = 'No Internet Connection'.tr;
    }*/
  }

  Future<void> _fetchGalleryPage(int pageKey) async {
    try {
      final result = await CustomDio().get(
        AppConstants.mainHost +
            '/social/posts/get-peer-posts/$peerId?page=$pageKey',
        query: {'type': 2},
      );

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => PostModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !galleryPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        galleryPagingController.appendLastPage(newItems);
      } else {
        galleryPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      galleryPagingController.error = error;
    }
  }

  void changeIndex(int v) {
    if (v != index.value) {
      index.value = v;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    getPeerData(loading: true);
  }

  Future<void> getPeerData({bool loading = false}) async {
    if (loading) {
      state.value = CustomLoadingState();
    }
    final res = await CustomDio(enableLog: true).get(
      AppConstants.mainHost + '/social/profile/get-peer/$peerId',
    );

    peerProfile.value = PeerProfileModel.fromMap(
      (res.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    );
    if (loading) {
      state.value = CustomLoadedState();
    }
  }

  @override
  void onClose() {
    postsPagingController.dispose();
    reelsPagingController.dispose();
    galleryPagingController.dispose();
    super.onClose();
  }
}
