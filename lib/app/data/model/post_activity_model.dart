import '../../core/constants.dart';

class PostActivityModel {
  final String id;
  String nameAr;
  String nameEn;
  String? picture;

  PostActivityModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.picture,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
      };

  factory PostActivityModel.fromMap(Map<String, dynamic> map) {
    return PostActivityModel(
      id: map['_id'] as String,
      nameAr: map['name_ar'] as String,
      nameEn: map['name_en'] as String,
      picture: map['picture'] == null
          ? map['picture']
          : AppConstants.imageBaseUrl + map['picture'],
    );
  }
}
