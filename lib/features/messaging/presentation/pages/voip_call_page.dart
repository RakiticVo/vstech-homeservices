import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Masked VoIP Call Screen for Customer & Worker (`call` — Cells 82, 83).
///
/// Handles outgoing masked connection, duration timer, mute/speaker toggles,
/// incoming call banner, call recording compliance notice, and hangup.
class VoipCallPage extends StatefulWidget {
  const VoipCallPage({
    super.key,
    this.role = 'customer',
    this.mode = 'callout',
    this.peerName,
    this.orderCode = '#HS20250425-0012',
  });

  final String role;
  final String mode; // 'callout' or 'callin'
  final String? peerName;
  final String orderCode;

  @override
  State<VoipCallPage> createState() => _VoipCallPageState();
}

class _VoipCallPageState extends State<VoipCallPage> {
  late String _currentMode;
  bool _isConnecting = true;
  int _durationSeconds = 0;
  bool _isMuted = false;
  bool _isSpeaker = false;

  Timer? _callTimer;

  bool get _isWorker => widget.role == 'worker';

  @override
  void initState() {
    super.initState();
    _currentMode = widget.mode;

    if (_currentMode == 'callout') {
      _startOutgoingFlow();
    } else {
      _startIncomingTimeout();
    }
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    super.dispose();
  }

  void _startOutgoingFlow() {
    _isConnecting = true;
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (timer.tick >= 2 && _isConnecting) {
        setState(() {
          _isConnecting = false;
          _durationSeconds = 0;
        });
      } else if (!_isConnecting) {
        setState(() {
          _durationSeconds++;
        });
      }
    });
  }

  void _startIncomingTimeout() {
    _callTimer = Timer(const Duration(seconds: 20), () {
      if (!mounted) return;
      _endCall();
    });
  }

  void _acceptCall() {
    _callTimer?.cancel();
    setState(() {
      _currentMode = 'callout';
      _isConnecting = false;
      _durationSeconds = 0;
    });
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _durationSeconds++;
      });
    });
  }

  void _endCall() {
    _callTimer?.cancel();
    if (context.canPop()) {
      context.pop();
    }
  }

  String _formatDuration(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    final defaultPeer = _isWorker ? 'Nguyễn Thị Mai' : 'Trần Văn Hùng';
    final peer = widget.peerName ?? defaultPeer;
    final roleTitle = _isWorker
        ? (isEn ? 'Customer' : 'Khách hàng')
        : (isEn ? 'Technician' : 'Kỹ thuật viên');

    final isCallIn = _currentMode == 'callin';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Large Avatar
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: _isWorker ? AppColors.primary : const Color(0xFFEAF3F8),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(color: AppColors.border, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  peer.isNotEmpty ? peer[0] : 'U',
                  style: GoogleFonts.sourceSans3(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: _isWorker ? AppColors.onPrimary : AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Peer Name
              Text(
                peer,
                style: GoogleFonts.sourceSans3(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              // Role & Order Code
              Text(
                '$roleTitle · ${widget.orderCode}',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              // Call Status / Duration
              if (isCallIn)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text(
                    context.l10n.callIncoming,
                    style: AppTextStyles.titleLg.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                )
              else if (_isConnecting)
                Text(
                  context.l10n.callConnecting,
                  style: AppTextStyles.titleLg.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                )
              else
                Text(
                  _formatDuration(_durationSeconds),
                  style: GoogleFonts.sourceSans3(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: 1.2,
                  ),
                ),
              const SizedBox(height: 24),
              // Compliance & Privacy Recording Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        context.l10n.callRecordingNotice,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8A4E05),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Action controls
              if (isCallIn) ...[
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _endCall,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.full),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          context.l10n.chatDecline,
                          style: AppTextStyles.labelLarge.copyWith(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _acceptCall,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.full),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          context.l10n.callAccept,
                          style: AppTextStyles.labelLarge.copyWith(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCallButton(
                      icon: _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                      label: context.l10n.callMute,
                      isActive: _isMuted,
                      onTap: () => setState(() => _isMuted = !_isMuted),
                    ),
                    _buildCallButton(
                      icon: _isSpeaker ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                      label: context.l10n.callSpeaker,
                      isActive: _isSpeaker,
                      onTap: () => setState(() => _isSpeaker = !_isSpeaker),
                    ),
                    _buildCallButton(
                      icon: Icons.call_end_rounded,
                      label: context.l10n.callEnd,
                      isEndCall: true,
                      onTap: _endCall,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
    bool isEndCall = false,
  }) {
    var bg = AppColors.surface;
    var border = AppColors.border;
    var iconColor = AppColors.textPrimary;

    if (isEndCall) {
      bg = AppColors.error;
      border = AppColors.error;
      iconColor = AppColors.onPrimary;
    } else if (isActive) {
      bg = AppColors.primary;
      border = AppColors.primary;
      iconColor = AppColors.onPrimary;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(AppRadius.full),
              border: Border.all(color: border, width: 1.5),
            ),
            child: Icon(icon, size: 26, color: iconColor),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
