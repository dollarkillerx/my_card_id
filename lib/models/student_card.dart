import 'dart:convert';

class StudentCard {
  final String id;
  final String studentName;
  final String institution;
  final String principal;
  final DateTime startDate;
  final DateTime endDate;
  final String? avatarPath;

  StudentCard({
    required this.id,
    required this.studentName,
    required this.institution,
    required this.principal,
    required this.startDate,
    required this.endDate,
    this.avatarPath,
  });

  bool get isValid => DateTime.now().isBefore(endDate);

  Map<String, dynamic> toJson() => {
        'id': id,
        'studentName': studentName,
        'institution': institution,
        'principal': principal,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'avatarPath': avatarPath,
      };

  factory StudentCard.fromJson(Map<String, dynamic> json) => StudentCard(
        id: json['id'] as String,
        studentName: json['studentName'] as String? ?? '',
        institution: json['institution'] as String,
        principal: json['principal'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: DateTime.parse(json['endDate'] as String),
        avatarPath: json['avatarPath'] as String?,
      );

  static List<StudentCard> listFromJson(String jsonStr) {
    final List<dynamic> list = json.decode(jsonStr) as List<dynamic>;
    return list
        .map((e) => StudentCard.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listToJson(List<StudentCard> cards) {
    return json.encode(cards.map((c) => c.toJson()).toList());
  }
}
