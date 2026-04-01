import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

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
    Locale('en'),
    Locale('ja'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'我的学生证'**
  String get appTitle;

  /// No description provided for @tabCards.
  ///
  /// In zh, this message translates to:
  /// **'学生证'**
  String get tabCards;

  /// No description provided for @tabSettings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get tabSettings;

  /// No description provided for @myStudentCards.
  ///
  /// In zh, this message translates to:
  /// **'我的学生证'**
  String get myStudentCards;

  /// No description provided for @noCards.
  ///
  /// In zh, this message translates to:
  /// **'暂无学生证'**
  String get noCards;

  /// No description provided for @noCardsHint.
  ///
  /// In zh, this message translates to:
  /// **'前往设置页面添加'**
  String get noCardsHint;

  /// No description provided for @settings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settings;

  /// No description provided for @cardManagement.
  ///
  /// In zh, this message translates to:
  /// **'学生证管理'**
  String get cardManagement;

  /// No description provided for @addCard.
  ///
  /// In zh, this message translates to:
  /// **'添加学生证'**
  String get addCard;

  /// No description provided for @addCardDesc.
  ///
  /// In zh, this message translates to:
  /// **'录入新的学生证信息'**
  String get addCardDesc;

  /// No description provided for @general.
  ///
  /// In zh, this message translates to:
  /// **'通用'**
  String get general;

  /// No description provided for @language.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get language;

  /// No description provided for @languageDesc.
  ///
  /// In zh, this message translates to:
  /// **'中文 / 日本語 / English'**
  String get languageDesc;

  /// No description provided for @addStudentCard.
  ///
  /// In zh, this message translates to:
  /// **'添加学生证'**
  String get addStudentCard;

  /// No description provided for @institution.
  ///
  /// In zh, this message translates to:
  /// **'机构名称'**
  String get institution;

  /// No description provided for @institutionHint.
  ///
  /// In zh, this message translates to:
  /// **'例：北京大学'**
  String get institutionHint;

  /// No description provided for @principal.
  ///
  /// In zh, this message translates to:
  /// **'校长'**
  String get principal;

  /// No description provided for @principalHint.
  ///
  /// In zh, this message translates to:
  /// **'例：王五'**
  String get principalHint;

  /// No description provided for @startDate.
  ///
  /// In zh, this message translates to:
  /// **'生效日期'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In zh, this message translates to:
  /// **'结束日期'**
  String get endDate;

  /// No description provided for @selectDate.
  ///
  /// In zh, this message translates to:
  /// **'选择日期'**
  String get selectDate;

  /// No description provided for @avatar.
  ///
  /// In zh, this message translates to:
  /// **'头像'**
  String get avatar;

  /// No description provided for @selectFromGallery.
  ///
  /// In zh, this message translates to:
  /// **'从相册选择'**
  String get selectFromGallery;

  /// No description provided for @save.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get save;

  /// No description provided for @valid.
  ///
  /// In zh, this message translates to:
  /// **'有效'**
  String get valid;

  /// No description provided for @expired.
  ///
  /// In zh, this message translates to:
  /// **'已过期'**
  String get expired;

  /// No description provided for @languageSelection.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get languageSelection;

  /// No description provided for @chinese.
  ///
  /// In zh, this message translates to:
  /// **'中文'**
  String get chinese;

  /// No description provided for @japanese.
  ///
  /// In zh, this message translates to:
  /// **'日本語'**
  String get japanese;

  /// No description provided for @english.
  ///
  /// In zh, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @studentName.
  ///
  /// In zh, this message translates to:
  /// **'学生姓名'**
  String get studentName;

  /// No description provided for @studentNameHint.
  ///
  /// In zh, this message translates to:
  /// **'例：张三'**
  String get studentNameHint;

  /// No description provided for @cardDetail.
  ///
  /// In zh, this message translates to:
  /// **'学生证详情'**
  String get cardDetail;

  /// No description provided for @labelStudentName.
  ///
  /// In zh, this message translates to:
  /// **'学生姓名'**
  String get labelStudentName;

  /// No description provided for @labelSchool.
  ///
  /// In zh, this message translates to:
  /// **'学校'**
  String get labelSchool;

  /// No description provided for @labelPrincipal.
  ///
  /// In zh, this message translates to:
  /// **'校长'**
  String get labelPrincipal;

  /// No description provided for @labelValidityPeriod.
  ///
  /// In zh, this message translates to:
  /// **'有效期间'**
  String get labelValidityPeriod;

  /// No description provided for @labelCardNumber.
  ///
  /// In zh, this message translates to:
  /// **'证件编号'**
  String get labelCardNumber;

  /// No description provided for @labelIssueDate.
  ///
  /// In zh, this message translates to:
  /// **'发证日期'**
  String get labelIssueDate;

  /// No description provided for @labelStatus.
  ///
  /// In zh, this message translates to:
  /// **'证件状态'**
  String get labelStatus;

  /// No description provided for @currentTime.
  ///
  /// In zh, this message translates to:
  /// **'当前时间'**
  String get currentTime;

  /// No description provided for @antiForgeryNote.
  ///
  /// In zh, this message translates to:
  /// **'实时验证中'**
  String get antiForgeryNote;

  /// No description provided for @digitalVerification.
  ///
  /// In zh, this message translates to:
  /// **'数字防伪验证'**
  String get digitalVerification;

  /// No description provided for @cardAuthentic.
  ///
  /// In zh, this message translates to:
  /// **'此证件为数字原件'**
  String get cardAuthentic;

  /// No description provided for @cardExpiredWarning.
  ///
  /// In zh, this message translates to:
  /// **'此证件已过期'**
  String get cardExpiredWarning;

  /// No description provided for @tapToVerify.
  ///
  /// In zh, this message translates to:
  /// **'动态防伪 · 无法截图伪造'**
  String get tapToVerify;

  /// No description provided for @certifiedBy.
  ///
  /// In zh, this message translates to:
  /// **'签发人'**
  String get certifiedBy;

  /// No description provided for @validFrom.
  ///
  /// In zh, this message translates to:
  /// **'自'**
  String get validFrom;

  /// No description provided for @validUntil.
  ///
  /// In zh, this message translates to:
  /// **'至'**
  String get validUntil;

  /// No description provided for @daysRemaining.
  ///
  /// In zh, this message translates to:
  /// **'剩余 {days} 天'**
  String daysRemaining(int days);

  /// No description provided for @daysExpired.
  ///
  /// In zh, this message translates to:
  /// **'已过期 {days} 天'**
  String daysExpired(int days);

  /// No description provided for @fieldRequired.
  ///
  /// In zh, this message translates to:
  /// **'此项为必填'**
  String get fieldRequired;

  /// No description provided for @deleteCard.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get deleteCard;

  /// No description provided for @deleteConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这张学生证吗？'**
  String get deleteConfirm;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get confirm;
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
      <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
