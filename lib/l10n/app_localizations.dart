import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get email;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get name;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get password;

  /// No description provided for @re_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get re_password;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgetPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @login_to_your_account.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get login_to_your_account;

  /// No description provided for @create_your_account.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get create_your_account;

  /// No description provided for @do_not_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account ?'**
  String get do_not_have_an_account;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_an_account;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_with_google;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get welcome_back;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @meetingM.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meetingM;

  /// No description provided for @book_club.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get book_club;

  /// No description provided for @exhibitionE.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get exhibitionE;

  /// No description provided for @search_event.
  ///
  /// In en, this message translates to:
  /// **'Search for event'**
  String get search_event;

  /// No description provided for @add_event.
  ///
  /// In en, this message translates to:
  /// **'Add event'**
  String get add_event;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @descriptionD.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionD;

  /// No description provided for @please_enter_title.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get please_enter_title;

  /// No description provided for @please_enter_description.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get please_enter_description;

  /// No description provided for @event_date.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get event_date;

  /// No description provided for @choose_date.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get choose_date;

  /// No description provided for @event_time.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get event_time;

  /// No description provided for @choose_time.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get choose_time;

  /// No description provided for @no_event_found.
  ///
  /// In en, this message translates to:
  /// **'No Event Found'**
  String get no_event_found;

  /// No description provided for @no_favorite_event_found.
  ///
  /// In en, this message translates to:
  /// **'No Favorite Event Found'**
  String get no_favorite_event_found;

  /// No description provided for @sign_up_with_google.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get sign_up_with_google;

  /// No description provided for @meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meeting;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @pass.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get pass;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmed;

  /// No description provided for @signGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signGoogle;

  /// No description provided for @birtheDay.
  ///
  /// In en, this message translates to:
  /// **'This is a Birthday Party'**
  String get birtheDay;

  /// No description provided for @eventTitle.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get eventTitle;

  /// No description provided for @eventDescription.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get eventDescription;

  /// No description provided for @forgetPass.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPass;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset;

  /// No description provided for @eventAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Event Added Successfully'**
  String get eventAddedSuccessfully;

  /// No description provided for @eventRemovedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Event Removed From Favorites'**
  String get eventRemovedFromFavorites;

  /// No description provided for @eventAddedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Event Added To Favorites'**
  String get eventAddedToFavorites;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @loginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get loginSuccessfully;

  /// No description provided for @registerSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Register Successfully'**
  String get registerSuccessfully;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get update;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Event details'**
  String get details;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Event deleted'**
  String get delete;

  /// No description provided for @noAction.
  ///
  /// In en, this message translates to:
  /// **'No action'**
  String get noAction;

  /// No description provided for @updateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Event Updated Successfully!'**
  String get updateSuccess;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @editEvent.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get editEvent;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibitions'**
  String get exhibition;

  /// No description provided for @onboardingHeadline.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get onboardingHeadline;

  /// No description provided for @onboardingText.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and \n language to get started with a \n comfortable, tailored experience that suits \n your style.'**
  String get onboardingText;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Let’s start'**
  String get onboardingStart;

  /// No description provided for @onboardingOneHead.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get onboardingOneHead;

  /// No description provided for @onboardingTwoHead.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get onboardingTwoHead;

  /// No description provided for @onboardingThreeHead.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get onboardingThreeHead;

  /// No description provided for @onboardingOneBody.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get onboardingOneBody;

  /// No description provided for @onboardingTwoBody.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get onboardingTwoBody;

  /// No description provided for @onboardingThreeBody.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get onboardingThreeBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
