import '../../core/constants.dart';
import 'base_user.dart';
import 'sub_category_model.dart';

class LoadingModel {
  final String id;
  final String categoryId;


  final SubCategoryModel category;
  final BaseUser? user;
  final List<String> carPictures;

  final String idFront;
  final String idBehind;

  final String drivingLicenseFront;
  final String drivingLicenseBehind;

  final String carLicenseFront;
  final String carLicenseBehind;

  String location;

   String carBrand;
   String carType;

  final double rating;

  final double profit;
  final int trips;

   LoadingModel({
    required this.id,
    required this.categoryId,
    required this.category,
    required this.carPictures,
    required this.idFront,
    required this.idBehind,
    required this.drivingLicenseFront,
    required this.drivingLicenseBehind,
    required this.carLicenseFront,
    required this.carLicenseBehind,
    required this.location,
    required this.carBrand,
    required this.carType,
    required this.rating,
    required this.profit,
    required this.trips,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'car_brand': carBrand,
      'car_type': carType,
      'location': location,
    };
  }

  factory LoadingModel.fromMap(Map<String, dynamic> map) {
    return LoadingModel(
      id: map['_id'] as String,
      categoryId: map['category_id'] as String,
      category:
          SubCategoryModel.fromMap(map['category'] as Map<String, dynamic>),
      carPictures: (map['car_pictures'] as List)
          .map((e) => AppConstants.imageBaseUrl + (e as String))
          .toList(),
      idFront: AppConstants.imageBaseUrl + (map['id_front'] as String),
      idBehind: AppConstants.imageBaseUrl + (map['id_behind'] as String),
      drivingLicenseFront:
          AppConstants.imageBaseUrl + (map['driving_license_front'] as String),
      drivingLicenseBehind:
          AppConstants.imageBaseUrl + (map['driving_license_behind'] as String),
      carLicenseFront:
          AppConstants.imageBaseUrl + (map['car_license_front'] as String),
      carLicenseBehind:
          AppConstants.imageBaseUrl + (map['car_license_behind'] as String),
      location: map['location'] as String,
      user: map['user'] == null ? null : BaseUser.fromMap(map['user']),
      carBrand: map['car_brand'] as String,
      carType: map['car_type'] as String,
      rating: double.parse(map['rating'].toString()),
      profit: double.parse(map['profit'].toString()),
      trips: map['trips'] as int,
    );
  }
}
