import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Worker certificate upload form screen (Cell 127 `wcert`).
class WorkerUploadCertPage extends StatefulWidget {
  const WorkerUploadCertPage({super.key});

  @override
  State<WorkerUploadCertPage> createState() => _WorkerUploadCertPageState();
}

class _WorkerUploadCertPageState extends State<WorkerUploadCertPage> {
  int _selectedTypeIndex = 0;
  bool _hasPhoto = false;
  String _selectedExpiry = '12/2026';

  final List<String> _expiryOptions = ['12/2026', '06/2027', '12/2027'];

  void _submitCert() {
    final l10n = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.wcertSubmittedSuccess),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    if (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final certTypes = [
      l10n.wcertTypeHeight,
      l10n.wcertTypeAc,
      l10n.wcertTypeOther,
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
              context.pop();
            }
          },
        ),
        title: Text(
          l10n.wcertTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Certificate Type
                    Text(
                      l10n.wcertTypeTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Column(
                      children: List.generate(certTypes.length, (index) {
                        final isSelected = _selectedTypeIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: InkWell(
                            key: Key('cert_type_$index'),
                            onTap: () {
                              setState(() {
                                _selectedTypeIndex = index;
                              });
                            },
                            borderRadius:
                                BorderRadius.circular(AppRadius.control),
                            child: Container(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.secondarySurface
                                    : AppColors.surface,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.control),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: isSelected ? 1.5 : 1.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textMuted,
                                    size: 20,
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      certTypes[index],
                                      style: AppTextStyles.bodyMd.copyWith(
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Section 2: Certificate Photo Upload
                    Text(
                      l10n.wcertPhotoTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    GestureDetector(
                      key: const Key('cert_photo_upload_box'),
                      onTap: () {
                        setState(() {
                          _hasPhoto = !_hasPhoto;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          color: _hasPhoto
                              ? AppColors.secondarySurface
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          border: Border.all(
                            color: _hasPhoto
                                ? AppColors.primary
                                : AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _hasPhoto
                                  ? Icons.check_circle_outline
                                  : Icons.add_a_photo_outlined,
                              size: 40,
                              color: _hasPhoto
                                  ? AppColors.primary
                                  : AppColors.textMuted,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              _hasPhoto
                                  ? l10n.wcertPhotoAttached
                                  : l10n.wcertPhotoTapToUpload,
                              style: AppTextStyles.bodyMd.copyWith(
                                fontWeight: FontWeight.w700,
                                color: _hasPhoto
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Định dạng JPG, PNG · Tối đa 5MB',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Section 3: Expiry Date Chips
                    Text(
                      l10n.wcertExpiryTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: _expiryOptions.map((expiry) {
                        final isSelected = _selectedExpiry == expiry;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              key: Key('cert_expiry_$expiry'),
                              onTap: () {
                                setState(() {
                                  _selectedExpiry = expiry;
                                });
                              },
                              borderRadius:
                                  BorderRadius.circular(AppRadius.control),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.secondarySurface
                                      : AppColors.surface,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.control),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.border,
                                    width: isSelected ? 1.5 : 1.0,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  expiry,
                                  style: AppTextStyles.bodyMd.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w800
                                        : FontWeight.w600,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
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
            ),

            // Submit Button
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: AppButton(
                key: const Key('submit_cert_button'),
                label: l10n.wcertSubmitCta,
                onPressed: _submitCert,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
