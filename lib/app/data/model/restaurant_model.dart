import '../../core/constants.dart';
import 'base_user.dart';
import 'sub_category_model.dart';

class RestaurantModel {
  final String id;
  final String categoryId;
  final SubCategoryModel? category;

  final String userId;
  final List<String> pictures;
  final String name;
  String location;
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

  final BaseUser? user;

   RestaurantModel({
    required this.id,
    required this.categoryId,
    required this.category,
    required this.userId,
    required this.pictures,
    required this.name,
    required this.location,
    required this.workFrom,
    required this.workTo,
    required this.availableDays,
    required this.rating,
    this.mainCategoryName,
    this.subCategoryName,
    required this.isOpened,
    required this.isPremium,
    required this.isSubscription,
    required this.total,
    required this.user,
  });

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: map['_id'] as String,
      categoryId: map['category_id'] as String,
      category:map['category'] == null ? null : SubCategoryModel.fromMap(map['category'] as Map<String, dynamic>),
      userId: map['user_id'] as String,
      pictures: (map['pictures'] as List)
          .map((e) =>
              (e.toString().startsWith('http')
                  ? ''
                  : AppConstants.imageBaseUrl) +
              (e as String))
          .toList(),
      name: map['name'] as String,
      location: map['location'] as String,
      workFrom: map['work_from'] as int,
      workTo: map['work_to'] as int,
      availableDays: (map['available_day'] as List).cast(),
      rating: double.parse(map['rating'].toString()),
      mainCategoryName: map['main_category_name'] as String?,
      subCategoryName: map['sub_category_name'] as String?,
      total: map['total'] as int? ?? 0,
      isOpened: map['is_opened'] as bool? ?? false,
      isPremium: map['is_premium'] as bool? ?? false,
      isSubscription: map['is_subscription'] as bool? ?? false,
      user: map['user'] == null ? null : BaseUser.fromMap(map['user']),
    );
  }
}
