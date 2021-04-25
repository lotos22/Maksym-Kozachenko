import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'something_went_wrong': 'Something went wrong',
      
      'login_email': 'Email',
      'login_password': 'Password',
      'login_sign_in': 'SIGN IN',
      'login_sign_up': 'SIGN UP',
      'login_invalid_email': 'Invalid email',
      'login_user_error': 'No user found for that email.',
      'login_wrong_password': 'Wrong password',
      'sign_up_passwords_dont_match': 'Passwords don\'t match',
      'sign_up_account_created': 'Account successfully created',
      'sign_up_email_incorrect': 'Email is incorrect',
      'sign_up_email_in_use': 'Mail is already in use',
      'sign_up_week_password': 'Week password',
      'home_root_retry': 'Retry',
      'restaurant_details_best_review': 'Best rating',
      'restaurant_details_worst_review': 'Worst rating',
      'restaurant_details_comment': 'Comment:',
      'restaurant_details_reply': 'Reply:',
      'restaurant_details_comments': 'Comments',
      'dialog_review_comment': 'Comment',
      'dialog_review_publish': 'Publish',
      'dialog_review_request_error':
          'Something went wrong, your review will be added later',
      'dialog_add_restaurant_name': 'Name',
      'dialog_add_restaurant_ok': 'Ok',

      'item_not_found':'Item not found',
    }
  };
  
  String get item_not_found {
    return _localizedValues[locale.languageCode]!['item_not_found']!;
  }


  String get something_went_wrong {
    return _localizedValues[locale.languageCode]!['something_went_wrong']!;
  }

  String get login_email {
    return _localizedValues[locale.languageCode]!['login_email']!;
  }

  String get login_password {
    return _localizedValues[locale.languageCode]!['login_password']!;
  }

  String get login_sign_in {
    return _localizedValues[locale.languageCode]!['login_sign_in']!;
  }

  String get login_sign_up {
    return _localizedValues[locale.languageCode]!['login_sign_up']!;
  }

  String get login_invalid_email {
    return _localizedValues[locale.languageCode]!['login_invalid_email']!;
  }

  String get login_user_error {
    return _localizedValues[locale.languageCode]!['login_user_error']!;
  }

  String get login_wrong_password {
    return _localizedValues[locale.languageCode]!['login_wrong_password']!;
  }

  String get sign_up_passwords_dont_match {
    return _localizedValues[locale.languageCode]![
        'sign_up_passwords_dont_match']!;
  }

  String get sign_up_account_created {
    return _localizedValues[locale.languageCode]!['sign_up_account_created']!;
  }

  String get sign_up_email_incorrect {
    return _localizedValues[locale.languageCode]!['sign_up_email_incorrect']!;
  }

  String get sign_up_email_in_use {
    return _localizedValues[locale.languageCode]!['sign_up_email_in_use']!;
  }

  String get sign_up_week_password {
    return _localizedValues[locale.languageCode]!['sign_up_week_password']!;
  }

  String get home_root_retry {
    return _localizedValues[locale.languageCode]!['home_root_retry']!;
  }

  String get restaurant_details_best_review {
    return _localizedValues[locale.languageCode]![
        'restaurant_details_best_review']!;
  }

  String get restaurant_details_worst_review {
    return _localizedValues[locale.languageCode]![
        'restaurant_details_worst_review']!;
  }

  String get restaurant_details_comment {
    return _localizedValues[locale.languageCode]![
        'restaurant_details_comment']!;
  }

  String get restaurant_details_reply {
    return _localizedValues[locale.languageCode]!['restaurant_details_reply']!;
  }

  String get restaurant_details_comments {
    return _localizedValues[locale.languageCode]![
        'restaurant_details_comments']!;
  }

  String get dialog_review_comment {
    return _localizedValues[locale.languageCode]!['dialog_review_comment']!;
  }

  String get dialog_review_publish {
    return _localizedValues[locale.languageCode]!['dialog_review_publish']!;
  }

  String get dialog_review_request_error {
    return _localizedValues[locale.languageCode]![
        'dialog_review_request_error']!;
  }

  String get dialog_add_restaurant_name {
    return _localizedValues[locale.languageCode]![
        'dialog_add_restaurant_name']!;
  }

  String get dialog_add_restaurant_ok {
    return _localizedValues[locale.languageCode]!['dialog_add_restaurant_ok']!;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
