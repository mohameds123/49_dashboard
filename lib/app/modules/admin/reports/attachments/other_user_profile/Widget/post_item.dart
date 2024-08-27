import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:textless/textless.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../../../../../../../main.dart';
import '../../../../../../data/model/report/post.dart';
import '../../../../../../routes/app_pages.dart';
import 'auto_direction.dart';
import 'multi_image_viewer.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  const PostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * .88,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                          post.user?.profilePicture ?? '',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: (post.user?.fullName ?? '')
                            .text
                            .bold
                            .black
                            .maxLine(1)
                            .overflowEllipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      time_ago.format(post.createdAt).cap.size(11),
                      const SizedBox(width: 5),
                    ],
                  ),
                  if (post.location.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        width: Get.width * .6,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 15),
                            const SizedBox(width: 2),
                            Expanded(
                              child:
                                  post.location.text.overflowEllipsis.size(11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    width: Get.width * .6,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        if (post.activity != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              '${'is'.tr} ${post.activity!.nameEn} ',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        if (post.activity != null &&
                            post.activity!.picture != null)
                          post.activity!.picture!.endsWith('.svg')
                              ? SvgPicture.network(
                                  post.activity!.picture!,
                                  width: 18,
                                  height: 18,
                                )
                              : CachedNetworkImage(
                                  imageUrl: post.activity!.picture!,
                                  width: 18,
                                  height: 18,
                                ),
                        if (post.travelFrom != null && post.travelTo != null)
                          '${'from'.tr} ${post.travelFrom}'
                              .text
                              .size(10)
                              .color(mainColor),
                        if (post.travelFrom != null && post.travelTo != null)
                          '${'to'.tr} ${post.travelTo}'
                              .text
                              .size(10)
                              .color(mainColor),
                        if (post.feeling != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              ' ${post.activity != null ? 'and feeling'.tr : 'is'.tr}${post.feeling!.nameEn} ',
                              style: const TextStyle(
                                color: mainColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        if (post.feeling != null &&
                            post.feeling!.picture != null)
                          post.feeling!.picture!.endsWith('.svg')
                              ? SvgPicture.network(
                                  post.feeling!.picture!,
                                  width: 18,
                                  height: 18,
                                )
                              : CachedNetworkImage(
                                  imageUrl: post.feeling!.picture!,
                                  width: 18,
                                  height: 18,
                                ),
                      ],
                    ),
                  ),
                  if (post.tags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Wrap(
                        children: [
                          'With '.tr.text.size(10).color(mainColor),
                          ...post.tags.map(
                            (e) => InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.OTHER_USER_PROFILE,
                                  arguments: e.id,
                                  preventDuplicates: false,
                                );
                              },
                              child:
                                  '${e.fullName}${post.tags.indexOf(e) < post.tags.length - 1 ? ' ,' : ''} '
                                      .text
                                      .size(10)
                                      .color(Colors.red),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (post.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: post.background != null ? 150 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: post.background != null
                        ? Color(post.background!)
                        : null,
                  ),
                  child: post.background != null
                      ? Center(
                          child: _buildPostContent(post),
                        )
                      : _buildPostContent(post),
                ),
              ),
            if (post.pictures.isNotEmpty && post.background == null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: MultiImageViewer(
                  images: post.pictures,
                ),
              )
            else
              const SizedBox(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NumberFormat.compact().format(post.totalLikes).text,
                'Reactions'.text
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  static Widget _buildPostContent(PostModel post) {
    return AutoDirection(
      text: post.text,
      child: ReadMoreText(
        post.text,
        textAlign: post.background != null ? TextAlign.center : null,
        trimLength: 200,
        colorClickableText: Colors.pink,
        style: TextStyle(
          color: Colors.black,
          fontSize: post.background != null ? 20 : 14,
          fontWeight:
              post.background != null ? FontWeight.bold : FontWeight.normal,
        ),
        trimCollapsedText: 'Show more'.tr,
        trimExpandedText: 'Show less'.tr,
        moreStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        lessStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }
}
