import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}'**
  String home_title(Object name);

  /// No description provided for @home_event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get home_event;

  /// No description provided for @home_no_events.
  ///
  /// In en, this message translates to:
  /// **'No events'**
  String get home_no_events;

  /// No description provided for @home_new_event.
  ///
  /// In en, this message translates to:
  /// **'New event'**
  String get home_new_event;

  /// No description provided for @home_event_form_title.
  ///
  /// In en, this message translates to:
  /// **'Event name'**
  String get home_event_form_title;

  /// No description provided for @home_event_form_location.
  ///
  /// In en, this message translates to:
  /// **'Location or URL'**
  String get home_event_form_location;

  /// No description provided for @home_event_form_all_day_event.
  ///
  /// In en, this message translates to:
  /// **'All day event'**
  String get home_event_form_all_day_event;

  /// No description provided for @home_event_form_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get home_event_form_start;

  /// No description provided for @home_event_form_end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get home_event_form_end;

  /// No description provided for @home_event_form_repetitive.
  ///
  /// In en, this message translates to:
  /// **'Repetitive event'**
  String get home_event_form_repetitive;

  /// No description provided for @home_event_form_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get home_event_form_tags;

  /// No description provided for @home_event_form_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get home_event_form_notes;

  /// No description provided for @auth_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get auth_login;

  /// No description provided for @auth_signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get auth_signup;

  /// No description provided for @auth_signin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get auth_signin;

  /// No description provided for @auth_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get auth_register;

  /// No description provided for @auth_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_password;

  /// No description provided for @auth_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get auth_username;

  /// No description provided for @auth_tel.
  ///
  /// In en, this message translates to:
  /// **'Tel'**
  String get auth_tel;

  /// No description provided for @auth_mail.
  ///
  /// In en, this message translates to:
  /// **'Mail'**
  String get auth_mail;

  /// No description provided for @auth_login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Sign In to continue'**
  String get auth_login_subtitle;

  /// No description provided for @auth_register_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Sign Up to continue'**
  String get auth_register_subtitle;

  /// No description provided for @auth_remenber_next_time_text.
  ///
  /// In en, this message translates to:
  /// **'Remenber me next time'**
  String get auth_remenber_next_time_text;

  /// No description provided for @auth_not_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get auth_not_have_account;

  /// No description provided for @auth_already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have account'**
  String get auth_already_have_account;

  /// No description provided for @auth_login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed!'**
  String get auth_login_failed;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get common_edit;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @common_week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get common_week;

  /// No description provided for @common_month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get common_month;

  /// No description provided for @common_year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get common_year;

  /// No description provided for @budget_title.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get budget_title;

  /// No description provided for @budget_new.
  ///
  /// In en, this message translates to:
  /// **'New budgets'**
  String get budget_new;

  /// No description provided for @budget_total_amount.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get budget_total_amount;

  /// No description provided for @budget_total_allocated.
  ///
  /// In en, this message translates to:
  /// **'Total allocated'**
  String get budget_total_allocated;

  /// No description provided for @budget_remain.
  ///
  /// In en, this message translates to:
  /// **'Remain'**
  String get budget_remain;

  /// No description provided for @budget_spent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get budget_spent;

  /// No description provided for @budget_warning_text.
  ///
  /// In en, this message translates to:
  /// **'You have overspent {times} times'**
  String budget_warning_text(Object times);

  /// No description provided for @budget_warning_text_2.
  ///
  /// In en, this message translates to:
  /// **'You have one overspent'**
  String get budget_warning_text_2;

  /// No description provided for @budget_legend_1.
  ///
  /// In en, this message translates to:
  /// **'Amount assigned'**
  String get budget_legend_1;

  /// No description provided for @budget_legend_2.
  ///
  /// In en, this message translates to:
  /// **'Amout spent'**
  String get budget_legend_2;

  /// No description provided for @budget_legend_3.
  ///
  /// In en, this message translates to:
  /// **'Overspent'**
  String get budget_legend_3;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'vi':
      return SVi();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
