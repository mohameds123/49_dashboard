import '../../core/helper/date.dart';
import '../../core/helper/timeago.dart';
import 'base_user.dart';

class ReportModel with TimeAgoMixin {
  final String id;
  final BaseUser? reporter;
  final BaseUser? user;
  final String reason;
  final String content;
  final bool nudity;
  final bool frequent;
  final bool fake;
  final bool abuse;
  final bool hated;
  final bool illegal;
  final bool another;
  final DateTime createdAt;

  final String userId;
  final String reporterId;

  const ReportModel({
    required this.id,
    this.reporter,
    this.user,
    required this.reason,
    required this.content,
    required this.nudity,
    required this.frequent,
    required this.fake,
    required this.abuse,
    required this.hated,
    required this.illegal,
    required this.another,
    required this.createdAt,
    required this.userId,
    required this.reporterId,
  });

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['_id'] as String,
      reporter:
          map['reporter'] != null ? BaseUser.fromMap(map['reporter']) : null,
      user: map['user'] != null ? BaseUser.fromMap(map['user']) : null,
      reason: map['reason'] as String,
      content: map['content'] as String,
      nudity: map['nudity'] as bool,
      frequent: map['frequent'] as bool,
      fake: map['fake'] as bool,
      abuse: map['abuse'] as bool,
      hated: map['hated'] as bool,
      illegal: map['illegal'] as bool,
      another: map['another'] as bool,
      createdAt: (map['createdAt'] as String).toDate(),
      userId: map['user_id'],
      reporterId: map['reporter_id'],
    );
  }

  @override
  DateTime get time => createdAt;
}
