import 'wallet_model.dart';

import '../../core/constants.dart';
import '../../core/enums.dart';

class ProfileModel {
  String id;
  String firstName;
  String lastName;
  String? phone;
  String email;
  String provider;
  String birthDate;
  String? referralId;
  String hashNumber;
  String profilePicture;
  String coverPicture;
  String tinderPicture;
  String country;
  String city;
  String language;
  String job;
  SocialStatus? socialStatus;
  bool? isMale;
  bool isLocked;
  int lockedDays;
  String token;
  String currency;

  PrivacyStatus countryPrivacy;
  PrivacyStatus phonePrivacy;
  PrivacyStatus birthDatePrivacy;
  PrivacyStatus socialStatusPrivacy;
  PrivacyStatus jobPrivacy;
  PrivacyStatus cityPrivacy;
  PrivacyStatus genderPrivacy;
  PrivacyStatus languagePrivacy;

  PrivacyStatus receiveMessagesPrivacy;
  PrivacyStatus lastSeenPrivacy;
  PrivacyStatus friendListPrivacy;
  PrivacyStatus followerListPrivacy;
  PrivacyStatus activityPrivacy;
  PrivacyStatus randomAppearancePrivacy;
  PrivacyStatus friendRequestPrivacy;
  PrivacyStatus followRequestPrivacy;
  PrivacyStatus callPrivacy;

  WalletModel wallet;

