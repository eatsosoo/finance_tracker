// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String home_title(Object name) {
    return 'Welcome $name';
  }

  @override
  String get auth_login => 'Login';

  @override
  String get auth_signup => 'Sign Up';

  @override
  String get auth_signinn => 'Sign In';

  @override
  String get auth_register => 'Register';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_username => 'Username';

  @override
  String get auth_tel => 'Tel';

  @override
  String get auth_login_subtitle => 'Please Sign In to continue';

  @override
  String get auth_register_subtitle => 'Please Sign Up to continue';

  @override
  String get auth_reminder_text => 'Reminder me next time';

  @override
  String get common_save => 'Save';

  @override
  String get common_edit => 'Edit';

  @override
  String get common_delete => 'Delete';

  @override
  String get budget_title => 'Budgets';

  @override
  String get budget_new => 'New budgets';

  @override
  String get budget_total_amount => 'Total amount';

  @override
  String get budget_total_allocated => 'Total allocated';

  @override
  String get budget_remain => 'Remain';

  @override
  String get budget_spent => 'Spent';

  @override
  String budget_warning_text(Object times) {
    return 'You have overspent $times times';
  }

  @override
  String get budget_legend_1 => 'Amount assigned';

  @override
  String get budget_legend_2 => 'Amout spent';

  @override
  String get budget_legend_3 => 'Overspent';
}
