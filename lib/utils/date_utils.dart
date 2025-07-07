import 'package:intl/intl.dart';

String getFormattedDate([DateTime? date]) {
  final now = date ?? DateTime.now();
  return DateFormat('EEEE d MMMM').format(now);
}
