import 'dart:convert';
import 'package:audio_waveforms/audio_waveforms.dart';

import '../../core/constants.dart';
import '../../core/enums.dart';
import '../../core/helper/date.dart';
import 'attachment_model.dart';

class ChatMessageModel {
  String id;
  final String contactId;
  String text;
  DateTime date;

  List<NewChatAttachmentModel> attachments;

  int totalSent;
  int totalSeen;

  int totalLikes;
  int totalWow;
  int totalAngry;
  int totalSad;
  int totalLove;
  bool isSentDone;
  bool isDeleted;
  bool isForward;
  bool? isSeenDone;

  ChatMessageModel? replayMessage;

  final ChatContactTypes type;
  
  int get totalReactions =>
      totalLikes + totalLove + totalWow + totalSad + totalAngry;

  List<String> get picturesAttachments => attachments
      .where((e) => e.type == ChatAttachmentTypes.picture)
      .map(
        (e) => e.url.startsWith(AppConstants.imageBaseUrl)
            ? e.url
            : AppConstants.imageBaseUrl + e.url,
      )
      .toList();

  List<String> get videosAttachments => attachments
      .where((e) => e.type == ChatAttachmentTypes.video)
      .map(
        (e) => e.url.startsWith(AppConstants.imageBaseUrl)
            ? e.url
            : AppConstants.imageBaseUrl + e.url,
      )
      .toList();

  List<String> get filesAttachments => attachments
      .where((e) => e.type == ChatAttachmentTypes.file)
      .map(
        (e) => e.url.startsWith(AppConstants.imageBaseUrl)
            ? e.url
            : AppConstants.imageBaseUrl + e.url,
      )
      .toList();

  List<NewChatAttachmentModel> get locationAttachments =>
      attachments.where((e) => e.type == ChatAttachmentTypes.location).toList();

  List<String> get recordAttachments => attachments
      .where((e) => e.type == ChatAttachmentTypes.record)
      .map(
        (e) => e.url.startsWith(AppConstants.imageBaseUrl)
            ? e.url
            : AppConstants.imageBaseUrl + e.url,
      )
      .toList();

  PlayerController? recordPlayerController;
  Duration? recordDuration;

  ChatMessageModel({
  required  this.id,
    required this.contactId,
    required this.text,
    required this.date,
    required this.attachments,
    this.totalSent = 0,
    this.totalSeen = 0,
    this.totalLikes = 0,
    this.totalWow = 0,
    this.totalAngry = 0,
    this.totalSad = 0,
    this.totalLove = 0,
    this.isSentDone = false,
    this.isDeleted = false,
    this.isForward = false,
    this.isSeenDone,
    this.replayMessage,
    this.recordDuration,
    required this.type,
  });


  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['id'] as String,
      contactId: map['contact_id'] as String,
      text: map['text'] as String,
      date: (map['date'] as String? ?? '').toDate(),
      attachments: (jsonDecode(map['attachments'] as String) as List)
          .map((e) => NewChatAttachmentModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      totalSeen: map['total_seen'] as int,
      totalSent: map['total_sent'] as int,
      totalLikes: map['total_likes'] as int,
      totalWow: map['total_wow'] as int,
      totalAngry: map['total_angry'] as int,
      totalSad: map['total_sad'] as int,
      totalLove: map['total_love'] as int,
      isSentDone: map['sent_done'] == 1,
      isSeenDone: map['seen_done'] == null ? null : map['seen_done'] == 1,
      isDeleted: map['is_deleted'] == 1,
      isForward: map['is_forward'] == 1,
      type: ChatContactTypes.values[(int.parse(map['type'].toString())) - 1],
      replayMessage: map['replay_message'] == null
          ? null
          : ChatMessageModel.fromMap(
              jsonDecode(map['replay_message'] as String)
                  as Map<String, dynamic>,
            ),
    );
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['_id'] as String,
      contactId: map['contact_id'] as String,
      text: map['text'] as String,
      date: (map['date'] as String).toDate(),
      attachments: (map['attachments'] as List)
          .where(
            (e) =>
                (((e as Map<String, dynamic>)['type'] as int) - 1) <
                ChatAttachmentTypes.values.length,
          )
          .map((e) => NewChatAttachmentModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      totalSeen: map['total_seen'] as int? ?? 0,
      totalSent: map['total_sent'] as int? ?? 0,
      totalLikes: map['total_likes'] as int? ?? 0,
      totalWow: map['total_wow'] as int? ?? 0,
      totalAngry: map['total_angry'] as int? ?? 0,
      totalSad: map['total_sad'] as int? ?? 0,
      totalLove: map['total_love'] as int? ?? 0,
      isForward: map['is_forward'] as bool? ?? false,
      replayMessage: map['replay_message'] == null
          ? null
          : ChatMessageModel.fromMap(
              map['replay_message'] as Map<String, dynamic>,
            ),
      type: ChatContactTypes.values[(int.parse(map['type'].toString())) - 1],
    );
  }
}
