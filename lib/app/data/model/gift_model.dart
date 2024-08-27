import '../../core/constants.dart';

class GiftModel {
  final String id;
  final String picture;
   String nameAr;
   String nameEn;

   double value;

   GiftModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.picture,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_er': nameAr,
      'name_en': nameEn,
      'value': value,
    };
  }

  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      id: map['_id'] as String,
      nameAr: map['name_ar'] as String,
      nameEn: map['name_en'] as String,
      picture: AppConstants.imageBaseUrl + (map['picture'] as String),
      value: double.parse(map['value'].toString()),
    );
  }
}
