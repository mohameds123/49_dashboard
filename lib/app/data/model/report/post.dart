import 'package:equatable/equatable.dart';

import '../../../core/constants.dart';
import '../../../core/enums.dart';
import '../../../core/helper/date.dart';
import '../base_user.dart';
import '../post_activity_model.dart';
import '../post_feeling_model.dart';

// ignore: must_be_immutable
class PostModel extends Equatable {
  final String id;

  final String userId;

  String text;
  int totalComments;
  int totalShares;

  int totalLikes;
  int totalWoW;
  int totalAngry;
  int totalSad;
  int totalLove;

  PrivacyStatus privacy;
  PrivacyStatus commentPrivacy;

  final List<String> pictures;

  final PostFeelingModel? feeling;
  final PostActivityModel? activity;
  final String location;

  final int? background;
  List<BaseUser> tags;

  final bool isCommentsEnable;

  ReactionType? reaction;

  final BaseUser? user;

  final DateTime createdAt;

  int get totalReactions =>
      totalLikes + totalLove + totalWoW + totalSad + totalAngry;

  final String? travelFrom;
  final String? travelTo;

  PostModel({
    required this.id,
    required this.text,
    required this.userId,
    required this.totalComments,
    required this.location,
    required this.privacy,
    required this.commentPrivacy,
    required this.createdAt,
    required this.pictures,
    required this.user,
    required this.isCommentsEnable,
    required this.totalShares,
    required this.totalLikes,
    required this.totalWoW,
    required this.totalAngry,
    required this.totalSad,
    required this.totalLove,
    required this.feeling,
    required this.activity,
    required this.reaction,
    required this.background,
    required this.tags,
    this.travelFrom,
    this.travelTo,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    final post = map;
    final postModel = PostModel(
      id: post['_id'] as String,
      text: post['text'] as String,
      userId: post['user_id'] as String,
      totalComments: post['total_comments'] as int,
      totalShares: post['total_shares'] as int,
      location: (post['location'] as String?) ?? "",
      totalLikes: post['total_likes'] as int,
      totalWoW: post['total_wow'] as int,
      totalAngry: post['total_angry'] as int,
      totalSad: post['total_sad'] as int,
      totalLove: post['total_love'] as int,
      background: post['background'] as int?,
      travelFrom: post['travel_from'] as String?,
      travelTo: post['travel_to'] as String?,
      privacy: PrivacyStatus.values[(post['privacy'] as int) - 1],
      commentPrivacy:
          PrivacyStatus.values[(post['comment_privacy'] as int) - 1],
      isCommentsEnable: post['is_comments_enable'] as bool,
      pictures: (post['pictures'] as List)
          .map((e) => AppConstants.imageBaseUrl + (e as String))
          .toList(),
      user: map['user'] == null
          ? null
          : BaseUser.fromMap(post['user'] as Map<String, dynamic>),
      activity: post['activity'] != null
          ? PostActivityModel.fromMap(post['activity'] as Map<String, dynamic>)
          : null,
      feeling: post['feeling'] != null
          ? PostFeelingModel.fromMap(post['feeling'] as Map<String, dynamic>)
          : null,
      reaction: post['reaction'] == null
          ? null
          : ReactionType.values[(post['reaction'] as int) - 1],
      createdAt: (post['createdAt'] as String).toDate(),
      tags: (post['tag_users'] as List)
          .map((e) => BaseUser.fromMap(e as Map<String, dynamic>))
          .toList(),
    );

    return postModel;
  }

  @override
  List<Object?> get props => [id];
}
