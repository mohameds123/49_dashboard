import 'base_user.dart';

class MonthlyContestModel {
  final String id;
  final String userId;
  final String adId;
  final String phone;
  final bool isPayValid;
  final bool isWinner;
  final String date;
  final BaseUser? user;

  final int? times;

  const MonthlyContestModel({
    required this.id,
    required this.userId,
    required this.adId,
    required this.phone,
    required this.isPayValid,
    required this.isWinner,
    required this.date,
    required this.user,
    this.times,
  });

  factory MonthlyContestModel.fromMap(Map<String, dynamic> map) {
    return MonthlyContestModel(
      id: map['_id'] as String,
      userId: map['user_id'] as String,
      adId: map['ad_id'] as String,
      phone: map['phone'] as String,
      isPayValid: map['is_pay_valid'] as bool,
      isWinner: map['is_winner'] as bool,
      date: map['date'] as String,
      user: map['user'] != null
          ? BaseUser.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      times: map['times'] as int?,
    );
  }
}
