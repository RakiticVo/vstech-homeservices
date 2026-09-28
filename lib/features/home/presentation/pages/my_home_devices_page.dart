import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing the user's home equipment health log & maintenance schedule (Cell 101 `devices`).
class MyHomeDevicesPage extends StatefulWidget {
  const MyHomeDevicesPage({super.key});

  @override
  State<MyHomeDevicesPage> createState() => _MyHomeDevicesPageState();
}

class _MyHomeDevicesPageState extends State<MyHomeDevicesPage> {
  int _selectedTabIndex = 0;

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
              context.go(AppRoutes.customerHome);
            }
          },
        ),
        title: Text(
          l10n.devicesTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
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
              // Address Selector Card
              _buildAddressCard(context),
              const SizedBox(height: AppSpacing.md),

              // Tab Bar (Thiết bị vs Lịch bảo trì)
              _buildTabBar(context),
              const SizedBox(height: AppSpacing.md),

              // Tab Body
              if (_selectedTabIndex == 0)
                _buildDevicesTab(context)
              else
                _buildScheduleTab(context),

              // Bottom clearance
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius: BorderRadius.circular(AppRadius.control),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.apartment,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.addressesTagHome,
                  style: AppTextStyles.titleLg.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '123 Nguyễn Thị Minh Khai, Quận 1',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton(
            key: const Key('change_address_button'),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondary,
            ),
            onPressed: () => context.push(AppRoutes.myAddresses),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          _buildTabItem(
            title: l10n.devicesTabDevices(4),
            index: 0,
          ),
          _buildTabItem(
            title: l10n.devicesTabSchedule,
            index: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDevicesTab(BuildContext context) {
    final l10n = context.l10n;
    final devices = [
      _DeviceItem(
        name: 'Máy lạnh phòng khách',
        brand: 'Daikin',
        status: l10n.devicesStatusGood,
        isGood: true,
        lastService: '12/02/2025',
        iconData: Icons.ac_unit,
      ),
      _DeviceItem(
        name: 'Máy giặt cửa trước',
        brand: 'LG',
        status: l10n.devicesStatusGood,
        isGood: true,
        lastService: '28/02/2025',
        iconData: Icons.local_laundry_service,
      ),
      _DeviceItem(
        name: 'Tủ lạnh Inverter',
        brand: 'Samsung',
        status: l10n.devicesStatusGood,
        isGood: true,
        lastService: '15/02/2025',
        iconData: Icons.kitchen,
      ),
      _DeviceItem(
        name: 'Máy nước nóng trực tiếp',
        brand: 'Ariston',
        status: l10n.devicesStatusNeedsService,
        isGood: false,
        lastService: '10/01/2025',
        iconData: Icons.water_drop,
        badgeText: '!',
      ),
    ];

    return Column(
      children: [
        // List of device cards
        ...devices.map((device) => _buildDeviceRow(context, device)),

        const SizedBox(height: AppSpacing.md),

        // Add Device CTA button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            key: const Key('add_device_button'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.devicesAddDevice)),
              );
            },
            icon: const Icon(Icons.add, color: AppColors.primary, size: 20),
            label: Text(
              l10n.devicesAddDevice,
              style: AppTextStyles.bodyMd.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.secondarySurface,
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.control),
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Urgent reminder banner
        _buildOverdueBanner(context),
      ],
    );
  }

  Widget _buildDeviceRow(BuildContext context, _DeviceItem device) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
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
                  device.iconData,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              if (device.badgeText != null)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      device.badgeText!,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.name,
                  style: AppTextStyles.titleLg.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    text: '${device.brand} · ',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: device.status,
                        style: AppTextStyles.caption.copyWith(
                          color: device.isGood ? AppColors.success : AppColors.error,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  context.l10n.devicesLastService(device.lastService),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textMuted,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildOverdueBanner(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF3E0),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: const Color(0xFFF2E3C4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: Color(0xFFD97706),
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.devicesOverdueReminder,
                  style: AppTextStyles.titleLg.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF8A4E05),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.devicesOverdueDesc,
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
    );
  }

  Widget _buildScheduleTab(BuildContext context) {
    final l10n = context.l10n;
    final schedules = [
      _ScheduleItem(
        day: '02',
        month: 'Th5',
        title: 'Bảo trì máy nước nóng',
        subtitle: l10n.devicesScheduleOverdueMonths(3, 'Ariston'),
        tag: l10n.devicesScheduleOverdueTag,
        tagColor: AppColors.error,
        tagBgColor: const Color(0xFFFDE8E4),
      ),
      _ScheduleItem(
        day: '12',
        month: 'Th5',
        title: 'Vệ sinh máy lạnh định kỳ',
        subtitle: l10n.devicesScheduleFrequency(3, 'Daikin'),
        tag: l10n.devicesScheduleUpcomingTag,
        tagColor: const Color(0xFFA35A06),
        tagBgColor: const Color(0xFFFDF0D8),
      ),
      _ScheduleItem(
        day: '28',
        month: 'Th8',
        title: 'Bảo dưỡng máy giặt',
        subtitle: l10n.devicesScheduleFrequency(6, 'LG'),
        tag: l10n.devicesScheduleFutureTag(4),
        tagColor: AppColors.primary,
        tagBgColor: AppColors.secondarySurface,
      ),
    ];

    return Column(
      children: schedules.map((item) => _buildScheduleRow(context, item)).toList(),
    );
  }

  Widget _buildScheduleRow(BuildContext context, _ScheduleItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                Text(
                  item.day,
                  style: AppTextStyles.titleLg.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: item.tagColor,
                  ),
                ),
                Text(
                  item.month,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: AppSpacing.md),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: item.tagColor, width: 2),
                ),
              ),
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
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: item.tagBgColor,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                    ),
                    child: Text(
                      item.tag,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: item.tagColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceItem {
  const _DeviceItem({
    required this.name,
    required this.brand,
    required this.status,
    required this.isGood,
    required this.lastService,
    required this.iconData,
    this.badgeText,
  });

  final String name;
  final String brand;
  final String status;
  final bool isGood;
  final String lastService;
  final IconData iconData;
  final String? badgeText;
}

class _ScheduleItem {
  const _ScheduleItem({
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.tagColor,
    required this.tagBgColor,
  });

  final String day;
  final String month;
  final String title;
  final String subtitle;
  final String tag;
  final Color tagColor;
  final Color tagBgColor;
}
