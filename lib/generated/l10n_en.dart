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
  String get home_event => 'Event';

  @override
  String get home_no_events => 'No events';

  @override
  String get home_new_event => 'New event';

  @override
  String get home_event_form_title => 'Event name';

  @override
  String get home_event_form_location => 'Location or URL';

  @override
  String get home_event_form_all_day_event => 'All day event';

  @override
  String get home_event_form_start => 'Start';

  @override
  String get home_event_form_end => 'End';

  @override
  String get home_event_form_repetitive => 'Repetitive event';

  @override
  String get home_event_form_tags => 'Tags';

  @override
  String get home_event_form_notes => 'Notes';

  @override
  String get auth_login => 'Login';

  @override
  String get auth_signup => 'Sign Up';

  @override
  String get auth_signin => 'Sign In';

  @override
  String get auth_register => 'Register';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_username => 'Username';

  @override
  String get auth_tel => 'Tel';

  @override
  String get auth_mail => 'Mail';

  @override
  String get auth_login_subtitle => 'Please Sign In to continue';

  @override
  String get auth_register_subtitle => 'Please Sign Up to continue';

  @override
  String get auth_remenber_next_time_text => 'Remenber me next time';

  @override
  String get auth_not_have_account => 'Don\'t have an account?';

  @override
  String get auth_already_have_account => 'Already have account';

  @override
  String get auth_login_failed => 'Login failed!';

  @override
  String get common_save => 'Save';

  @override
  String get common_edit => 'Edit';

  @override
  String get common_delete => 'Delete';

  @override
  String get common_add => 'Add';

  @override
  String get common_income => 'Income';

  @override
  String get common_expense => 'Expense';

  @override
  String get common_date => 'Date';

  @override
  String get common_week => 'Week';

  @override
  String get common_month => 'Month';

  @override
  String get common_year => 'Year';

  @override
  String get common_account => 'Account';

  @override
  String get common_category => 'Category';

  @override
  String get common_note => 'Note';

  @override
  String get common_active => 'Active';

  @override
  String get common_inactive => 'Inactive';

  @override
  String get common_filters => 'Filters';

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
  String get budget_warning_text_2 => 'You have one overspent';

  @override
  String get budget_legend_1 => 'Amount assigned';

  @override
  String get budget_legend_2 => 'Amout spent';

  @override
  String get budget_legend_3 => 'Overspent';

  @override
  String get report_title => 'Report';

  @override
  String get report_history => 'History';

  @override
  String get account_title => 'Account';

  @override
  String get account_average_income => 'Average Income';

  @override
  String get account_average_expense => 'Average Expense';

  @override
  String get account_your_saving => 'Your saving';

  @override
  String get account_chart_title => 'Data Metrics';

  @override
  String get account_chart_subtitle => 'Income-Expense Insight Analyzer';

  @override
  String get setting_title => 'Setting';

  @override
  String get setting_language => 'Language';

  @override
  String get setting_privacy => 'Privacy';

  @override
  String get setting_light_mode => 'Light mode';

  @override
  String get setting_dark_mode => 'Dark mode';

  @override
  String get setting_system_mode => 'System mode';

  @override
  String get setting_theme => 'Theme';

  @override
  String get setting_profile => 'Profile';

  @override
  String get notify_title => 'Inbox';

  @override
  String get notify_unread => 'Unread';

  @override
  String get notify_read => 'Read';

  @override
  String get notify_all => 'All';
}
