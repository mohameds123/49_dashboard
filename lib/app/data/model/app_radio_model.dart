import '../../core/constants.dart';
import '../../core/enums.dart';
import 'base_user.dart';

class AppRadioModel {
  final String id;
  String? text;
  AppRadioTypes type;
  String? voice;
  String? video;
  String? picture;
  String? userId;
  BaseUser? user;
  AppRadioCategories category;
  bool isActive;
  int days;

  AppRadioModel({
    required this.id,
    required this.text,
    required this.type,
    required this.voice,
    required this.video,
    this.picture,
    this.userId,
    this.user,
    required this.isActive,
    required this.days,
    required this.category,
  });

  factory AppRadioModel.fromMap(Map<String, dynamic> map) {
    return AppRadioModel(
      id: map['_id'] as String,
      text: map['text'] as String?,
      type: AppRadioTypes.values[map['type'] - 1],
      voice: map['voice'] != null
          ? AppConstants.imageBaseUrl + map['voice']
          : null,
      video: map['video'] != null
          ? AppConstants.imageBaseUrl + map['video']
          : null,
      picture: map['picture'] != null
          ? AppConstants.imageBaseUrl + map['picture']
          : null,
      userId: map['user_id'] as String?,
      isActive: map['is_active'] as bool,
      days: map['days'] as int,
      user: map['user'] != null ? BaseUser.fromMap(map['user']) : null,
      category: AppRadioCategories.values[map['category'] - 1],
    );
  }
}
