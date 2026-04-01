import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student_card.dart';

class StorageService {
  static const _cardsKey = 'student_cards';
  static const _localeKey = 'app_locale';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  List<StudentCard> getCards() {
    final jsonStr = _prefs.getString(_cardsKey);
    if (jsonStr == null || jsonStr.isEmpty) return [];
    return StudentCard.listFromJson(jsonStr);
  }

  Future<void> saveCards(List<StudentCard> cards) async {
    await _prefs.setString(_cardsKey, StudentCard.listToJson(cards));
  }

  Future<void> addCard(StudentCard card) async {
    final cards = getCards();
    cards.add(card);
    await saveCards(cards);
  }

  Future<void> deleteCard(String id) async {
    final cards = getCards();
    cards.removeWhere((c) => c.id == id);
    await saveCards(cards);
  }

  String getLocale() {
    return _prefs.getString(_localeKey) ?? 'zh';
  }

  Future<void> setLocale(String locale) async {
    await _prefs.setString(_localeKey, locale);
  }

  static Future<String> saveAvatarImage(String sourcePath, String cardId) async {
    final dir = await getApplicationDocumentsDirectory();
    final avatarDir = Directory('${dir.path}/avatars');
    if (!await avatarDir.exists()) {
      await avatarDir.create(recursive: true);
    }
    final ext = sourcePath.split('.').last;
    final destPath = '${avatarDir.path}/$cardId.$ext';
    await File(sourcePath).copy(destPath);
    return destPath;
  }
}
