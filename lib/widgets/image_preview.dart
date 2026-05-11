import 'dart:io';

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Glassmorphic image preview card with rounded corners and shadow.
class ImagePreview extends StatelessWidget {
  final File imageFile;

  const ImagePreview({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      decoration: AppTheme.glassCard,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          imageFile,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
          errorBuilder: (_, error, stackTrace) => Container(
            height: 300,
            color: AppTheme.cardDark,
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.broken_image_rounded,
                      color: AppTheme.textSecondary, size: 48),
                  SizedBox(height: 12),
                  Text(
                    "Failed to load image",
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
