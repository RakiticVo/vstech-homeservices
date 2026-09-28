import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen displaying the customer's saved addresses (Cell 107 `addrs`).
class MyAddressesPage extends StatefulWidget {
  const MyAddressesPage({super.key});

  @override
  State<MyAddressesPage> createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {
  final List<_AddressItem> _addresses = [
    _AddressItem(
      id: 'addr_1',
      tag: 'NHÀ',
      isDefault: true,
      title: 'Nhà riêng',
      body: '123 Nguyễn Thị Minh Khai, Phường Bến Thành, Quận 1, TP. Hồ Chí Minh',
      site: 'Nhà phố · không phụ phí mặt bằng',
      note: 'Ghi chú: Gọi chuông cổng ngoài',
    ),
    _AddressItem(
      id: 'addr_2',
      tag: 'CÔNG TY',
      isDefault: false,
      title: 'Văn phòng Bitexco',
      body: '2 Hải Triều, Bến Nghé, Quận 1, TP. Hồ Chí Minh',
      site: 'Chung cư / Toà nhà tầng 21 · có thang máy',
      note: 'Ghi chú: Gửi xe ở hầm B2, lên lễ tân tầng trệt',
    ),
  ];

  void _setDefault(String id) {
    setState(() {
      for (final a in _addresses) {
        a.isDefault = a.id == id;
      }
    });
  }

  void _deleteAddress(String id) {
    setState(() {
      _addresses.removeWhere((a) => a.id == id);
    });
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
              context.go(AppRoutes.customerProfile);
            }
          },
        ),
        title: Text(
          l10n.addressesTitle,
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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  final addr = _addresses[index];
                  return _buildAddressCard(context, addr);
                },
              ),
            ),

            // Add address CTA
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
                  key: const Key('add_new_address_button'),
                  onPressed: () => context.push(AppRoutes.editAddress),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  child: Text(
                    l10n.addressesAddNew,
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

  Widget _buildAddressCard(BuildContext context, _AddressItem addr) {
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
          // Badges
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  addr.tag,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (addr.isDefault) ...[
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    l10n.addressesDefaultBadge,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Title
          Text(
            addr.title,
            style: AppTextStyles.titleLg.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3),

          // Body
          Text(
            addr.body,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),

          // Site
          Text(
            addr.site,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),

          // Note
          if (addr.note != null) ...[
            const SizedBox(height: 4),
            Text(
              addr.note!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.sm),

          // Actions
          Row(
            children: [
              InkWell(
                key: Key('edit_${addr.id}'),
                onTap: () => context.push(AppRoutes.editAddress),
                child: Text(
                  l10n.addressesEditAction,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              if (addr.isDefault)
                Expanded(
                  child: Text(
                    l10n.addressesDefaultCannotDelete,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else ...[
                InkWell(
                  key: Key('set_default_${addr.id}'),
                  onTap: () => _setDefault(addr.id),
                  child: Text(
                    l10n.addressesSetDefaultAction,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                InkWell(
                  key: Key('delete_${addr.id}'),
                  onTap: () => _deleteAddress(addr.id),
                  child: Text(
                    l10n.addressesDeleteAction,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.error,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _AddressItem {
  _AddressItem({
    required this.id,
    required this.tag,
    required this.isDefault,
    required this.title,
    required this.body,
    required this.site,
    this.note,
  });

  final String id;
  final String tag;
  bool isDefault;
  final String title;
  final String body;
  final String site;
  final String? note;
}
