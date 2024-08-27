import 'package:equatable/equatable.dart';

import '../../../core/constants.dart';
import '../base_user.dart';
import 'song.dart';

// ignore: must_be_immutable
class ReelModel extends Equatable {
  final String id;
  final String userId;
  String? videoLocalPath;
  String videoUrl;
  String videoThumbUrl;
  Song? reelSong;

  int totalViews;
  int totalLikes;

  int totalShare;
  final String desc;
  final bool isReel;
  bool isLiked;
  bool isViewed;

  BaseUser user;

  ReelModel({
    required this.id,
    required this.userId,
    this.videoLocalPath,
    required this.videoUrl,
    required this.videoThumbUrl,
    this.reelSong,
    required this.isReel,
    required this.desc,
    required this.totalViews,
    required this.totalLikes,
    required this.totalShare,
    required this.isLiked,
    required this.user,
    required this.isViewed,
  });

  factory ReelModel.fromMap(Map<String, dynamic> map) {
    return ReelModel(
      id: map['_id'] as String,
      videoUrl: AppConstants.imageBaseUrl + (map['video_url'] as String),
      videoThumbUrl: AppConstants.imageBaseUrl + (map['thumb_url'] as String),
      desc: map['desc'] as String,
      userId: map['user_id'] as String,
      isReel: map['is_reel'] as bool,
      totalLikes: map['total_likes'] as int,
      totalShare: map['total_shares'] as int,
      totalViews: map['total_views'] as int,
      isLiked: map['is_liked'] as bool,
      isViewed: map['is_viewed'] as bool,
      user: BaseUser.fromMap(map['user'] as Map<String, dynamic>),
      reelSong: map['song'] != null
          ? Song.fromMap(map['song'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [id];
}
