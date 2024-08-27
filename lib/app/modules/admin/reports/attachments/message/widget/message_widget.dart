import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:textless/textless.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/widget/custom_alert.dart';
import '../../../../../../core/widget/video_player_widget.dart';
import '../../../../../../data/model/chat_message_model.dart';
import '../../other_user_profile/Widget/multi_image_viewer.dart';
import 'message_bubble_painter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'message_record_widget.dart';

class MessageWidget extends StatelessWidget {
  final ChatMessageModel message;

  MessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: message.totalReactions > 0 ? 22 : 0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 30,
            minWidth: 100,
            maxWidth: MediaQuery.of(context).size.width / 1.3,
          ),
          child: CustomPaint(
            painter: MessageBubblePainter(
              me: false,
              background: Colors.greenAccent.shade100,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: message.isDeleted
                      ? [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          'This Message was deleted'.tr.text,
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.block_outlined,
                          )
                        ],
                      ),
                    )
                  ]
                      : [
                    if (message.replayMessage != null)
                      Container(
                        margin: const EdgeInsets.all(8),
                        constraints: BoxConstraints(
                          minHeight: 30,
                          minWidth: 100,
                          maxWidth:
                          MediaQuery.of(context).size.width / 1.3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Column(
                              children: [
                                if (message
                                    .replayMessage!.text.isNotEmpty)
                                  _buildText(
                                    message.replayMessage!.text,
                                  ),
                                if (message.replayMessage!.attachments
                                    .isNotEmpty)
                                  _buildAttachments(
                                    message.replayMessage!,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (message.text.isNotEmpty)
                      _buildText(message.text),
                    if (message.attachments.isNotEmpty)
                      _buildAttachments(message),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 7,
                        bottom: 5,
                        right: 5,
                        left: 5,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          if (message.recordDuration != null)
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child:
                                    '${message.recordDuration!.inMinutes}:${message.recordDuration!.inSeconds < 10 ? '0${message.recordDuration!.inSeconds}' : message.recordDuration!.inSeconds}'
                                        .text,
                                  ),
                                  if (message.isForward)
                                    const Icon(Icons.reply),
                                  const Spacer(),
                                  if (message.id != null)
                                    '${message.date.hour > 12 ? message.date.hour - 12 : message.date.hour}:${message.date.minute > 9 ? message.date.minute : '0${message.date.minute}'} ${message.date.hour > 12 ? 'PM'.tr : 'AM'.tr}'
                                        .text
                                ],
                              ),
                            ),
                          if (message.recordDuration == null &&
                              message.id != null)
                            Row(
                              children: [
                                if (message.isForward)
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Tooltip(
                                      message: 'Forwarded'.tr,
                                      child: const Icon(
                                        Icons.reply,
                                      ),
                                    ),
                                  ),
                                '${message.date.hour > 12 ? message.date.hour - 12 : message.date.hour}:${message.date.minute > 9 ? message.date.minute : '0${message.date.minute}'} ${message.date.hour > 12 ? 'PM'.tr : 'AM'.tr}'
                                    .text,
                              ],
                            ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReadMoreText(
        text,
        trimLength: 200,
        colorClickableText: Colors.pink,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
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

  static Widget _buildAttachments(ChatMessageModel message) {
    return Column(
      children: [
        if (message.picturesAttachments.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(2),
            child: MultiImageViewer(
              images: message.picturesAttachments,
            ),
          ),
        if (message.videosAttachments.isNotEmpty)
          SizedBox(
            height: 300,
            child: VideoPlayWidget(
              url: message.videosAttachments.first,
            ),
          ),
        if (message.filesAttachments.isNotEmpty)
          InkWell(
            onTap: () => cacheFileAndOpen(
              message.filesAttachments.first,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  message.filesAttachments.first
                      .split('.')
                      .last
                      .toUpperCase()
                      .text,
                  const Icon(
                    Icons.file_open_rounded,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        if (message.locationAttachments.isNotEmpty)
          InkWell(
            onTap: () {
              MapsLauncher.launchCoordinates(
                message.locationAttachments.first.locationLat ?? 0,
                message.locationAttachments.first.locationLng ?? 0,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: AppConstants.mapPicture,
                  fit: BoxFit.cover,
                  height: 150,
                  width: 350,
                ),
              ),
            ),
          ),
        if (message.recordAttachments.isNotEmpty)
          MessageRecordWidget(
            chatMessage: message,
          ),
      ],
    );
  }
}

Future<void> cacheFileAndOpen(String fileUrl) async {
  try {
    final file = await DefaultCacheManager().downloadFile(
      fileUrl,
      key: fileUrl.replaceFirst(AppConstants.imageBaseUrl, ''),
    );

    final Uri url = Uri.parse(file.file.path);
    final canLaunch = await canLaunchUrl(url);
    if (canLaunch) {
      launchUrl(url);
    } else {
      CustomAlert.showError("Can't Open This File".tr);
    }
  } catch (_) {}
}
