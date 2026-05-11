import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

/// Card for displaying the AI-generated caption with copy functionality.
class CaptionCard extends StatelessWidget {
  final String caption;
  final bool isLoading;
  final bool isError;

  const CaptionCard({
    super.key,
    required this.caption,
    this.isLoading = false,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildShimmer();
    }

    if (caption.isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimatedOpacity(
      opacity: caption.isNotEmpty ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: AppTheme.glassCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: isError
                        ? const LinearGradient(
                            colors: [AppTheme.errorRed, Color(0xFFFF1744)])
                        : AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isError
                        ? Icons.error_outline_rounded
                        : Icons.auto_awesome_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  isError ? "Error" : "AI Caption",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                if (!isError)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: caption));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Icon(Icons.check_circle_rounded,
                                    color: AppTheme.successGreen, size: 20),
                                SizedBox(width: 10),
                                Text("Caption copied to clipboard!"),
                              ],
                            ),
                            backgroundColor: AppTheme.cardDark,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.glassBackground,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppTheme.glassBorder, width: 1),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.copy_rounded,
                                size: 14, color: AppTheme.textSecondary),
                            SizedBox(width: 6),
                            Text(
                              "Copy",
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Divider
            Container(
              height: 1,
              color: AppTheme.glassBorder,
            ),

            const SizedBox(height: 16),

            // Caption text
            SelectableText(
              caption,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isError ? AppTheme.errorRed : AppTheme.textPrimary,
                    height: 1.7,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: AppTheme.cardDark,
                highlightColor: AppTheme.surfaceDark,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppTheme.cardDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Shimmer.fromColors(
                baseColor: AppTheme.cardDark,
                highlightColor: AppTheme.surfaceDark,
                child: Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppTheme.cardDark,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: AppTheme.glassBorder),
          const SizedBox(height: 16),
          // Text lines shimmer
          ...List.generate(
            4,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Shimmer.fromColors(
                baseColor: AppTheme.cardDark,
                highlightColor: AppTheme.surfaceDark,
                child: Container(
                  width: i == 3 ? 180 : double.infinity,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppTheme.cardDark,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
