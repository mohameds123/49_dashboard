import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textless/textless.dart';
import '../../../../../../../main.dart';
import '../../../../../../data/model/report/peer_profile_model.dart';
import 'image_viewer_view.dart';

class OtherProfileHeader extends StatelessWidget {
  final PeerProfileModel peerProfile;

  const OtherProfileHeader({
    super.key,
    required this.peerProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  NumberFormat.compact()
                      .format(
                        peerProfile.totalPosts,
                      )
                      .text
                      .size(12)
                      .bold
                      .color(Colors.red),
                  const SizedBox(width: 5),
                  'Post'.tr.text.size(12).bold.color(mainColor),
                ],
              ),
              Row(
                children: [
                  NumberFormat.compact()
                      .format(
                        peerProfile.totalFriends,
                      )
                      .text
                      .size(12)
                      .bold
                      .color(Colors.red),
                  const SizedBox(width: 5),
                  'Friend'.tr.text.size(12).bold.color(mainColor),
                ],
              ),
              Row(
                children: [
                  NumberFormat.compact()
                      .format(
                        peerProfile.totalFollowers,
                      )
                      .text
                      .size(12)
                      .bold
                      .color(Colors.red),
                  const SizedBox(width: 5),
                  'Follow'.tr.text.size(12).bold.color(mainColor),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: Stack(
            children: [
              Hero(
                tag: peerProfile.user.profileCover,
                child: GestureDetector(
                  onTap: () => Get.to(
                    ImageViewerView(
                      peerProfile.user.profileCover,
                    ),
                  ),
                  child: SizedBox.expand(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: mainColor,
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            peerProfile.user.profileCover,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ColoredBox(
                        color: Colors.black.withOpacity(.1),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: InkWell(
                  onTap: () {
                    Get.to(
                      ImageViewerView(
                        peerProfile.user.profilePicture,
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Hero(
                        tag: peerProfile.user.profilePicture,
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.red,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: mainColor,
                            backgroundImage: CachedNetworkImageProvider(
                              peerProfile.user.profilePicture,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: peerProfile.user.fullName.text.bold
              .size(18)
              .color(Colors.black)
              .overflowEllipsis
              .maxLine(2)
              .height(1),
        ),
      ],
    );
    /*return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Hero(
            tag: peerProfile.user.profileCover,
            child: GestureDetector(
              onTap: () => Get.to(
                ImageViewerView(
                  peerProfile.user.profileCover,
                ),
              ),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: mainColor,
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        peerProfile.user.profileCover,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ColoredBox(
                    color: Colors.black.withOpacity(.1),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Get.width * .9,
                  height: 50.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (peerProfile.isFriendListEnable) {
                              Get.toNamed(
                                Routes.PEER_FRIENDS_LIST,
                                arguments: peerProfile.user.id,
                              );
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NumberFormat.compact()
                                  .format(peerProfile.totalFriends)
                                  .text
                                  .bold
                                  .size(16.sp)
                                  .color(Colors.white),
                              'Friend'.text.size(16.sp).color(Colors.white),
                            ],
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            if (peerProfile.isFollowListEnable) {
                              Get.toNamed(
                                Routes.MY_FOLLOWERS_LIST,
                                arguments: peerProfile.user.id,
                              );
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NumberFormat.compact()
                                  .format(peerProfile.totalFollowers)
                                  .text
                                  .bold
                                  .size(16.sp)
                                  .color(Colors.white),
                              'Follower'.text.size(16.sp).color(Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 1,
            top: 152,
            child: InkWell(
              onTap: () {
                Get.bottomSheet(
                  SarahahWidget(
                    onSendSaraha: onSendSaraha,
                  ),
                  isScrollControlled: true,
                );
              },
              child: CircleAvatar(
                radius: 15.r,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    color: Colors.red,
                    size: 20.r,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 1,
            top: 152,
            child: InkWell(
              onTap: () {
                reportUser(
                  peerProfile.user.id,
                  ReportTypes.profile,
                  peerProfile.user.id,
                );
              },
              child: CircleAvatar(
                radius: 15.r,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.report,
                    color: Colors.red,
                    size: 20.r,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 86,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(
                      ImageViewerView(
                        peerProfile.user.profilePicture,
                      ),
                    );
                  },
                  child: Hero(
                    tag: peerProfile.user.profilePicture,
                    child: CircleAvatar(
                      radius: 52.r,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundColor: mainColor,
                        backgroundImage: CachedNetworkImageProvider(
                          peerProfile.user.profilePicture,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: peerProfile.user.fullName.text.bold
                      .size(18.sp)
                      .color(Colors.black)
                      .overflowEllipsis
                      .maxLine(2)
                      .height(1),
                ),
              ],
            ),
          ),
          Positioned(
            top: 185,
            left: 0,
            child:
                '${NumberFormat.compact().format(peerProfile.totalPosts)} Post '
                    .text
                    .size(13.sp)
                    .color(Colors.black),
          )
        ],
      ),
    );
*/
  }
}
