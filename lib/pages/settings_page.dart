import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import 'add_card_page.dart';
import 'language_page.dart';

class SettingsPage extends StatelessWidget {
  final StorageService storage;
  final VoidCallback onCardAdded;

  const SettingsPage({
    super.key,
    required this.storage,
    required this.onCardAdded,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              l10n.settings,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A1A),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 28),

            // Card Management Section
            _SectionHeader(title: l10n.cardManagement),
            const SizedBox(height: 10),
            _SettingsGroup(
              children: [
                _SettingsTile(
                  icon: Icons.add_card_rounded,
                  iconGradient: const [Color(0xFF6366F1), Color(0xFF818CF8)],
                  title: l10n.addCard,
                  subtitle: l10n.addCardDesc,
                  onTap: () async {
                    final result = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddCardPage(storage: storage),
                      ),
                    );
                    if (result == true) {
                      onCardAdded();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 28),

            // General Section
            _SectionHeader(title: l10n.general),
            const SizedBox(height: 10),
            _SettingsGroup(
              children: [
                _SettingsTile(
                  icon: Icons.translate_rounded,
                  iconGradient: const [Color(0xFF0284C7), Color(0xFF38BDF8)],
                  title: l10n.language,
                  subtitle: l10n.languageDesc,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LanguagePage(storage: storage),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // App version footer
            Center(
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.badge_rounded,
                      size: 20,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'My Card ID',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFBBBBBB),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'v1.0.0',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFD1D5DB),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFFAAAAAA),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;

  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final List<Color> iconGradient;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconGradient,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: iconGradient,
                  ),
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                      color: iconGradient.first.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, size: 20, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: Color(0xFFBBBBBB),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
