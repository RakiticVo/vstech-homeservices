import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/profile_cubit.dart';

/// Screen representing customer profile editing (Cell 105 `eprof`). Prefilled from
/// [ProfileCubit] and saved with `PUT /profiles`. Date of birth has no API field yet and stays
/// local to the screen.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _dobController;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _dobController = TextEditingController();
    final profile = context.read<ProfileCubit>().state.profile;
    if (profile != null) _fill(profile);
  }

  void _fill(UserProfile profile) {
    _nameController.text = profile.fullName;
    _phoneController.text = profile.phoneNumber ?? '';
    _emailController.text = profile.email ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final email = _emailController.text.trim();
    unawaited(
      context.read<ProfileCubit>().save(
        ProfileUpdate(
          fullName: _nameController.text,
          phoneNumber: _phoneController.text,
          email: email.isEmpty ? null : email,
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, ProfileState state) {
    final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    switch (state) {
      case ProfileLoadedState(:final data):
        _fill(data);
      case ProfileSavedState():
        setState(() => _isSaved = true);
        messenger.showSnackBar(SnackBar(content: Text(context.l10n.editProfileSavedSuccess)));
      case ProfileSaveErrorState(:final failure) || ProfileLoadErrorState(:final failure):
        messenger.showSnackBar(SnackBar(content: Text(context.l10n.failureMessage(failure))));
      case ProfileInitialState() || ProfileLoadingState() || ProfileSavingState():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final profile = context.select<ProfileCubit, UserProfile?>((cubit) => cubit.state.profile);
    final isSaving = context.select<ProfileCubit, bool>((cubit) => cubit.state is ProfileSavingState);

    return BlocListener<ProfileCubit, ProfileState>(
      listener: _onStateChanged,
      child: Scaffold(
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
            l10n.editProfileTitle,
            style: AppTextStyles.headlineMd.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  child: Column(
                    children: [
                      // Saved Success Banner
                      if (_isSaved) ...[
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.secondarySurface,
                            borderRadius: BorderRadius.circular(AppRadius.control),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  l10n.editProfileSavedSuccess,
                                  style: AppTextStyles.bodyMd.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Avatar section
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
                                profile?.initials ?? '',
                                style: AppTextStyles.headlineLg.copyWith(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                l10n.editProfileChangeAvatar,
                                style: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      // Full name
                      _buildField(keyName: 'name', label: l10n.editProfileFullName, controller: _nameController),
                      const SizedBox(height: AppSpacing.md),

                      // Phone Number
                      _buildField(
                        keyName: 'phone',
                        label: l10n.editProfilePhone,
                        controller: _phoneController,
                        tag: l10n.editProfileOtpNotice,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Email
                      _buildField(keyName: 'email', label: l10n.editProfileEmail, controller: _emailController),
                      const SizedBox(height: AppSpacing.md),

                      // Date of birth
                      _buildField(keyName: 'dob', label: l10n.editProfileDob, controller: _dobController),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),

              // Save CTA
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    key: const Key('save_profile_button'),
                    onPressed: isSaving || profile == null ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.full)),
                    ),
                    child: Text(
                      l10n.editProfileSaveCta,
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
      ),
    );
  }

  Widget _buildField({
    required String keyName,
    required String label,
    required TextEditingController controller,
    String? tag,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, color: AppColors.textSecondary),
            ),
            if (tag != null)
              Flexible(
                child: Text(
                  tag,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFA35A06),
                    fontSize: 11,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: TextField(
            key: Key('edit_profile_$keyName'),
            controller: controller,
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
            decoration: const InputDecoration(isDense: true, border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
