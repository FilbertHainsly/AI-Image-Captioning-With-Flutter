import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Bottom sheet modal for choosing image source (Camera or Gallery).
class SourcePicker extends StatelessWidget {
  final VoidCallback onCameraPicked;
  final VoidCallback onGalleryPicked;

  const SourcePicker({
    super.key,
    required this.onCameraPicked,
    required this.onGalleryPicked,
  });

  /// Show the source picker bottom sheet.
  static void show(
    BuildContext context, {
    required VoidCallback onCamera,
    required VoidCallback onGallery,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => SourcePicker(
        onCameraPicked: () {
          Navigator.pop(context);
          onCamera();
        },
        onGalleryPicked: () {
          Navigator.pop(context);
          onGallery();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: AppTheme.glassBorder, width: 1),
          left: BorderSide(color: AppTheme.glassBorder, width: 1),
          right: BorderSide(color: AppTheme.glassBorder, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: AppTheme.textSecondary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Text(
            "Choose Image Source",
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 8),

          Text(
            "Select where you'd like to pick your image from",
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 28),

          // Options row
          Row(
            children: [
              Expanded(
                child: _SourceOption(
                  icon: Icons.camera_alt_rounded,
                  label: "Camera",
                  subtitle: "Take a photo",
                  gradient: const LinearGradient(
                    colors: [AppTheme.accentPink, Color(0xFFFF6E40)],
                  ),
                  onTap: onCameraPicked,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SourceOption(
                  icon: Icons.photo_library_rounded,
                  label: "Gallery",
                  subtitle: "Choose existing",
                  gradient: AppTheme.primaryGradient,
                  onTap: onGalleryPicked,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onTap;

  const _SourceOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
          decoration: AppTheme.glassCard,
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: (gradient as LinearGradient)
                          .colors
                          .first
                          .withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 14),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
