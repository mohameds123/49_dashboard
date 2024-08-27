import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:get/get.dart';

import '../../../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../../../core/widget/custom_alert.dart';
import '../../../../../../data/model/chat_message_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MessageController extends GetxController {
  final List<String> messagesIds;

  final messages = RxList<ChatMessageModel>();

  MessageController(this.messagesIds);

  @override
  void onInit() {
    _getMessages();
    super.onInit();
  }
  @override
  void onClose() {
    messages.forEach((e) { e.recordPlayerController?.dispose();});
    super.onClose();
  }

  void _getMessages() async {
    try {
      final result = await CustomDio(enableLog: true).post(
        'admin/get-reported-messages',
        body: {
          'ids': messagesIds,
        },
      );
      messages.value = (result.data['data'] as List)
          .map((e) => ChatMessageModel.fromJson(e))
          .toList();

      final recordsMessages =
          messages.where((e) => e.recordAttachments.isNotEmpty).toList();
      recordsMessages.forEach((message) {
        loadRecords(message);
      });
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  Future<void> loadRecords(ChatMessageModel message) async {
    message.recordPlayerController = PlayerController();
    message.recordPlayerController!.onPlayerStateChanged.listen((v) {
      if (v == PlayerState.paused) {
        message.recordPlayerController!
            .getDuration(DurationType.current)
            .then((duration) {
          if (duration == 0) {
            final messageIndex = messages.indexOf(message);

            if (messageIndex > -1 &&
                messages.length - 1 > messageIndex &&
                messages[messageIndex + 1].recordAttachments.isNotEmpty) {
              final nextMessage = messages[messageIndex + 1];
              nextMessage.recordPlayerController
                  ?.startPlayer(finishMode: FinishMode.pause);

            }
          }
        });
      }
      messages.refresh();
    });
    DefaultCacheManager()
        .getSingleFile(
      message.recordAttachments.first,
      key: message.recordAttachments.first,
    )
        .then((file) {
      message.recordPlayerController!.preparePlayer(file.path, 1.0).then((_) {
        message.recordPlayerController!.getDuration().then((duration) {
          message.recordDuration = Duration(milliseconds: duration);
          messages.refresh();
        });
      });
    });
  }
}
