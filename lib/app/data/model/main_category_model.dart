import '../../core/constants.dart';

class MainCategoryModel {
  final String id;
  String nameAr;
  String nameEn;

  String banner;
  String cover;
  final int index;

  MainCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.banner,
    required this.cover,
    required this.index,
  });

  String? bannerPath;
  String? coverPath;

  String get s3Banner => AppConstants.imageBaseUrl + banner;

  String get s3Cover => AppConstants.imageBaseUrl + cover;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'banner': banner.replaceFirst(AppConstants.imageBaseUrl, ''),
      'cover': cover.replaceFirst(AppConstants.imageBaseUrl, ''),
    };
  }

  factory MainCategoryModel.fromMap(Map<String, dynamic> json) {
    return MainCategoryModel(
      id: json["_id"] as String,
      nameAr: json["name_ar"] as String,
      nameEn: json["name_en"] as String,
      banner: json["banner"] as String,
      cover: json["cover"] as String,
      index: json["index"] as int,
    );
  }
}
