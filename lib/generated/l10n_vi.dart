// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class SVi extends S {
  SVi([String locale = 'vi']) : super(locale);

  @override
  String home_title(Object name) {
    return 'Chào mừng $name';
  }

  @override
  String get auth_login => 'Đăng nhập';

  @override
  String get auth_signup => 'Đăng ký';

  @override
  String get auth_signinn => 'Đăng nhập';

  @override
  String get auth_register => 'Tạo tài khoản';

  @override
  String get auth_password => 'Mật khẩu';

  @override
  String get auth_username => 'Tên đăng nhập';

  @override
  String get auth_tel => 'Số điện thoại';

  @override
  String get auth_login_subtitle => 'Vui lòng đăng nhập để tiếp tục';

  @override
  String get auth_register_subtitle => 'Vui lòng đăng ký để tiếp tục';

  @override
  String get auth_reminder_text => 'Nhắc tôi lần sau';

  @override
  String get common_save => 'Lưu';

  @override
  String get common_edit => 'Chỉnh sửa';

  @override
  String get common_delete => 'Xóa';

  @override
  String get budget_title => 'Ngân sách';

  @override
  String get budget_new => 'Ngân sách mới';

  @override
  String get budget_total_amount => 'Tổng số tiền';

  @override
  String get budget_total_allocated => 'Tổng đã phân bổ';

  @override
  String get budget_remain => 'Còn lại';

  @override
  String get budget_spent => 'Đã chi';

  @override
  String budget_warning_text(Object times) {
    return 'Bạn đã chi quá mức $times lần';
  }

  @override
  String get budget_legend_1 => 'Số tiền đã phân bổ';

  @override
  String get budget_legend_2 => 'Số tiền đã chi';

  @override
  String get budget_legend_3 => 'Chi quá mức';
}
