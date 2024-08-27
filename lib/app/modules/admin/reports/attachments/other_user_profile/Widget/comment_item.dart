import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/model/post_comment.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:textless/textless.dart';

import '../../../../../../data/model/report/post.dart';
import '../../../../../../routes/app_pages.dart';

class CommentItem extends StatelessWidget {
  final PostModel? post;
  final PostCommentModel comment;

  const CommentItem({
    super.key,
    this.post,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xfff3f3f3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.OTHER_USER_PROFILE,
                        arguments: comment.userId,
                      );
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(
                        comment.user?.profilePicture ?? '',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.OTHER_USER_PROFILE,
                        arguments: comment.userId,
                      );
                    },
                    child: (comment.user?.fullName ?? '')
                        .text
                        .size(12)
                        .color(Colors.black)
                        .bold,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 48),
                child: ReadMoreText(
                  comment.text,
                  trimLength: 200,
                  colorClickableText: Colors.pink,
                  style: TextStyle(color: Colors.black, fontSize: 13),
                  trimCollapsedText: 'Show more'.tr,
                  trimExpandedText: 'Show less'.tr,
                  moreStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  lessStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 48),
                child: Row(
                  children: [
                    comment.timeAgo.text.color(Colors.grey).size(12),
                    const SizedBox(width: 20),
                    if (comment.totalReactions > 0)
                      NumberFormat.compact()
                          .format(comment.totalReactions)
                          .text,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
