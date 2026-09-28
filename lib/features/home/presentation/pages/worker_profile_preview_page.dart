import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing the preview profile of a technician (Cell 112 `wprev`).
class WorkerProfilePreviewPage extends StatefulWidget {
  const WorkerProfilePreviewPage({super.key});

  @override
  State<WorkerProfilePreviewPage> createState() => _WorkerProfilePreviewPageState();
}

class _WorkerProfilePreviewPageState extends State<WorkerProfilePreviewPage> {
  bool _isFav = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
              context.go(AppRoutes.favouritePros);
            }
          },
        ),
        title: Text(
          l10n.workerPreviewTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            key: const Key('toggle_worker_fav'),
            icon: Icon(
              _isFav ? Icons.favorite : Icons.favorite_border,
              color: _isFav ? const Color(0xFFE11D48) : AppColors.textSecondary,
            ),
            onPressed: () => setState(() => _isFav = !_isFav),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  children: [
                    // Technician avatar & main info
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            decoration: const BoxDecoration(
                              color: AppColors.secondarySurface,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'H',
                              style: AppTextStyles.headlineLg.copyWith(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Trần Văn Hùng',
                            style: AppTextStyles.headlineMd.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '★ 4.9 · 128 đánh giá',
                            style: AppTextStyles.bodyMd.copyWith(
                              color: const Color(0xFFA35A06),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondarySurface,
                              borderRadius: BorderRadius.circular(AppRadius.chip),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.verified,
                                  color: AppColors.primary,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    l10n.workerPreviewVerifiedPro,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.caption.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Specialized services
                    _buildSectionTitle(l10n.workerPreviewServices),
                    const SizedBox(height: AppSpacing.sm),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          'Vệ sinh máy lạnh',
                          'Sửa chữa điện nước',
                          'Dọn dẹp nhà cửa',
                        ].map((skill) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(AppRadius.full),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              skill,
                              style: AppTextStyles.bodyMd.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Recent job
                    _buildSectionTitle('Công việc gần nhất'),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        'Vệ sinh máy lạnh · 18/03/2025',
                        style: AppTextStyles.bodyMd.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Review Quote
                    _buildSectionTitle(l10n.workerPreviewRecentReview),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '“Anh Hùng vệ sinh máy lạnh rất kỹ, làm xong dọn dẹp sạch sẽ sàn nhà. Rất hài lòng!”',
                            style: AppTextStyles.bodyMd.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppColors.textPrimary,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Nguyễn Thị Mai · 18/03/2025',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  key: const Key('book_worker_profile_button'),
                  onPressed: () => context.push(AppRoutes.bookingStep1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  child: Text(
                    l10n.workerPreviewBookCta,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.titleLg.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
