import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Warranty Request Screen (`bhreq` — Cell 89).
///
/// Customer submits an issue description, attaches photos/video, and selects
/// preferred time slots for warranty dispatch (0đ free guarantee).
class WarrantyRequestPage extends StatefulWidget {
  const WarrantyRequestPage({
    super.key,
    this.orderCode = 'HS-20250318-0087',
  });

  final String orderCode;

  @override
  State<WarrantyRequestPage> createState() => _WarrantyRequestPageState();
}

class _WarrantyRequestPageState extends State<WarrantyRequestPage> {
  late final TextEditingController _descController;
  final List<String> _mediaList = ['IMG_0521', 'IMG_0522'];
  final Set<int> _selectedSlots = <int>{};

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  bool get _hasDescription => _descController.text.trim().isNotEmpty;
  bool get _hasSlots => _selectedSlots.isNotEmpty;
  bool get _canSubmit => _hasDescription && _hasSlots;

  void _onSlotTapped(int index) {
    setState(() {
      if (_selectedSlots.contains(index)) {
        _selectedSlots.remove(index);
      } else {
        _selectedSlots.add(index);
      }
    });
  }

  void _addMockPhoto() {
    if (_mediaList.length < 5) {
      setState(() {
        _mediaList.add('IMG_052${_mediaList.length + 1}');
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _mediaList.removeAt(index);
    });
  }

  void _submitRequest() {
    if (!_canSubmit) return;
    unawaited(context.push(AppRoutes.warrantyStatus));
  }

  @override
  Widget build(BuildContext context) {
    final slots = [
      context.l10n.warrantySlot1,
      context.l10n.warrantySlot2,
      context.l10n.warrantySlot3,
    ];

    String ctaLabel;
    if (!_hasDescription) {
      ctaLabel = context.l10n.warrantyDescRequiredPrompt;
    } else if (!_hasSlots) {
      ctaLabel = context.l10n.warrantySlotRequiredPrompt;
    } else {
      ctaLabel = context.l10n.warrantySubmitCta;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.warrantyRequestTitle,
          style: GoogleFonts.sourceSans3(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // Linked Order Header Card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vệ sinh & Bảo dưỡng Máy lạnh Inverter',
                              style: AppTextStyles.labelLarge.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              context.l10n.warrantyRequestSubtitle(widget.orderCode),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        context.l10n.warrantyRequestFreePrice,
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Issue Description
                Text(
                  context.l10n.warrantyDescribeIssueTitle,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: TextField(
                    controller: _descController,
                    maxLines: 3,
                    onChanged: (_) => setState(() {}),
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: context.l10n.warrantyDescribePlaceholder,
                      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      _descController.text = context.l10n.warrantyDescribePreset;
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      child: Text(
                        '💡 ${context.l10n.warrantyDescribePreset}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Photos / Video Grid
                Text(
                  context.l10n.warrantyMediaTitle,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (int i = 0; i < _mediaList.length; i++)
                      _buildPhotoThumbnail(
                        name: _mediaList[i],
                        onDelete: () => _removePhoto(i),
                      ),
                    if (_mediaList.length < 5)
                      _buildAddPhotoCard(onTap: _addMockPhoto),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // Preferred Time Slots (Multi-selection)
                Text(
                  context.l10n.warrantySlotTitle,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                for (int i = 0; i < slots.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _buildSlotItem(
                      index: i,
                      label: slots[i],
                      isSelected: _selectedSlots.contains(i),
                    ),
                  ),

                const SizedBox(height: AppSpacing.md),

                // Free Guarantee Card
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_outlined, size: 20, color: AppColors.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          context.l10n.warrantyFreePolicy,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Submission CTA
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: AppButton(
              label: ctaLabel,
              icon: Icons.send_rounded,
              onPressed: _canSubmit ? _submitRequest : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoThumbnail({
    required String name,
    required VoidCallback onDelete,
  }) {
    return Container(
      width: 100,
      height: 84,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image_outlined, size: 24, color: AppColors.textMuted),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: InkWell(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.textPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoCard({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: Container(
        width: 100,
        height: 84,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_a_photo_outlined, size: 20, color: AppColors.textMuted),
              const SizedBox(height: 4),
              Text(
                context.l10n.warrantyAddPhotoCta,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlotItem({
    required int index,
    required String label,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => _onSlotTapped(index),
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
              size: 20,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
