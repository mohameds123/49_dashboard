import 'base_user.dart';
import 'sub_category_model.dart';

import '../../core/constants.dart';

class RiderRegistrationInfoModel {
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

  final String? criminalRecord;
  final String? technicalExamination;
  final String? drugAnalysis;

  final double pricingPerKm;

  String carBrand;
  String carType;

  String carPlateLetters;
  String carPlateNumbers;

  final double rating;

  final bool isReady;

  final double profit;
  final double indebtedness;
  final int trips;

  RiderRegistrationInfoModel({
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
    required this.criminalRecord,
    required this.technicalExamination,
    required this.drugAnalysis,
    required this.pricingPerKm,
    required this.carBrand,
    required this.carType,
    required this.carPlateLetters,
    required this.carPlateNumbers,
    required this.rating,
    required this.isReady,
    required this.profit,
    required this.indebtedness,
    required this.trips,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'car_brand': carBrand,
      'car_type': carType,
      'car_plate_letters': carPlateLetters,
      'car_plate_numbers': carPlateNumbers,
    };
  }

  factory RiderRegistrationInfoModel.fromMap(Map<String, dynamic> map) {
    return RiderRegistrationInfoModel(
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
      criminalRecord: map['criminal_record'] == null
          ? null
          : AppConstants.imageBaseUrl + (map['criminal_record'] as String),
      technicalExamination: map['technical_examination'] == null
          ? null
          : AppConstants.imageBaseUrl +
              (map['technical_examination'] as String),
      drugAnalysis: map['drug_analysis'] == null
          ? null
          : AppConstants.imageBaseUrl + (map['drug_analysis'] as String),
      pricingPerKm: double.parse(map['pricing_per_km'].toString()),
      carBrand: map['car_brand'] as String,
      user: map['user'] == null ? null : BaseUser.fromMap(map['user']),
      carType: map['car_type'] as String,
      carPlateLetters: map['car_plate_letters'] as String,
      carPlateNumbers: map['car_plate_numbers'] as String,
      rating: double.parse(map['rating'].toString()),
      isReady: map['is_ready'] as bool,
      profit: double.parse(map['profit'].toString()),
      indebtedness: double.parse(map['indebtedness'].toString()),
      trips: map['trips'] as int,
    );
  }
}
