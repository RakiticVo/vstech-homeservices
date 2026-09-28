import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_text_field.dart';

/// 6-Step Worker KYC Onboarding Wizard.
/// Steps:
/// 1: Phone + OTP (Reused from Auth module)
/// 2: Personal info & Service district selection (Multi-chip)
/// 3: 2-Sided National ID Card verification
/// 4: Facial selfie capture
/// 5: Skills & Safety certificates upload
/// 6: Payout bank account linking (Name must match ID 100%)
class WorkerKycWizardPage extends StatefulWidget {
  const WorkerKycWizardPage({
    this.initialStep = 2,
    super.key,
  });

  final int initialStep;

  @override
  State<WorkerKycWizardPage> createState() => _WorkerKycWizardPageState();
}

class _WorkerKycWizardPageState extends State<WorkerKycWizardPage> {
  late int _currentStep;

  // Step 2 state
  final TextEditingController _fullNameController = TextEditingController(text: 'Trần Văn Hùng');
  final Set<String> _selectedDistricts = {'q1', 'q2'};

  // Step 3 state (ID Card)
  bool _hasFrontId = false;
  bool _hasBackId = false;

  // Step 4 state (Selfie)
  bool _hasSelfie = false;

  // Step 5 state (Certificates)
  bool _hasCertificate = false;

