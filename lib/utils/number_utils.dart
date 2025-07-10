import 'package:intl/intl.dart';

String formatCurrency(num amount, {String suffix = 'đ'}) {
  final formatter = NumberFormat('#,###', 'vi_VN');
  return '${formatter.format(amount)}$suffix';
}
