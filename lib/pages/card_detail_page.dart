import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/student_card.dart';

class CardDetailPage extends StatefulWidget {
  final StudentCard card;

  const CardDetailPage({super.key, required this.card});

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage>
    with TickerProviderStateMixin {
  late Timer _clockTimer;
  late DateTime _currentTime;
  late AnimationController _shimmerController;
  late AnimationController _glowController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();

    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _shimmerController.dispose();
    _glowController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  String _cardNumber() {
    final hash = widget.card.id.hashCode.abs().toString().padLeft(12, '0');
    return 'STU-${hash.substring(0, 4)}-${hash.substring(4, 8)}-${hash.substring(8, 12)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final card = widget.card;
    final isValid = card.isValid;
    final now = DateTime.now();
    final daysDiff = isValid
        ? card.endDate.difference(now).inDays
        : now.difference(card.endDate).inDays;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F5),
      appBar: AppBar(
        title: Text(l10n.cardDetail),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        scrolledUnderElevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // === MAIN CARD with anti-forgery effects ===
            _buildMainCard(card, isValid, l10n),

            const SizedBox(height: 20),

            // === DETAIL INFO SECTION ===
            _buildDetailSection(card, isValid, daysDiff, l10n),

            const SizedBox(height: 20),

            // === ANTI-FORGERY VERIFICATION SECTION ===
            _buildVerificationSection(l10n),

            const SizedBox(height: 20),

            // === BARCODE SECTION ===
            _buildBarcodeSection(l10n),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ─── Main Card ───────────────────────────────────────────────
  Widget _buildMainCard(StudentCard card, bool isValid, AppLocalizations l10n) {
    return AnimatedBuilder(
      animation: Listenable.merge([_shimmerController, _glowController]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF6366F1).withValues(
                  alpha: 0.12 + 0.12 * _glowController.value,
                ),
                blurRadius: 24 + 16 * _glowController.value,
                spreadRadius: 2 * _glowController.value,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Background pattern
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: CustomPaint(
                    painter: _WatermarkPainter(
                      text: card.institution,
                      opacity: 0.03,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                      child: Column(
                        children: [
                          // Top bar: institution label + status
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6366F1)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'STUDENT ID CARD',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF6366F1),
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // Live indicator dot
                              AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, _) {
                                  return Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isValid
                                          ? Color(0xFF16A34A).withValues(
                                              alpha: 0.5 +
                                                  0.5 * _pulseController.value)
                                          : Color(0xFFDC2626).withValues(
                                              alpha: 0.5 +
                                                  0.5 * _pulseController.value),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (isValid
                                                  ? const Color(0xFF16A34A)
                                                  : const Color(0xFFDC2626))
                                              .withValues(
                                                  alpha: 0.3 *
                                                      _pulseController.value),
                                          blurRadius:
                                              6 * _pulseController.value,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isValid
                                      ? const Color(0xFFDCFCE7)
                                      : const Color(0xFFFEF2F2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  isValid ? l10n.valid : l10n.expired,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: isValid
                                        ? const Color(0xFF16A34A)
                                        : const Color(0xFFDC2626),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Avatar + Info row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Avatar with border
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFF6366F1)
                                        .withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Container(
                                  width: 80,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F4F6),
                                    borderRadius: BorderRadius.circular(10),
                                    image: card.avatarPath != null
                                        ? DecorationImage(
                                            image: FileImage(
                                                File(card.avatarPath!)),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: card.avatarPath == null
                                      ? const Icon(Icons.person,
                                          size: 40, color: Color(0xFFBBBBBB))
                                      : null,
                                ),
                              ),

                              const SizedBox(width: 18),

                              // Info column
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      card.studentName,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1A1A1A),
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(Icons.school_outlined,
                                            size: 14,
                                            color: const Color(0xFF999999)),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            card.institution,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.person_outline,
                                            size: 14,
                                            color: const Color(0xFF999999)),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${l10n.certifiedBy}: ${card.principal}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF999999),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Card number
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3F4F6),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        _cardNumber(),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF999999),
                                          letterSpacing: 1,
                                          fontFeatures: [
                                            FontFeature.tabularFigures()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Validity period bar
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFFE5E7EB)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    _buildDateBlock(
                                        l10n.validFrom, card.startDate),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Column(
                                          children: [
                                            Icon(Icons.arrow_forward,
                                                size: 16,
                                                color:
                                                    const Color(0xFFD1D5DB)),
                                            const SizedBox(height: 2),
                                            // Progress bar
                                            _buildValidityProgress(card),
                                          ],
                                        ),
                                      ),
                                    ),
                                    _buildDateBlock(
                                        l10n.validUntil, card.endDate),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Holographic shimmer overlay
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _HolographicPainter(
                        progress: _shimmerController.value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateBlock(String label, DateTime date) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF999999),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _formatDate(date),
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.w700,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }

  Widget _buildValidityProgress(StudentCard card) {
    final totalDays = card.endDate.difference(card.startDate).inDays;
    final elapsed = DateTime.now().difference(card.startDate).inDays;
    final progress = totalDays > 0 ? (elapsed / totalDays).clamp(0.0, 1.0) : 1.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 4,
        backgroundColor: const Color(0xFFE5E7EB),
        valueColor: AlwaysStoppedAnimation<Color>(
          card.isValid ? const Color(0xFF6366F1) : const Color(0xFFDC2626),
        ),
      ),
    );
  }

  // ─── Detail Info Section ───────────────────────────────────────
  Widget _buildDetailSection(
      StudentCard card, bool isValid, int daysDiff, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                l10n.cardDetail,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          _buildDetailRow(
            Icons.person_outline,
            l10n.labelStudentName,
            card.studentName,
          ),
          _buildDetailDivider(),
          _buildDetailRow(
            Icons.school_outlined,
            l10n.labelSchool,
            card.institution,
          ),
          _buildDetailDivider(),
          _buildDetailRow(
            Icons.admin_panel_settings_outlined,
            l10n.labelPrincipal,
            card.principal,
          ),
          _buildDetailDivider(),
          _buildDetailRow(
            Icons.numbers,
            l10n.labelCardNumber,
            _cardNumber(),
          ),
          _buildDetailDivider(),
          _buildDetailRow(
            Icons.calendar_today_outlined,
            l10n.labelValidityPeriod,
            '${_formatDate(card.startDate)} - ${_formatDate(card.endDate)}',
          ),
          _buildDetailDivider(),
          _buildDetailRow(
            Icons.event_available_outlined,
            l10n.labelIssueDate,
            _formatDate(card.startDate),
          ),
          _buildDetailDivider(),

          // Status row with colored value
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Icon(
                  isValid ? Icons.check_circle_outline : Icons.error_outline,
                  size: 18,
                  color: isValid
                      ? const Color(0xFF16A34A)
                      : const Color(0xFFDC2626),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  child: Text(
                    l10n.labelStatus,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF999999),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: isValid
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isValid ? l10n.valid : l10n.expired,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isValid
                                ? const Color(0xFF16A34A)
                                : const Color(0xFFDC2626),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isValid
                            ? l10n.daysRemaining(daysDiff)
                            : l10n.daysExpired(daysDiff),
                        style: TextStyle(
                          fontSize: 12,
                          color: isValid
                              ? const Color(0xFF16A34A)
                              : const Color(0xFFDC2626),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFBBBBBB)),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF999999),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailDivider() {
    return const Divider(height: 0, color: Color(0xFFF3F4F6));
  }

  // ─── Verification Section ────────────────────────────────────
  Widget _buildVerificationSection(AppLocalizations l10n) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, _) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF6366F1).withValues(alpha: 0.03),
                const Color(0xFF818CF8).withValues(alpha: 0.06),
                const Color(0xFFA78BFA).withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Color(0xFF6366F1)
                  .withValues(alpha: 0.15 + 0.1 * _glowController.value),
            ),
          ),
          child: Column(
            children: [
              // Shield icon with glow
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  size: 24,
                  color: Color(0xFF6366F1),
                ),
              ),
              const SizedBox(height: 12),

              Text(
                l10n.digitalVerification,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6366F1),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.card.isValid
                    ? l10n.cardAuthentic
                    : l10n.cardExpiredWarning,
                style: TextStyle(
                  fontSize: 12,
                  color: widget.card.isValid
                      ? const Color(0xFF666666)
                      : const Color(0xFFDC2626),
                ),
              ),
              const SizedBox(height: 18),

              // Rolling clock
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, _) {
                            return Icon(
                              Icons.access_time_filled,
                              size: 14,
                              color: Color(0xFF6366F1).withValues(
                                  alpha:
                                      0.5 + 0.5 * _pulseController.value),
                            );
                          },
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n.antiForgeryNote,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF6366F1),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _RollingTime(time: _currentTime),
                    const SizedBox(height: 6),
                    Text(
                      _formatDate(_currentTime),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.security, size: 12, color: const Color(0xFF999999)),
                  const SizedBox(width: 4),
                  Text(
                    l10n.tapToVerify,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Barcode Section ─────────────────────────────────────────
  Widget _buildBarcodeSection(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          // Simulated barcode
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomPaint(
              painter: _BarcodePainter(data: widget.card.id),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _cardNumber(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
              letterSpacing: 2,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Supporting Widgets & Painters
// ═══════════════════════════════════════════════════════════════

/// Rolling time digits with slide animation
class _RollingTime extends StatelessWidget {
  final DateTime time;

  const _RollingTime({required this.time});

  @override
  Widget build(BuildContext context) {
    final timeStr =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';

    final chars = timeStr.split('');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(chars.length, (i) {
        final char = chars[i];
        if (char == ':') {
          return Text(
            ':',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          );
        }
        return _RollingDigit(
          key: ValueKey('pos_$i'),
          digit: char,
        );
      }),
    );
  }
}

class _RollingDigit extends StatelessWidget {
  final String digit;

  const _RollingDigit({super.key, required this.digit});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final slideIn = Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(
          position: slideIn,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Text(
        digit,
        key: ValueKey(digit),
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A1A1A),
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

/// Holographic shimmer effect
class _HolographicPainter extends CustomPainter {
  final double progress;

  _HolographicPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final shimmerWidth = size.width * 0.6;
    final startX = -shimmerWidth + (size.width + shimmerWidth) * progress;

    final rect = Rect.fromLTWH(startX, 0, shimmerWidth, size.height);

    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.transparent,
        const Color(0xFF6366F1).withValues(alpha: 0.04),
        const Color(0xFF818CF8).withValues(alpha: 0.08),
        const Color(0xFFA78BFA).withValues(alpha: 0.06),
        const Color(0xFF6366F1).withValues(alpha: 0.04),
        Colors.transparent,
      ],
      stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..blendMode = BlendMode.srcOver;

    canvas.save();
    canvas.transform(Matrix4.rotationZ(-0.15).storage);
    canvas.drawRect(
      Rect.fromLTWH(startX, -20, shimmerWidth, size.height + 40),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_HolographicPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Watermark pattern painter
class _WatermarkPainter extends CustomPainter {
  final String text;
  final double opacity;

  _WatermarkPainter({required this.text, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Color(0xFF6366F1).withValues(alpha: opacity),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.save();
    canvas.rotate(-0.3);

    for (double y = -100; y < size.height + 100; y += 60) {
      for (double x = -100; x < size.width + 200; x += textPainter.width + 40) {
        textPainter.paint(canvas, Offset(x, y));
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_WatermarkPainter oldDelegate) => false;
}

/// Barcode painter (decorative)
class _BarcodePainter extends CustomPainter {
  final String data;

  _BarcodePainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(data.hashCode);
    final barColor = const Color(0xFF1A1A1A);
    final paint = Paint()..color = barColor;

    double x = 16;
    final maxX = size.width - 16;

    while (x < maxX) {
      final barWidth = 1.0 + random.nextDouble() * 2.5;
      final gapWidth = 1.0 + random.nextDouble() * 2.0;

      if (x + barWidth > maxX) break;

      canvas.drawRect(
        Rect.fromLTWH(x, 4, barWidth, size.height - 8),
        paint,
      );

      x += barWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(_BarcodePainter oldDelegate) =>
      oldDelegate.data != data;
}
