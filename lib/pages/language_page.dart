import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../services/storage_service.dart';

class LanguagePage extends StatefulWidget {
  final StorageService storage;

  const LanguagePage({super.key, required this.storage});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late String _selectedLocale;

  static const _languages = [
    {'code': 'zh', 'label': '中文', 'sub': 'Chinese', 'flag': '🇨🇳'},
    {'code': 'ja', 'label': '日本語', 'sub': 'Japanese', 'flag': '🇯🇵'},
    {'code': 'en', 'label': 'English', 'sub': 'English', 'flag': '🇺🇸'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedLocale = widget.storage.getLocale();
  }

  Future<void> _selectLanguage(String code) async {
    setState(() {
      _selectedLocale = code;
    });
    await widget.storage.setLocale(code);
    if (mounted) {
      MyApp.of(context).setLocale(Locale(code));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.languageSelection)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _languages.asMap().entries.map((entry) {
                final index = entry.key;
                final lang = entry.value;
                final isSelected = _selectedLocale == lang['code'];
                final isLast = index == _languages.length - 1;

                return Column(
                  children: [
                    Material(
                      color: isSelected
                          ? const Color(0xFF6366F1).withValues(alpha: 0.04)
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () => _selectLanguage(lang['code']!),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          child: Row(
                            children: [
                              // Flag
                              Text(
                                lang['flag']!,
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 16),
                              // Labels
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang['label']!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? const Color(0xFF1A1A1A)
                                            : const Color(0xFF666666),
                                      ),
                                    ),
                                    if (!isSelected)
                                      Text(
                                        lang['sub']!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFBBBBBB),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              // Check indicator
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOutCubic,
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF6366F1)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF6366F1)
                                        : const Color(0xFFD1D5DB),
                                    width: 2,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xFF6366F1)
                                                .withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check_rounded,
                                        size: 14, color: Colors.white)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      const Divider(
                          height: 0,
                          indent: 62,
                          endIndent: 20,
                          color: Color(0xFFF3F4F6)),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
