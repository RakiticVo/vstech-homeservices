import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Concentric radar pulse scanning animation for worker dispatch matching.
/// Renders 3 expanding concentric ripples in Teal with center pulsating icon.
class RadarPulseAnimation extends StatefulWidget {
  const RadarPulseAnimation({
    super.key,
    this.size = 220,
    this.radiusLabel = '2.5 km',
  });

  final double size;
  final String radiusLabel;

  @override
  State<RadarPulseAnimation> createState() => _RadarPulseAnimationState();
}

class _RadarPulseAnimationState extends State<RadarPulseAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Concentric pulse ripple 1
              _buildRipple(scale: _controller.value, delay: 0),
              // Concentric pulse ripple 2
              _buildRipple(scale: (_controller.value + 0.33) % 1.0, delay: 0.33),
              // Concentric pulse ripple 3
              _buildRipple(scale: (_controller.value + 0.66) % 1.0, delay: 0.66),

              // Outer boundary ring
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
              ),

              // Center pulsing target dot
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.radar_rounded,
                    size: 32,
                    color: AppColors.primary,
                  ),
                ),
              ),

              // Radar scanning beam line / badge at bottom
              Positioned(
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    widget.radiusLabel,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRipple({required double scale, required double delay}) {
    final opacity = (1.0 - scale).clamp(0.0, 1.0);

    return Container(
      width: widget.size * scale,
      height: widget.size * scale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: 0.08 * opacity),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.35 * opacity),
          width: 1.5,
        ),
      ),
    );
  }
}
