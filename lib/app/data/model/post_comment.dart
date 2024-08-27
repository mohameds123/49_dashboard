
import '../../core/constants.dart';
import '../../core/enums.dart';
import '../../core/helper/date.dart';
import '../../core/helper/timeago.dart';
import 'base_user.dart';

class PostCommentModel with TimeAgoMixin {
  final String id;
  final String userId;

  final String postId;
  final String? picture;

  String text;

  int totalLikes;
  int totalWoW;
  int totalAngry;
  int totalSad;
  int totalLove;

  int totalReplies;
  final BaseUser? user;

  final DateTime createdAt;

  ReactionType? reaction;


  int get totalReactions =>
      totalLikes + totalLove + totalWoW + totalSad + totalAngry;

  PostCommentModel({
    required this.id,
    required this.userId,
    required this.text,
    required this.postId,
    required this.picture,
    required this.totalLikes,
    required this.totalWoW,
    required this.totalAngry,
    required this.totalSad,
    required this.totalLove,
    required this.createdAt,
    required this.user,
    this.reaction,
    this.totalReplies = 0,
  });

  factory PostCommentModel.fromMap(Map<String, dynamic> map) {
    return PostCommentModel(
      id: map['_id'] as String,
      userId: map['user_id'] as String,
      text: map['text'] as String,
      postId: map['post_id'] as String? ?? '',
      totalLikes: map['total_likes'] as int,
      totalWoW: map['total_wow'] as int,
      totalAngry: map['total_angry'] as int,
      totalSad: map['total_sad'] as int,
      totalLove: map['total_love'] as int,
      totalReplies: map['total_replies'] as int? ?? 0,
      picture: map['picture'] == null
          ? null
          : AppConstants.imageBaseUrl + (map['picture'] as String),
      user: map['user'] == null
          ? null
          : BaseUser.fromMap(map['user'] as Map<String, dynamic>),
      reaction: map['reaction'] == null
          ? null
          : ReactionType.values[(map['reaction'] as int) - 1],
      createdAt: (map['createdAt'] as String).toDate(),
    );
  }

  @override
  DateTime get time => createdAt;
}
