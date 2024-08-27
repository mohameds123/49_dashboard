import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../../../core/app_state.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/ui/paged_grid_view.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../../../data/model/report/post.dart';
import '../../../../../../routes/app_pages.dart';
import '../Widget/about.dart';
import '../Widget/multi_image_viewer.dart';
import '../Widget/othere_profile_header.dart';
import '../Widget/post_item.dart';
import '../controllers/other_user_profile_controller.dart';

class OtherUserProfileView extends GetView<OtherUserProfileController> {
  final String userId;

  const OtherUserProfileView({
    super.key,
    required this.userId,
  });

  @override
  String get tag => userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        final state = controller.state.value;
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
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: OtherProfileHeader(
                peerProfile: controller.peerProfile.value!,
              ),
            ),
            if (controller.peerProfile.value!.bio != null) const Divider(),
            if (controller.peerProfile.value!.bio != null)
              controller.peerProfile.value!.bio!.text.alignCenter,
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () => Get.bottomSheet(
                  About(
                    peerProfile: controller.peerProfile.value!,
                  ),
                  isScrollControlled: true,
                ),
                child: const Icon(
                  Icons.help_outline,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            if (controller.peerProfile.value!.user.tinderPicture != null)
              CachedNetworkImage(
                imageUrl: controller.peerProfile.value!.user.tinderPicture!,
                width: Get.width,
                height: 200,
              ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
                border: Border.all(
                  color: const Color(0xff0b1035),
                ),
              ),
              child: ClipRRect(
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.index.value == 0
                                ? const Color(0xff0b1035)
                                : null,
                          ),
                          child: InkWell(
                            onTap: () => controller.changeIndex(0),
                            child: Icon(
                              FontAwesomeIcons.newspaper,
                              color: controller.index.value == 0
                                  ? Colors.white
                                  : const Color(0xff0b1035),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.index.value == 1
                                ? const Color(0xff0b1035)
                                : null,
                          ),
                          child: InkWell(
                            onTap: () => controller.changeIndex(1),
                            child: Icon(
                              Icons.grid_on_rounded,
                              color: controller.index.value == 1
                                  ? Colors.white
                                  : const Color(0xff0b1035),
                            ),
                          ),
                        ),
                      ),
                      /* Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.index.value == 2
                                ? const Color(0xff0b1035)
                                : null,
                          ),
                          child: InkWell(
                            onTap: () => controller.changeIndex(2),
                            child: Icon(
                              Icons.slow_motion_video_rounded,
                              color: controller.index.value == 2
                                  ? Colors.white
                                  : const Color(0xff0b1035),
                            ),
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => IndexedStack(
                index: controller.index.value,
                children: [
                  _buildPosts(),
                  _buildGallery(),
                  // _buildReels(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPosts() {
    return PagedListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      pagingController: controller.postsPagingController,
      builderDelegate: PagedChildBuilderDelegate<PostModel>(
        itemBuilder: (context, item, index) => PostItem(
          post: item,
        ),
      ),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }

  Widget _buildGallery() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: PagedGridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        pagingController: controller.galleryPagingController,
        builderDelegate: PagedChildBuilderDelegate<PostModel>(
          itemBuilder: (context, item, index) => DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff0b1035)),
            ),
            child: InkWell(
              onTap: () {
                Get.to(
                  GalleryPhotoViewWrapper(
                    galleryItems: item.pictures,
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    initialIndex: 0,
                    onCommentClick: () => Get.toNamed(
                      Routes.SINGLE_POST,
                      arguments: item.id,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: item.pictures.first,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.pictures.first,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    if (item.pictures.length > 1)
                      const Positioned(
                        right: 5,
                        top: 5,
                        child: Icon(
                          Icons.more_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
/*
  Widget _buildReels() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: PagedGridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        pagingController: controller.reelsPagingController,
        builderDelegate: PagedChildBuilderDelegate<ReelModel>(
          itemBuilder: (context, item, index) => GestureDetector(
            onTap: () => Get.toNamed(
              Routes.SHORTS,
              arguments: [
                controller.reelsPagingController.itemList,
                index,
              ],
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff0b1035)),
              ),
              child: CachedNetworkImage(
                imageUrl: item.videoThumbUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
  */
}
