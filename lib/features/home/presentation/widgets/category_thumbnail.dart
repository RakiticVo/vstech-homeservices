import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';

/// Photo-first squircle thumbnail for a service category: the API `imageUrl` when present,
/// otherwise a placeholder illustration (Design System rule 6).
class CategoryThumbnail extends StatelessWidget {
  const CategoryThumbnail({required this.imageUrl, required this.size, super.key});

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final placeholder = Image.asset(
      AppAssets.svcAppliance,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => Icon(Icons.home_repair_service_outlined, color: AppColors.textMuted, size: size / 2),
    );
    final url = imageUrl;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: SizedBox.square(
        dimension: size,
        child: url == null || url.isEmpty
            ? Padding(padding: const EdgeInsets.all(AppSpacing.xs), child: placeholder)
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (_, _) => const ColoredBox(color: AppColors.secondarySurface),
                errorWidget: (_, _, _) => Padding(padding: const EdgeInsets.all(AppSpacing.xs), child: placeholder),
              ),
      ),
    );
  }
}
