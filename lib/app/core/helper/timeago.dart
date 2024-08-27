import 'package:timeago/timeago.dart' as time_ago;

mixin TimeAgoMixin {
  DateTime get time;

  String get timeAgo {
    return time_ago.format(time.toLocal());
  }
}