  final int referralCount;
  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phone,
    required this.email,
    required this.provider,
    required this.birthDate,
    this.referralId,
    required this.hashNumber,
    required this.profilePicture,
    required this.coverPicture,
    required this.tinderPicture,
    required this.country,
    required this.city,
    required this.language,
    required this.job,
    required this.socialStatus,
    required this.lockedDays,
    required this.isMale,
    required this.isLocked,
    required this.token,
    required this.countryPrivacy,
    required this.phonePrivacy,
    required this.birthDatePrivacy,
    required this.socialStatusPrivacy,
    required this.jobPrivacy,
    required this.cityPrivacy,
    required this.genderPrivacy,
    required this.languagePrivacy,
    required this.receiveMessagesPrivacy,
    required this.lastSeenPrivacy,
    required this.friendListPrivacy,
    required this.followerListPrivacy,
    required this.activityPrivacy,
    required this.randomAppearancePrivacy,
    required this.friendRequestPrivacy,
    required this.followRequestPrivacy,
    required this.callPrivacy,
    required this.currency,
    required this.wallet,
    required this.referralCount,
  });

  String get fullName => '$firstName $lastName';

  int totalPosts = 0;
  int totalFriends = 0;
  int totalFollowers = 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'birth_date': birthDate,
      'referral_id': referralId,
      'hash_code': hashNumber,
      'profile_picture': profilePicture,
      'cover_picture': coverPicture,
      'tinder_picture': tinderPicture,
      'country': country,
      'city': city,
      'job': job,
      'language': language,
      'social_status': socialStatus != null ? socialStatus!.index + 1 : 0,
      'is_male': isMale,
      'is_locked': isLocked,
      'privacy_country': countryPrivacy.index + 1,
      'privacy_phone': phonePrivacy.index + 1,
      'privacy_birth_date': birthDatePrivacy.index + 1,
      'privacy_social_status': socialStatusPrivacy.index + 1,
      'privacy_job': jobPrivacy.index + 1,
      'privacy_city': cityPrivacy.index + 1,
      'privacy_is_male': genderPrivacy.index + 1,
      'privacy_language': languagePrivacy.index + 1,
      'privacy_receive_messages': receiveMessagesPrivacy.index + 1,
      'privacy_last_seen': lastSeenPrivacy.index + 1,
      'privacy_friend_list': friendListPrivacy.index + 1,
      'privacy_follower_list': followerListPrivacy.index + 1,
      'privacy_activity': activityPrivacy.index + 1,
      'privacy_random_appearance': randomAppearancePrivacy.index + 1,
      'privacy_friend_request': friendRequestPrivacy.index + 1,
      'privacy_follow_request': followRequestPrivacy.index + 1,
      'privacy_call': callPrivacy.index + 1,
      'wallet': wallet.toMap(),
      'locked_days': lockedDays,
      'email': email,
      'provider': provider,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['_id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      phone: map['phone'] as String?,
      birthDate: map['birth_date'] as String,
      referralId: map['referral_id'] as String?,
      hashNumber: map['hash_code'] as String,
      profilePicture: map['profile_picture'].toString().startsWith('http')
          ? map['profile_picture'] as String
          : AppConstants.imageBaseUrl + (map['profile_picture'].toString()),
      coverPicture: map['cover_picture'].toString().startsWith('http')
          ? map['cover_picture'] as String
          : AppConstants.imageBaseUrl + (map['cover_picture'].toString()),
      tinderPicture: map['tinder_picture'].toString().startsWith('http')
          ? map['tinder_picture'] as String
          : AppConstants.imageBaseUrl + (map['tinder_picture'].toString()),
      country: map['country'] as String,
      city: map['city'] as String,
      job: map['job'] as String,
      language: map['language'] as String,
      socialStatus:
          (map['social_status'] as int) > 0 && (map['social_status'] as int) < 6
              ? SocialStatus.values[(map['social_status'] as int) - 1]
              : null,
      isMale: map['is_male'] as bool?,
      isLocked: map['is_locked'] as bool,
      token: map['token'] as String? ?? '',
      countryPrivacy: PrivacyStatus.values[(map['privacy_country'] as int) - 1],
      phonePrivacy: PrivacyStatus.values[(map['privacy_phone'] as int) - 1],
      birthDatePrivacy:
          PrivacyStatus.values[(map['privacy_birth_date'] as int) - 1],
      socialStatusPrivacy:
          PrivacyStatus.values[(map['privacy_social_status'] as int) - 1],
      jobPrivacy: PrivacyStatus.values[(map['privacy_job'] as int) - 1],
      cityPrivacy: PrivacyStatus.values[(map['privacy_city'] as int) - 1],
      genderPrivacy: PrivacyStatus.values[(map['privacy_is_male'] as int) - 1],
      languagePrivacy:
          PrivacyStatus.values[(map['privacy_language'] as int) - 1],
      receiveMessagesPrivacy:
          PrivacyStatus.values[(map['privacy_receive_messages'] as int) - 1],
      lastSeenPrivacy:
          PrivacyStatus.values[(map['privacy_last_seen'] as int) - 1],
      friendListPrivacy:
          PrivacyStatus.values[(map['privacy_friend_list'] as int) - 1],
      followRequestPrivacy:
          PrivacyStatus.values[(map['privacy_follow_request'] as int) - 1],
      activityPrivacy:
          PrivacyStatus.values[(map['privacy_activity'] as int) - 1],
      randomAppearancePrivacy:
          PrivacyStatus.values[(map['privacy_random_appearance'] as int) - 1],
      friendRequestPrivacy:
          PrivacyStatus.values[(map['privacy_friend_request'] as int) - 1],
      followerListPrivacy:
          PrivacyStatus.values[(map['privacy_follower_list'] as int) - 1],
      callPrivacy: PrivacyStatus.values[(map['privacy_call'] as int) - 1],
      currency: map['currency'] as String? ?? '',
      provider: map['provider'] as String,
      email: map['email'] as String,
      wallet: WalletModel.fromMap(map['wallet']),
      lockedDays: map['locked_days'] as int? ?? 0,
      referralCount: map['referral_count'] as int? ?? 0,
    );
  }

  ProfileModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? birthDate,
    String? referralId,
    String? hashNumber,
    String? profilePicture,
    String? coverPicture,
    String? tinderPicture,
    String? country,
    String? city,
    String? language,
    String? job,
    SocialStatus? socialStatus,
    bool? isMale,
    bool? isLocked,
    String? token,
    PrivacyStatus? countryPrivacy,
    PrivacyStatus? emailPrivacy,
    PrivacyStatus? phonePrivacy,
    PrivacyStatus? birthDatePrivacy,
    PrivacyStatus? socialStatusPrivacy,
    PrivacyStatus? jobPrivacy,
    PrivacyStatus? cityPrivacy,
    PrivacyStatus? genderPrivacy,
    PrivacyStatus? languagePrivacy,
    PrivacyStatus? receiveMessagesPrivacy,
    PrivacyStatus? lastSeenPrivacy,
    PrivacyStatus? friendListPrivacy,
    PrivacyStatus? followListPrivacy,
    PrivacyStatus? activityPrivacy,
    PrivacyStatus? randomAppearancePrivacy,
    PrivacyStatus? friendRequestPrivacy,
    PrivacyStatus? followRequestPrivacy,
    PrivacyStatus? callPrivacy,
    String? currency,
    PrivacyStatus? followerListPrivacy,
    String? provider,
    String? email,
    WalletModel? wallet,
    int? lockedDays,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      referralId: referralId ?? this.referralId,
      hashNumber: hashNumber ?? this.hashNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      coverPicture: coverPicture ?? this.coverPicture,
      tinderPicture: tinderPicture ?? this.tinderPicture,
      country: country ?? this.country,
      city: city ?? this.city,
      language: language ?? this.language,
      job: job ?? this.job,
      socialStatus: socialStatus ?? this.socialStatus,
      isMale: isMale ?? this.isMale,
      isLocked: isLocked ?? this.isLocked,
      token: token ?? this.token,
      countryPrivacy: countryPrivacy ?? this.countryPrivacy,
      phonePrivacy: phonePrivacy ?? this.phonePrivacy,
      birthDatePrivacy: birthDatePrivacy ?? this.birthDatePrivacy,
      socialStatusPrivacy: socialStatusPrivacy ?? this.socialStatusPrivacy,
      jobPrivacy: jobPrivacy ?? this.jobPrivacy,
      cityPrivacy: cityPrivacy ?? this.cityPrivacy,
      genderPrivacy: genderPrivacy ?? this.genderPrivacy,
      languagePrivacy: languagePrivacy ?? this.languagePrivacy,
      receiveMessagesPrivacy:
          receiveMessagesPrivacy ?? this.receiveMessagesPrivacy,
      lastSeenPrivacy: lastSeenPrivacy ?? this.lastSeenPrivacy,
      friendListPrivacy: friendListPrivacy ?? this.friendListPrivacy,
      followerListPrivacy: followerListPrivacy ?? this.followerListPrivacy,
      activityPrivacy: activityPrivacy ?? this.activityPrivacy,
      randomAppearancePrivacy:
          randomAppearancePrivacy ?? this.randomAppearancePrivacy,
      friendRequestPrivacy: friendRequestPrivacy ?? this.friendRequestPrivacy,
      followRequestPrivacy: followRequestPrivacy ?? this.followRequestPrivacy,
      callPrivacy: callPrivacy ?? this.callPrivacy,
      currency: currency ?? this.currency,
      email: email ?? this.email,
      provider: provider ?? this.provider,
      wallet: wallet ?? this.wallet,
      lockedDays: lockedDays ?? this.lockedDays,
      referralCount: this.referralCount,
    );
  }
}
