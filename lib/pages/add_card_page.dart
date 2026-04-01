import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../l10n/app_localizations.dart';
import '../models/student_card.dart';
import '../services/storage_service.dart';

class AddCardPage extends StatefulWidget {
  final StorageService storage;

  const AddCardPage({super.key, required this.storage});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _principalController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _avatarPath;

  @override
  void dispose() {
    _studentNameController.dispose();
    _institutionController.dispose();
    _principalController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _avatarPath = image.path;
      });
    }
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? now) : (_endDate ?? now),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.selectDate),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final cardId = const Uuid().v4();
    String? savedAvatarPath;
    if (_avatarPath != null) {
      savedAvatarPath =
          await StorageService.saveAvatarImage(_avatarPath!, cardId);
    }

    final card = StudentCard(
      id: cardId,
      studentName: _studentNameController.text.trim(),
      institution: _institutionController.text.trim(),
      principal: _principalController.text.trim(),
      startDate: _startDate!,
      endDate: _endDate!,
      avatarPath: savedAvatarPath,
    );

    await widget.storage.addCard(card);
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addStudentCard)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Avatar picker card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
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
                child: GestureDetector(
                  onTap: _pickAvatar,
                  child: Column(
                    children: [
                      Container(
                        width: 96,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(16),
                          border: _avatarPath == null
                              ? Border.all(
                                  color: const Color(0xFFD1D5DB),
                                  width: 2,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                )
                              : null,
                          image: _avatarPath != null
                              ? DecorationImage(
                                  image: FileImage(File(_avatarPath!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          boxShadow: _avatarPath != null
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: _avatarPath == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6366F1)
                                          .withValues(alpha: 0.08),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.add_a_photo_rounded,
                                        size: 22, color: Color(0xFF6366F1)),
                                  ),
                                ],
                              )
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _avatarPath == null
                            ? l10n.selectFromGallery
                            : l10n.avatar,
                        style: TextStyle(
                          fontSize: 13,
                          color: _avatarPath == null
                              ? const Color(0xFF6366F1)
                              : const Color(0xFF999999),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Form fields card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _studentNameController,
                      label: l10n.studentName,
                      hint: l10n.studentNameHint,
                      icon: Icons.person_outline_rounded,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.fieldRequired
                          : null,
                    ),
                    const SizedBox(height: 18),
                    _buildTextField(
                      controller: _institutionController,
                      label: l10n.institution,
                      hint: l10n.institutionHint,
                      icon: Icons.school_outlined,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.fieldRequired
                          : null,
                    ),
                    const SizedBox(height: 18),
                    _buildTextField(
                      controller: _principalController,
                      label: l10n.principal,
                      hint: l10n.principalHint,
                      icon: Icons.admin_panel_settings_outlined,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.fieldRequired
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Date fields card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                child: Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                        label: l10n.startDate,
                        date: _startDate,
                        icon: Icons.event_outlined,
                        onTap: () => _pickDate(context, true),
                        l10n: l10n,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Icon(Icons.arrow_forward_rounded,
                              size: 18, color: const Color(0xFFD1D5DB)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _buildDateField(
                        label: l10n.endDate,
                        date: _endDate,
                        icon: Icons.event_available_outlined,
                        onTap: () => _pickDate(context, false),
                        l10n: l10n,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    shadowColor: const Color(0xFF6366F1).withValues(alpha: 0.4),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_rounded, size: 20),
                      const SizedBox(width: 8),
                      Text(l10n.save),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: const Color(0xFFBBBBBB)),
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFDC2626)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required IconData icon,
    required VoidCallback onTap,
    required AppLocalizations l10n,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18,
                    color: date != null
                        ? const Color(0xFF6366F1)
                        : const Color(0xFFCCCCCC)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    date != null
                        ? '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}'
                        : l10n.selectDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: date != null
                          ? const Color(0xFF1A1A1A)
                          : const Color(0xFFCCCCCC),
                      fontWeight: date != null ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
