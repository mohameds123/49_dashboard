import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/app_state.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../../../data/model/post_comment.dart';
import '../../../../../../data/model/report/post.dart';

class SinglePostController extends GetxController {
  final String postId;

  final postModel = Rxn<PostModel>();

  final commentController = TextEditingController();
  final commentFocusNode = FocusNode();

  final postState = CustomState().obs;

  final isEmojiShow = Rx(false);

  late final commentsPagingController =
      PagingController<int, PostCommentModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchCommentsPage);

  SinglePostController(this.postId);

  @override
  void onInit() {
    super.onInit();
    getSinglePost();
  }

  Future<void> getSinglePost() async {
    try {
      postState.value = CustomLoadingState();
      final result = await CustomDio(enableLog: true)
          .get(AppConstants.mainHost + '/social/posts/get-single/$postId');

      postModel.value = PostModel.fromMap(
        (result.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
      );

      postState.value = CustomLoadedState();
    } catch (e) {
      postState.value =
          CustomErrorState(e is DioException ? e.message ?? '' : e.toString());
    }
  }

  Future<void> _fetchCommentsPage(int pageKey) async {
    try {
      final result = await CustomDio().get(AppConstants.mainHost +
          '/social/posts/get-post-comments/$postId?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map(
                (e) => PostCommentModel.fromMap(e as Map<String, dynamic>),
              )
              .toList();

      final newItems = newItemsResult
          .where((e) => !commentsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        commentsPagingController.appendLastPage(newItems);
      } else {
        commentsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (e) {
      commentsPagingController.error = 'No Internet Connection'.tr;
    }
  }

  @override
  void onClose() {
    super.onClose();
    commentController.dispose();
    commentFocusNode.dispose();
    commentsPagingController.dispose();
  }
}
