import '../../core/helper/date.dart';
import '../../core/helper/timeago.dart';

class ReferralModel with TimeAgoMixin {
  final String id;
  final String firstName;
  final String lastName;
  int lockedDays;
  final DateTime createdAt;

  ReferralModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.lockedDays,
    required this.createdAt,
  });

  factory ReferralModel.fromMap(Map<String, dynamic> map) {
    return ReferralModel(
      id: map['_id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      lockedDays: map['locked_days'] as int,
      createdAt: (map['createdAt'] as String).toDate(),
    );
  }

  String get fullName => '${firstName.trim()} ${lastName.trim()}';
  @override
  DateTime get time => createdAt;
}
