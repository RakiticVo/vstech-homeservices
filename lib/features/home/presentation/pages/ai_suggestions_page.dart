import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing AI-powered tailored maintenance recommendations (Cell 103 `suggestions`).
class AiSuggestionsPage extends StatelessWidget {
  const AiSuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final suggestions = [
      _SuggestionCardItem(
        title: l10n.aiSuggestionsAcTitle,
        desc: l10n.aiSuggestionsAcDesc,
        iconData: Icons.ac_unit,
        serviceKey: 'ac',
      ),
      _SuggestionCardItem(
        title: l10n.aiSuggestionsLaundryTitle,
        desc: l10n.aiSuggestionsLaundryDesc,
        iconData: Icons.local_laundry_service,
        serviceKey: 'laundry',
      ),
      _SuggestionCardItem(
        title: l10n.aiSuggestionsPestTitle,
        desc: l10n.aiSuggestionsPestDesc,
        iconData: Icons.pest_control,
        serviceKey: 'pest',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.customerHome);
            }
          },
        ),
        title: Text(
          l10n.aiSuggestionsTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.aiSuggestionsTitle)),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Urgent Highlight Section Header
              Text(
                l10n.aiSuggestionsUrgentSection,
                style: AppTextStyles.titleLg.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Urgent Recommendation Card
              _buildUrgentCard(context),
              const SizedBox(height: AppSpacing.lg),

              // Other Suggestions Section
              Text(
                l10n.aiSuggestionsOtherSection,
                style: AppTextStyles.titleLg.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Suggestion List
              ...suggestions.map((item) => _buildSuggestionRow(context, item)),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUrgentCard(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF3E0),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: const Color(0xFFF2E3C4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE3B5),
                  borderRadius: BorderRadius.circular(AppRadius.control),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFA35A06),
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.aiSuggestionsHeaterTitle,
                      style: AppTextStyles.titleLg.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF8A4E05),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.aiSuggestionsHeaterDesc,
                      style: AppTextStyles.caption.copyWith(
                        color: const Color(0xFF7A6A55),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              key: const Key('book_suggested_heater_button'),
              onPressed: () => context.push(AppRoutes.bookingStep1),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
              child: Text(
                l10n.aiSuggestionsBookNow,
                style: AppTextStyles.bodyMd.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionRow(BuildContext context, _SuggestionCardItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () => context.push(AppRoutes.bookingStep1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.control),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(
                item.iconData,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.titleLg.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.desc,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionCardItem {
  const _SuggestionCardItem({
    required this.title,
    required this.desc,
    required this.iconData,
    required this.serviceKey,
  });

  final String title;
  final String desc;
  final IconData iconData;
  final String serviceKey;
}
