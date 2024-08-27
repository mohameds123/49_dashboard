import '../../core/constants.dart';

class BaseUser {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final String profileCover;
  final String phone;
  final bool isLocked;
  final String? tinderPicture;

  const BaseUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.phone,
    required this.isLocked,
    required this.profileCover,
    required this.tinderPicture,
  });

  factory BaseUser.fromMap(Map<String, dynamic> map) {
    return BaseUser(
      id: map['_id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      isLocked: map['is_locked'] as bool? ?? false,
      profilePicture: map['profile_picture'].toString().startsWith('http')
          ? map['profile_picture'].toString()
          : AppConstants.imageBaseUrl + (map['profile_picture'] as String),
      profileCover: map['profile_cover'] != null
          ? map['profile_cover'].toString().startsWith('http')
              ? map['profile_cover'].toString()
              : AppConstants.imageBaseUrl + (map['profile_cover'] as String)
          : '',
      tinderPicture: map['tinder_picture'] != null &&
              (map['tinder_picture'] as String).isNotEmpty
          ? map['tinder_picture'].toString().startsWith('http')
              ? map['tinder_picture'].toString()
              : AppConstants.imageBaseUrl + (map['tinder_picture'] as String)
          : null,
    );
  }

  String get fullName => '$firstName $lastName';
}
