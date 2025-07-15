import 'package:intl/intl.dart';

String getFormattedDate([DateTime? date]) {
  final now = date ?? DateTime.now();
  return DateFormat('EEEE d MMMM').format(now);
}

String timeAgo(DateTime date) {
  final duration = DateTime.now().difference(date);
  String timeAgo;

  if (duration.inDays > 0) {
    timeAgo = '${duration.inDays}d';
  } else if (duration.inHours > 0) {
    timeAgo = '${duration.inHours}h';
  } else if (duration.inMinutes > 0) {
    timeAgo = '${duration.inMinutes}m';
  } else {
    timeAgo = 'just now';
  }

  return timeAgo;
}

String formatDateToMonthDay(String dateStr) {
  final date = DateTime.parse(dateStr);
  return DateFormat('MMMM dd').format(date); // Kết quả: July 08
}
