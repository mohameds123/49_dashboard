import '../../core/constants.dart';
import '../../core/helper/date.dart';
import '../../core/helper/timeago.dart';
import 'base_user.dart';
import 'sub_category_model.dart';

class DoctorModel with TimeAgoMixin {
  final String id;
  final String name;

  final String categoryId;

  final SubCategoryModel? category;
  final BaseUser? user;

  final String userId;
  final String picture;

  String location;

  final String idFront;
  final String idBehind;

  final String practiceLicenseFront;
  final String practiceLicenseBehind;

  String specialty;
  final int examinationPrice;
  final int waitingTime;

  final int workFrom;
  final int workTo;

  final List<int> availableDays;
  final double rating;

  final String? mainCategoryName;
  final String? subCategoryName;
  final bool isOpened;
  final bool isPremium;
  final bool isSubscription;

  final int total;

  final DateTime createdAt;

  DoctorModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.category,
    required this.userId,
    required this.picture,
    required this.location,
    required this.idFront,
    required this.idBehind,
    required this.practiceLicenseFront,
    required this.practiceLicenseBehind,
    required this.specialty,
    required this.examinationPrice,
    required this.waitingTime,
    required this.workFrom,
    required this.workTo,
    required this.availableDays,
    required this.rating,
    this.mainCategoryName,
    this.subCategoryName,
    required this.isOpened,
    required this.isPremium,
    required this.isSubscription,
    required this.createdAt,
    required this.user,
    this.total = 1,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['_id'] as String,
      categoryId: map['category_id'] as String,
      name: map['name'] as String? ?? '',
      category: map['category'] == null
          ? null
          : SubCategoryModel.fromMap(map['category'] as Map<String, dynamic>),
      userId: map['user_id'] as String,
      picture: map['picture'].toString().startsWith('http')
          ? map['picture'].toString()
          : AppConstants.imageBaseUrl + map['picture'].toString(),
      idFront: AppConstants.imageBaseUrl + (map['id_front'] ?? ''),
      idBehind: AppConstants.imageBaseUrl + (map['id_behind'] ?? ''),
      practiceLicenseFront:
          AppConstants.imageBaseUrl + (map['practice_license_front'] ?? ''),
      practiceLicenseBehind:
          AppConstants.imageBaseUrl + (map['practice_license_behind'] ?? ''),
      location: map['location'] as String,
      specialty: map['specialty'] as String,
      workFrom: map['work_from'] as int,
      workTo: map['work_to'] as int,
      availableDays: (map['available_day'] as List).cast(),
      rating: double.parse(map['rating'].toString()),
      examinationPrice: int.parse(map['examination_price'].toString()),
      waitingTime: int.parse(map['waiting_time'].toString()),
      mainCategoryName: map['main_category_name'] as String?,
      subCategoryName: map['sub_category_name'] as String?,
      total: map['total'] as int? ?? 0,
      isOpened: map['is_opened'] as bool? ?? false,
      isPremium: map['is_premium'] as bool? ?? false,
      isSubscription: map['is_subscription'] as bool? ?? false,
      createdAt: (map['createdAt'] as String).toDate(),
      user: map['user'] == null ? null : BaseUser.fromMap(map['user']),
    );
  }

  @override
  DateTime get time => createdAt;
}
