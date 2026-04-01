// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Student ID';

  @override
  String get tabCards => 'Cards';

  @override
  String get tabSettings => 'Settings';

  @override
  String get myStudentCards => 'My Student Cards';

  @override
  String get noCards => 'No Student Cards';

  @override
  String get noCardsHint => 'Go to Settings to add one';

  @override
  String get settings => 'Settings';

  @override
  String get cardManagement => 'Card Management';

  @override
  String get addCard => 'Add Student Card';

  @override
  String get addCardDesc => 'Enter new student card info';

  @override
  String get general => 'General';

  @override
  String get language => 'Language';

  @override
  String get languageDesc => '中文 / 日本語 / English';

  @override
  String get addStudentCard => 'Add Student Card';

  @override
  String get institution => 'Institution';

  @override
  String get institutionHint => 'e.g. Peking University';

  @override
  String get principal => 'Principal';

  @override
  String get principalHint => 'e.g. John Smith';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get selectDate => 'Select date';

  @override
  String get avatar => 'Avatar';

  @override
  String get selectFromGallery => 'Select from gallery';

  @override
  String get save => 'Save';

  @override
  String get valid => 'Valid';

  @override
  String get expired => 'Expired';

  @override
  String get languageSelection => 'Language';

  @override
  String get chinese => '中文';

  @override
  String get japanese => '日本語';

  @override
  String get english => 'English';

  @override
  String get studentName => 'Student Name';

  @override
  String get studentNameHint => 'e.g. John Doe';

  @override
  String get cardDetail => 'Card Detail';

  @override
  String get labelStudentName => 'Student Name';

  @override
  String get labelSchool => 'School';

  @override
  String get labelPrincipal => 'Principal';

  @override
  String get labelValidityPeriod => 'Validity Period';

  @override
  String get labelCardNumber => 'Card Number';

  @override
  String get labelIssueDate => 'Issue Date';

  @override
  String get labelStatus => 'Status';

  @override
  String get currentTime => 'Current Time';

  @override
  String get antiForgeryNote => 'Real-time verification';

  @override
  String get digitalVerification => 'Digital Anti-Forgery Verification';

  @override
  String get cardAuthentic => 'This is an authentic digital certificate';

  @override
  String get cardExpiredWarning => 'This certificate has expired';

  @override
  String get tapToVerify =>
      'Dynamic anti-forgery · Cannot be forged via screenshot';

  @override
  String get certifiedBy => 'Certified by';

  @override
  String get validFrom => 'From';

  @override
  String get validUntil => 'To';

  @override
  String daysRemaining(int days) {
    return '$days days remaining';
  }

  @override
  String daysExpired(int days) {
    return 'Expired $days days ago';
  }

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get deleteCard => 'Delete';

  @override
  String get deleteConfirm => 'Are you sure you want to delete this card?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';
}
