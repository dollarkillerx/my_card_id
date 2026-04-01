// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '学生証';

  @override
  String get tabCards => '学生証';

  @override
  String get tabSettings => '設定';

  @override
  String get myStudentCards => '学生証一覧';

  @override
  String get noCards => '学生証がありません';

  @override
  String get noCardsHint => '設定ページから追加してください';

  @override
  String get settings => '設定';

  @override
  String get cardManagement => '学生証管理';

  @override
  String get addCard => '学生証を追加';

  @override
  String get addCardDesc => '新しい学生証情報を入力';

  @override
  String get general => '一般';

  @override
  String get language => '言語';

  @override
  String get languageDesc => '中文 / 日本語 / English';

  @override
  String get addStudentCard => '学生証を追加';

  @override
  String get institution => '機関名';

  @override
  String get institutionHint => '例：東京大学';

  @override
  String get principal => '学長';

  @override
  String get principalHint => '例：山田太郎';

  @override
  String get startDate => '開始日';

  @override
  String get endDate => '終了日';

  @override
  String get selectDate => '日付を選択';

  @override
  String get avatar => '写真';

  @override
  String get selectFromGallery => 'アルバムから選択';

  @override
  String get save => '保存';

  @override
  String get valid => '有効';

  @override
  String get expired => '期限切れ';

  @override
  String get languageSelection => '言語';

  @override
  String get chinese => '中文';

  @override
  String get japanese => '日本語';

  @override
  String get english => 'English';

  @override
  String get studentName => '学生氏名';

  @override
  String get studentNameHint => '例：田中太郎';

  @override
  String get cardDetail => '学生証詳細';

  @override
  String get labelStudentName => '学生氏名';

  @override
  String get labelSchool => '学校';

  @override
  String get labelPrincipal => '学長';

  @override
  String get labelValidityPeriod => '有効期間';

  @override
  String get labelCardNumber => '証明書番号';

  @override
  String get labelIssueDate => '発行日';

  @override
  String get labelStatus => '証明書状態';

  @override
  String get currentTime => '現在時刻';

  @override
  String get antiForgeryNote => 'リアルタイム認証中';

  @override
  String get digitalVerification => 'デジタル偽造防止認証';

  @override
  String get cardAuthentic => 'この証明書はデジタル原本です';

  @override
  String get cardExpiredWarning => 'この証明書は期限切れです';

  @override
  String get tapToVerify => '動的偽造防止 · スクリーンショット偽造不可';

  @override
  String get certifiedBy => '署名者';

  @override
  String get validFrom => '開始';

  @override
  String get validUntil => '終了';

  @override
  String daysRemaining(int days) {
    return '残り $days 日';
  }

  @override
  String daysExpired(int days) {
    return '期限切れ $days 日';
  }

  @override
  String get fieldRequired => '必須項目です';

  @override
  String get deleteCard => '削除';

  @override
  String get deleteConfirm => 'この学生証を削除しますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';
}
