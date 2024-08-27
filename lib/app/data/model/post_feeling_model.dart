import '../../core/constants.dart';

class PostFeelingModel {
  final String id;
  String nameAr;
  String nameEn;
  final String? picture;

  PostFeelingModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.picture,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
        'picture': picture?.replaceFirst(AppConstants.imageBaseUrl, ''),
      };

  factory PostFeelingModel.fromMap(Map<String, dynamic> map) {
    return PostFeelingModel(
      id: map['_id'] as String,
      nameEn: map['name_en'] as String,
      nameAr: map['name_ar'] as String,
      picture: map['picture'] == null
          ? null
          : AppConstants.imageBaseUrl + map['picture'],
    );
  }
}
