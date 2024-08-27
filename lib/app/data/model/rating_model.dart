
import '../../core/helper/date.dart';
import '../../core/helper/timeago.dart';
import 'base_user.dart';

class RatingModel with TimeAgoMixin{
  final String id;
  final String categoryId;
  final String userId;
  final double fieldOne;
  final double fieldTwo;
  final double fieldThree;
  final String comment;

  final BaseUser? user;

  final DateTime createdAt;

  const RatingModel({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.fieldOne,
    required this.fieldTwo,
    required this.fieldThree,
    required this.comment,
    required this.user,
    required this.createdAt,
  });

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      id: map['_id'] as String,
      categoryId: map['category_id'] as String,
      userId: map['user_id'] as String,
      fieldOne: double.parse(map['field_one'].toString()),
      fieldTwo: double.parse(map['field_two'].toString()),
      fieldThree: double.parse(map['field_three'].toString()),
      comment: map['comment'] as String,
      createdAt: (map['createdAt'] as String).toDate(),
      user: map['user'] == null
          ? null
          : BaseUser.fromMap(map['user'] as Map<String, dynamic>),
    );
  }


  @override
  DateTime get time => createdAt;
}