  // Step 6 state (Bank account)
  final TextEditingController _bankNameController = TextEditingController(text: 'Vietcombank');
  final TextEditingController _accountNumberController = TextEditingController(text: '01234567890');
  final TextEditingController _accountHolderController = TextEditingController(text: 'TRAN VAN HUNG');

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountHolderController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 6) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Step 6 submitted -> navigate to KYC Status Page
      unawaited(context.push('${AppRoutes.workerKycStatus}?status=pending'));
    }
  }

  void _previousStep() {
    if (_currentStep > 2) {
      setState(() {
        _currentStep--;
      });
    } else {
      context.pop();
    }
  }

  bool get _isNextEnabled {
    switch (_currentStep) {
      case 2:
        return _fullNameController.text.trim().isNotEmpty && _selectedDistricts.isNotEmpty;
      case 3:
        return _hasFrontId && _hasBackId;
      case 4:
        return _hasSelfie;
      case 5:
        return _hasCertificate;
      case 6:
        return _bankNameController.text.trim().isNotEmpty &&
            _accountNumberController.text.trim().isNotEmpty &&
            _accountHolderController.text.trim().isNotEmpty;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: _previousStep,
        ),
        title: Text(
          context.l10n.kycTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Progress Indicator
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.kycStepProgress(_currentStep),
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '${((_currentStep / 6.0) * 100).toInt()}%',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    child: LinearProgressIndicator(
                      value: _currentStep / 6.0,
                      backgroundColor: AppColors.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),

            // Step Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  if (_currentStep == 2) _buildStep2(),
                  if (_currentStep == 3) _buildStep3(),
                  if (_currentStep == 4) _buildStep4(),
                  if (_currentStep == 5) _buildStep5(),
                  if (_currentStep == 6) _buildStep6(),
                ],
              ),
            ),

            // Pinned Bottom Button
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isNextEnabled ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.border,
                    foregroundColor: AppColors.onPrimary,
                    disabledForegroundColor: AppColors.textMuted,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    _currentStep == 6
                        ? context.l10n.kycSubmitCta
                        : context.l10n.continueText,
                    style: AppTextStyles.buttonText.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
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

  // --- Step 2: Personal info & Work area ---
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.kycStep2Title,
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.l10n.kycStep2Desc,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        AppTextField(
          controller: _fullNameController,
          label: context.l10n.registerFullNameLabel,
          hintText: context.l10n.registerFullNameHint,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.lg),

        Text(
          context.l10n.kycDistrictSelect,
          style: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _buildDistrictChip('q1', context.l10n.kycDistrictQ1),
            _buildDistrictChip('q2', context.l10n.kycDistrictQ2),
            _buildDistrictChip('q7', context.l10n.kycDistrictQ7),
            _buildDistrictChip('binh_thanh', context.l10n.kycDistrictBinhThanh),
            _buildDistrictChip('phu_nhuan', context.l10n.kycDistrictPhuNhuan),
          ],
        ),
      ],
    );
  }

  Widget _buildDistrictChip(String id, String label) {
    final isSelected = _selectedDistricts.contains(id);
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedDistricts.add(id);
          } else {
            _selectedDistricts.remove(id);
          }
        });
      },
      selectedColor: AppColors.secondarySurface,
      backgroundColor: AppColors.surface,
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.border,
      ),
      labelStyle: AppTextStyles.caption.copyWith(
        color: isSelected ? AppColors.primary : AppColors.textPrimary,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
    );
  }

  // --- Step 3: National ID 2-Sided Capture ---
  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.kycStep3Title,
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.l10n.kycStep3Desc,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        _buildCaptureBox(
          label: context.l10n.kycIdFront,
          isCaptured: _hasFrontId,
          onTap: () {
            setState(() {
              _hasFrontId = !_hasFrontId;
            });
          },
        ),
        const SizedBox(height: AppSpacing.md),

        _buildCaptureBox(
          label: context.l10n.kycIdBack,
          isCaptured: _hasBackId,
          onTap: () {
            setState(() {
              _hasBackId = !_hasBackId;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCaptureBox({
    required String label,
    required bool isCaptured,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: isCaptured ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isCaptured ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(
              isCaptured ? Icons.check_circle_rounded : Icons.camera_alt_outlined,
              size: 40,
              color: isCaptured ? AppColors.primary : AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: isCaptured ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              isCaptured
                  ? context.l10n.kycCaptured
                  : context.l10n.kycTapToCapture,
              style: AppTextStyles.caption.copyWith(
                color: isCaptured ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Step 4: Facial Selfie ---
  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.kycStep4Title,
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.l10n.kycStep4Desc,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _hasSelfie = !_hasSelfie;
              });
            },
            child: Container(
              width: 180,
              height: 240,
              decoration: BoxDecoration(
                color: _hasSelfie ? AppColors.secondarySurface : AppColors.surface,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: _hasSelfie ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _hasSelfie ? Icons.check_circle_rounded : Icons.face_rounded,
                    size: 56,
                    color: _hasSelfie ? AppColors.primary : AppColors.textMuted,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _hasSelfie ? context.l10n.kycCaptured : context.l10n.kycTakeSelfie,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _hasSelfie ? AppColors.primary : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Step 5: Expertise & Certificates ---
  Widget _buildStep5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.kycStep5Title,
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.l10n.kycStep5Desc,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        GestureDetector(
          onTap: () {
            setState(() {
              _hasCertificate = !_hasCertificate;
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: _hasCertificate ? AppColors.secondarySurface : AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(
                color: _hasCertificate ? AppColors.primary : AppColors.border,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  _hasCertificate ? Icons.verified_rounded : Icons.upload_file_outlined,
                  size: 40,
                  color: _hasCertificate ? AppColors.primary : AppColors.textMuted,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  context.l10n.kycCertUpload,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: _hasCertificate ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _hasCertificate
                      ? context.l10n.kycCertUploaded
                      : context.l10n.kycTapToCapture,
                  style: AppTextStyles.caption.copyWith(
                    color: _hasCertificate ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Step 6: Payout Bank Account ---
  Widget _buildStep6() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.kycStep6Title,
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.l10n.kycStep6Desc,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        AppTextField(
          controller: _bankNameController,
          label: context.l10n.kycBankName,
          hintText: context.l10n.kycBankHint,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          controller: _accountNumberController,
          label: context.l10n.kycAccountNumber,
          hintText: context.l10n.kycAccountNumberHint,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          controller: _accountHolderController,
          label: context.l10n.kycAccountHolder,
          hintText: context.l10n.kycAccountHolderHint,
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }
}
