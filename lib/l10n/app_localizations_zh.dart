// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '我的学生证';

  @override
  String get tabCards => '学生证';

  @override
  String get tabSettings => '设置';

  @override
  String get myStudentCards => '我的学生证';

  @override
  String get noCards => '暂无学生证';

  @override
  String get noCardsHint => '前往设置页面添加';

  @override
  String get settings => '设置';

  @override
  String get cardManagement => '学生证管理';

  @override
  String get addCard => '添加学生证';

  @override
  String get addCardDesc => '录入新的学生证信息';

  @override
  String get general => '通用';

  @override
  String get language => '语言';

  @override
  String get languageDesc => '中文 / 日本語 / English';

  @override
  String get addStudentCard => '添加学生证';

  @override
  String get institution => '机构名称';

  @override
  String get institutionHint => '例：北京大学';

  @override
  String get principal => '校长';

  @override
  String get principalHint => '例：王五';

  @override
  String get startDate => '生效日期';

  @override
  String get endDate => '结束日期';

  @override
  String get selectDate => '选择日期';

  @override
  String get avatar => '头像';

  @override
  String get selectFromGallery => '从相册选择';

  @override
  String get save => '保存';

  @override
  String get valid => '有效';

  @override
  String get expired => '已过期';

  @override
  String get languageSelection => '语言';

  @override
  String get chinese => '中文';

  @override
  String get japanese => '日本語';

  @override
  String get english => 'English';

  @override
  String get studentName => '学生姓名';

  @override
  String get studentNameHint => '例：张三';

  @override
  String get cardDetail => '学生证详情';

  @override
  String get labelStudentName => '学生姓名';

  @override
  String get labelSchool => '学校';

  @override
  String get labelPrincipal => '校长';

  @override
  String get labelValidityPeriod => '有效期间';

  @override
  String get labelCardNumber => '证件编号';

  @override
  String get labelIssueDate => '发证日期';

  @override
  String get labelStatus => '证件状态';

  @override
  String get currentTime => '当前时间';

  @override
  String get antiForgeryNote => '实时验证中';

  @override
  String get digitalVerification => '数字防伪验证';

  @override
  String get cardAuthentic => '此证件为数字原件';

  @override
  String get cardExpiredWarning => '此证件已过期';

  @override
  String get tapToVerify => '动态防伪 · 无法截图伪造';

  @override
  String get certifiedBy => '签发人';

  @override
  String get validFrom => '自';

  @override
  String get validUntil => '至';

  @override
  String daysRemaining(int days) {
    return '剩余 $days 天';
  }

  @override
  String daysExpired(int days) {
    return '已过期 $days 天';
  }

  @override
  String get fieldRequired => '此项为必填';

  @override
  String get deleteCard => '删除';

  @override
  String get deleteConfirm => '确定要删除这张学生证吗？';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确定';
}
