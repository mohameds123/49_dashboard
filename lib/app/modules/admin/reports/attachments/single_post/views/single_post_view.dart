import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../../../core/app_state.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../../../data/model/post_comment.dart';
import '../../other_user_profile/Widget/comment_item.dart';
import '../../other_user_profile/Widget/post_item.dart';
import '../controllers/single_post_controller.dart';

class SinglePostView extends GetView<SinglePostController> {
  final String postId;

  const SinglePostView({
    super.key,
    required this.postId,
  });

  @override
  String? get tag => postId;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (controller.isEmojiShow.value) {
          controller.isEmojiShow.value = false;
          return Future(() => false);
        }
        return Future(() => true);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Obx(
              () => controller.postModel.value != null
                  ? "name`s Post"
                      .trArgs(
                        [controller.postModel.value?.user?.firstName ?? ''],
                      )
                      .b1
                      .color(Colors.white)
                  : const SizedBox(),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () {
                  final state = controller.postState.value;
                  if (state is CustomLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (state is CustomErrorState) {
                    return Center(
                      child: state.err.text.black.color(Colors.red),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        PostItem(post: controller.postModel.value!),
                        PagedListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          pagingController: controller.commentsPagingController,
                          showNoItemsMessage: false,
                          builderDelegate:
                              PagedChildBuilderDelegate<PostCommentModel>(
                            itemBuilder: (context, item, index) => CommentItem(
                              comment: item,
                              post: controller.postModel.value,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
