import '../../../core/constants.dart';
import '../../../core/helper/date.dart';
import '../../../core/helper/timeago.dart';
import '../base_user.dart';
import 'dynamic_prop_model.dart';

class DynamicAdModel with TimeAgoMixin {
  final String id;
  final String subCategoryId;
  final String userId;
  final String title;
  final String description;
  final List<String> pictures;
  final List<DynamicPropModel> props;

  final bool isSubscription;
  final bool isApproved;
  final bool isActive;
  final bool isPremium;
  final String? subCategoryName;
  final String? subCategoryParent;
  String? mainCategoryName;
  final DateTime createdAt;

  bool isFavorite = false;

  final BaseUser? user;

  DynamicAdModel({
    required this.id,
    required this.userId,
    required this.subCategoryId,
    required this.pictures,
    required this.title,
    required this.description,
    required this.props,
    required this.isApproved,
    required this.isActive,
    required this.isFavorite,
    required this.isPremium,
    required this.createdAt,
    required this.isSubscription,
    this.subCategoryName,
    this.mainCategoryName,
    this.subCategoryParent,
    this.user,
  });

  factory DynamicAdModel.fromMap(Map<String, dynamic> map) {
    return DynamicAdModel(
      id: map['_id'] as String,
      subCategoryId: map['sub_category_id'] as String,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      description: map['desc'] as String,
      pictures: (map['pictures'] as List)
          .map((e) => AppConstants.imageBaseUrl + e.toString())
          .toList(),
      props: (map['props'] as List)
          .map((e) => DynamicPropModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      isApproved: map['is_approved'] as bool,
      isActive: map['is_active'] as bool,
      isSubscription: map['is_subscription'] as bool,
      isPremium: map['is_premium'] as bool,
      isFavorite: map['is_favorite'] as bool,
      subCategoryName: map['sub_category_name'] as String?,
      subCategoryParent: map['sub_category_parent'] as String?,
      user: map['user'] != null ? BaseUser.fromMap(map['user']) : null,
      createdAt: (map['createdAt'] as String).toDate(),
    );
  }

  @override
  DateTime get time => createdAt;
}
