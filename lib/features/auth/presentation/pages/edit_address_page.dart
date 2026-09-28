import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing adding or editing a customer address (Cell 108 `addredit`).
class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  String _selectedLabel = 'home';
  String _houseType = 'cc'; // 'nha' or 'cc'
  int _floor = 5;
  bool _hasElevator = true;
  bool _isDefault = false;

  final TextEditingController _addressController = TextEditingController(
    text: '123 Nguyễn Thị Minh Khai, Phường Bến Thành, Quận 1',
  );
  final TextEditingController _noteController = TextEditingController(
    text: 'Gửi xe ở hầm B2, gọi chuông cổng',
  );

  @override
  void dispose() {
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

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
              context.go(AppRoutes.myAddresses);
            }
          },
        ),
        title: Text(
          l10n.addressEditTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Address Label Selector
                    _buildSectionHeader(l10n.addressEditLabelSection),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        _buildLabelChip(
                          label: l10n.addressesTagHome,
                          value: 'home',
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _buildLabelChip(
                          label: l10n.addressesTagWork,
                          value: 'work',
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _buildLabelChip(
                          label: l10n.addressesTagOther,
                          value: 'other',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Search address & Map preview
                    _buildSectionHeader(l10n.profileMenuAddresses),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: TextField(
                        key: const Key('address_search_input'),
                        controller: _addressController,
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.addressEditSearchPlaceholder,
                          hintStyle: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.textMuted,
                          ),
                          icon: const Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Mini map container
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.map,
                            color: AppColors.textMuted,
                            size: 48,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xCC0F172A),
                                borderRadius: BorderRadius.circular(AppRadius.chip),
                              ),
                              child: Text(
                                l10n.addressEditPinNote,
                                style: AppTextStyles.caption.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Property type (Nhà phố vs Chung cư)
                    _buildSectionHeader(l10n.addressEditHouseType),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _buildHouseTypeOption(
                                label: l10n.addressEditTownhouse,
                                value: 'nha',
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _buildHouseTypeOption(
                                label: l10n.addressEditApartment,
                                value: 'cc',
                              ),
                            ],
                          ),
                          if (_houseType == 'cc') ...[
                            const SizedBox(height: AppSpacing.md),
                            // Floor stepper
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.addressEditFloor,
                                  style: AppTextStyles.bodyMd.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      key: const Key('floor_minus_button'),
                                      icon: const Icon(Icons.remove_circle_outline),
                                      color: AppColors.primary,
                                      onPressed: () {
                                        if (_floor > 1) {
                                          setState(() => _floor--);
                                        }
                                      },
                                    ),
                                    Text(
                                      '$_floor',
                                      style: AppTextStyles.titleLg.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    IconButton(
                                      key: const Key('floor_plus_button'),
                                      icon: const Icon(Icons.add_circle_outline),
                                      color: AppColors.primary,
                                      onPressed: () {
                                        setState(() => _floor++);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            // Elevator toggle
                            Row(
                              children: [
                                _buildElevatorOption(
                                  label: l10n.addressEditHasElevator,
                                  value: true,
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                _buildElevatorOption(
                                  label: l10n.addressEditNoElevator,
                                  value: false,
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Note
                    _buildSectionHeader(l10n.addressEditAccessNote),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: TextField(
                        key: const Key('address_note_input'),
                        controller: _noteController,
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Default switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            l10n.addressEditSetDefaultSwitch,
                            style: AppTextStyles.bodyMd.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Switch(
                          key: const Key('default_address_switch'),
                          value: _isDefault,
                          activeThumbColor: AppColors.primary,
                          onChanged: (val) => setState(() => _isDefault = val),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),

            // Save CTA
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
                  key: const Key('save_address_button'),
                  onPressed: () {
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  child: Text(
                    l10n.addressEditSaveCta,
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.titleLg.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildLabelChip({required String label, required String value}) {
    final isSelected = _selectedLabel == value;
    return Expanded(
      child: InkWell(
        key: Key('label_chip_$value'),
        onTap: () => setState(() => _selectedLabel = value),
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHouseTypeOption({required String label, required String value}) {
    final isSelected = _houseType == value;
    return Expanded(
      child: InkWell(
        key: Key('house_type_$value'),
        onTap: () => setState(() => _houseType = value),
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatorOption({required String label, required bool value}) {
    final isSelected = _hasElevator == value;
    return Expanded(
      child: InkWell(
        key: Key('elevator_${value ? "yes" : "no"}'),
        onTap: () => setState(() => _hasElevator = value),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
