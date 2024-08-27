import '../../../core/enums.dart';
import '../base_user.dart';

class PeerProfileModel {
  final BaseUser user;

  final String? phone;
  final bool? isMale;
  final SocialStatus? socialStatus;
  final String? birthDate;
  final String? job;
  final String? city;
  final String? country;

  final String? referralName;
  final String? referralId;

  final int totalFriends;
  final int totalFollowers;
  final int totalFollowing;
  final int totalPosts;
  final bool isFriend;
  final bool isFollower;
  final bool isFriendRequestSent;

  final bool isFriendRequestEnable;
  final bool isMessageEnable;
  final bool isCallEnable;
  final bool isFriendListEnable;
  final bool isFollowListEnable;
  final String? bio;

  const PeerProfileModel({
    required this.user,
    required this.totalFriends,
    required this.totalFollowers,
    required this.totalFollowing,
    required this.totalPosts,
    required this.isFriend,
    required this.isFollower,
    required this.isFriendRequestSent,
    required this.phone,
    required this.country,
    required this.birthDate,
    required this.city,
    required this.job,
    required this.socialStatus,
    required this.isMale,
    required this.referralId,
    required this.referralName,
    required this.isFriendRequestEnable,
    required this.isMessageEnable,
    required this.isCallEnable,
    required this.isFollowListEnable,
    required this.isFriendListEnable,
    required this.bio,
  });

  factory PeerProfileModel.fromMap(Map<String, dynamic> map) {
    return PeerProfileModel(
      user: BaseUser.fromMap(map['user'] as Map<String, dynamic>),
      totalFriends: map["total_friends"] as int,
      totalFollowers: map["total_followers"] as int,
      totalFollowing: map["total_following"] as int,
      totalPosts: map["total_posts"] as int,
      isFriend: map['is_friend'] as bool,
      isFollower: map['is_follower'] as bool,
      isFriendRequestSent: map['friend_request_sent'] as bool,
      birthDate: map['birth_date'] as String?,
      city: map['city'] as String?,
      country: map['country'] as String?,
      isMale: map['is_male'] as bool?,
      socialStatus: (map['social_status'] as int? ?? 0) > 0 &&
              (map['social_status'] as int) < 6
          ? SocialStatus.values[(map['social_status'] as int) - 1]
          : null,
      job: map['job'] as String?,
      phone: map['phone'] as String?,
      referralId: map['referral_id'] as String?,
      referralName: map['referral_name'] as String?,
      isFriendRequestEnable: map['friend_request_enable'] as bool,
      isMessageEnable: map['is_message_enable'] as bool,
      isCallEnable: map['is_call_enable'] as bool,
      isFollowListEnable: map['is_follow_list_enable'] as bool,
      isFriendListEnable: map['is_friend_list_enable'] as bool,
      bio: map['bio'] as String?,
    );
  }
}
