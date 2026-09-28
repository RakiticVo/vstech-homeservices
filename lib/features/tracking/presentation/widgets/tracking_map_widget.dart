import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Minimalist Eco-Clean GPS Map Widget.
/// Renders a responsive vector-based street map with route polyline,
/// destination pin, and worker location marker without external API keys.
class TrackingMapWidget extends StatelessWidget {
  const TrackingMapWidget({
    super.key,
    this.height = 240,
    this.workerEtaText,
    this.destinationLabel,
    this.onCenterPressed,
  });

  final double height;
  final String? workerEtaText;
  final String? destinationLabel;
  final VoidCallback? onCenterPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Stylized Vector Map Canvas
          const Positioned.fill(
            child: CustomPaint(
              painter: _MapCanvasPainter(),
            ),
          ),

          // Worker Pin (Motorbike)
          Positioned(
            left: 70,
            bottom: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (workerEtaText != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                    ),
                    child: Text(
                      workerEtaText!,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.onPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.onPrimary, width: 2),
                  ),
                  child: const Icon(
                    Icons.two_wheeler_rounded,
                    color: AppColors.onPrimary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Destination Pin
          Positioned(
            right: 70,
            top: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (destinationLabel != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      destinationLabel!,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.onPrimary, width: 2),
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: AppColors.onPrimary,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),

          // Center GPS Action Button
          Positioned(
            right: AppSpacing.md,
            bottom: AppSpacing.md,
            child: InkWell(
              onTap: onCenterPressed,
              borderRadius: BorderRadius.circular(AppRadius.control),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.my_location_rounded,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapCanvasPainter extends CustomPainter {
  const _MapCanvasPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final thinRoadPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final parkPaint = Paint()
      ..color = const Color(0xFFE6F4EA)
      ..style = PaintingStyle.fill;

    // Draw some parks
    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(20, 20, 90, 60),
          const Radius.circular(8),
        ),
        parkPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width - 120, size.height - 70, 90, 50),
          const Radius.circular(8),
        ),
        parkPaint,
      )
      // Grid roads
      ..drawLine(
        Offset(0, size.height * 0.45),
        Offset(size.width, size.height * 0.35),
        roadPaint,
      )
      ..drawLine(
        Offset(size.width * 0.35, 0),
        Offset(size.width * 0.45, size.height),
        roadPaint,
      )
      ..drawLine(
        Offset(0, size.height * 0.75),
        Offset(size.width, size.height * 0.7),
        thinRoadPaint,
      )
      ..drawLine(
        Offset(size.width * 0.75, 0),
        Offset(size.width * 0.7, size.height),
        thinRoadPaint,
      );

    // Active Navigation Route (Teal Polyline)
    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final routePath = Path()
      ..moveTo(89, size.height - 79)
      ..lineTo(size.width * 0.4, size.height * 0.6)
      ..lineTo(size.width * 0.42, size.height * 0.38)
      ..lineTo(size.width - 87, 57);

    canvas.drawPath(routePath, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
