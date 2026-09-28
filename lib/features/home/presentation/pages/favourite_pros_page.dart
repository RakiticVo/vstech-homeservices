import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen displaying the customer's favourite pros (Cell 111 `favs`).
class FavouriteProsPage extends StatefulWidget {
  const FavouriteProsPage({super.key});

  @override
  State<FavouriteProsPage> createState() => _FavouriteProsPageState();
}

class _FavouriteProsPageState extends State<FavouriteProsPage> {
  final List<_FavWorker> _workers = [
    _FavWorker(
      id: 'hung',
      name: 'Trần Văn Hùng',
      ratingText: '★ 4.9 · 128 đánh giá',
      services: 'Vệ sinh máy lạnh · Sửa chữa điện nước · Dọn nhà',
      lastJob: 'Vệ sinh máy lạnh · 18/03/2025',
      initials: 'H',
      isFav: true,
    ),
    _FavWorker(
      id: 'duc',
      name: 'Phạm Minh Đức',
      ratingText: '★ 4.8 · 96 đánh giá',
      services: 'Giặt sofa - nệm · Dọn dẹp nhà cửa',
      lastJob: 'Giặt sofa - nệm · 28/02/2025',
      initials: 'Đ',
      isFav: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final activeWorkers = _workers.where((w) => w.isFav).toList();

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
              context.go(AppRoutes.customerProfile);
            }
          },
        ),
        title: Text(
          l10n.favsTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: activeWorkers.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: Text(
                    l10n.favsEmpty,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.55,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                itemCount: activeWorkers.length,
                itemBuilder: (context, index) {
                  final worker = activeWorkers[index];
                  return _buildWorkerCard(context, worker);
                },
              ),
      ),
    );
  }

  Widget _buildWorkerCard(BuildContext context, _FavWorker worker) {
    final l10n = context.l10n;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
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
              // Avatar
              GestureDetector(
                onTap: () => context.push(AppRoutes.workerProfilePreview),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: AppColors.secondarySurface,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    worker.initials,
                    style: AppTextStyles.headlineMd.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Name and rating
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(AppRoutes.workerProfilePreview),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker.name,
                        style: AppTextStyles.titleLg.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        worker.ratingText,
                        style: AppTextStyles.caption.copyWith(
                          color: const Color(0xFFA35A06),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Heart Icon Button
              IconButton(
                key: Key('toggle_fav_${worker.id}'),
                icon: const Icon(
                  Icons.favorite,
                  color: Color(0xFFE11D48),
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    worker.isFav = !worker.isFav;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Services
          Text(
            worker.services,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),

          // Last Job
          Text(
            l10n.favsLastJob(worker.lastJob),
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Rebook CTA
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              key: Key('rebook_${worker.id}'),
              onPressed: () => context.push(AppRoutes.bookingStep1),
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.secondarySurface,
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
              child: Text(
                l10n.favsRebookCta,
                style: AppTextStyles.bodyMd.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavWorker {
  _FavWorker({
    required this.id,
    required this.name,
    required this.ratingText,
    required this.services,
    required this.lastJob,
    required this.initials,
    required this.isFav,
  });

  final String id;
  final String name;
  final String ratingText;
  final String services;
  final String lastJob;
  final String initials;
  bool isFav;
}
