import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Service Review & Worker Tip Screen (`review` — Concept 02: Cells 57, 58).
/// 5-star rating, service compliment tags, tip selection, and Amber commitment CTA.
class OrderReviewTipPage extends StatefulWidget {
  const OrderReviewTipPage({
    super.key,
    this.initialRating = 5,
    this.initialTip = 0,
    this.orderCode = 'HS-2026-0012',
  });

  final int initialRating;
  final int initialTip;
  final String orderCode;

  @override
  State<OrderReviewTipPage> createState() => _OrderReviewTipPageState();
}

class _OrderReviewTipPageState extends State<OrderReviewTipPage> {
  late int _rating;
  late int _selectedTip;
  final Set<String> _selectedTags = {'punctual', 'clean'};
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
    _selectedTip = widget.initialTip;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  String _formatPrice(int value) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(value)}đ';
  }

  @override
  Widget build(BuildContext context) {
    final tags = [
      {'id': 'punctual', 'label': context.l10n.reviewTagPunctual},
      {'id': 'attentive', 'label': context.l10n.reviewTagAttentive},
      {'id': 'clean', 'label': context.l10n.reviewTagClean},
      {'id': 'polite', 'label': context.l10n.reviewTagPolite},
    ];

    final tipOptions = [0, 20000, 50000, 100000];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          context.l10n.reviewTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Worker Profile Avatar & Star Rating Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: AppColors.secondarySurface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 36),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  context.l10n.trackingWorkerName,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Thợ chính · Dọn dẹp nhà cửa',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  context.l10n.reviewPrompt,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // 5 Star Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    return IconButton(
                      onPressed: () => setState(() => _rating = starIndex),
                      icon: Icon(
                        starIndex <= _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                        color: AppColors.warning,
                        size: 36,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: AppSpacing.md),

                // Quick Compliment Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: tags.map((t) {
                    final isSelected = _selectedTags.contains(t['id']);
                    return FilterChip(
                      selected: isSelected,
                      label: Text(t['label']!),
                      labelStyle: AppTextStyles.labelSmall.copyWith(
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                      backgroundColor: AppColors.surface,
                      selectedColor: AppColors.secondarySurface,
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : AppColors.border,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      onSelected: (_) => _toggleTag(t['id']!),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Comment input
                TextField(
                  controller: _commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: context.l10n.reviewCommentHint,
                    hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Tip Worker Section (Cell 58)
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.volunteer_activism_outlined, color: AppColors.warning, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        context.l10n.reviewTipTitle,
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  context.l10n.reviewTipSubtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Tip Amount Chips
                Row(
                  children: tipOptions.map((tip) {
                    final isSelected = _selectedTip == tip;
                    final label = tip == 0 ? context.l10n.reviewTipNo : _formatPrice(tip);

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          onTap: () => setState(() => _selectedTip = tip),
                          borderRadius: BorderRadius.circular(AppRadius.control),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.secondarySurface : AppColors.surface,
                              borderRadius: BorderRadius.circular(AppRadius.control),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.border,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                label,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Submit CTA Button (Amber if tip included)
          AppButton(
            label: _selectedTip > 0
                ? context.l10n.reviewSubmitWithTip(_formatPrice(_selectedTip))
                : context.l10n.reviewSubmitOnly,
            backgroundColor: _selectedTip > 0 ? AppColors.warning : AppColors.primary,
            textColor: _selectedTip > 0 ? AppColors.textPrimary : AppColors.onPrimary,
            onPressed: () {
              unawaited(context.push(AppRoutes.orderThanks));
            },
          ),
        ],
      ),
    );
  }
}
