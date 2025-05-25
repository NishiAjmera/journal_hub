import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class SkeletonLoaderWidget extends StatelessWidget {
  final double height;
  final double width;
  final String type;

  const SkeletonLoaderWidget({
    super.key,
    required this.height,
    required this.width,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: type == 'journal' ? _buildJournalSkeleton() : _buildHabitSkeleton(),
    );
  }
  
  Widget _buildJournalSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSkeletonBox(36, 36, BorderRadius.circular(8)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSkeletonBox(80, 14, BorderRadius.circular(4)),
                const SizedBox(height: 4),
                _buildSkeletonBox(60, 12, BorderRadius.circular(4)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSkeletonBox(double.infinity, 18, BorderRadius.circular(4)),
        const SizedBox(height: 8),
        _buildSkeletonBox(double.infinity, 14, BorderRadius.circular(4)),
        const SizedBox(height: 4),
        _buildSkeletonBox(double.infinity * 0.7, 14, BorderRadius.circular(4)),
      ],
    );
  }
  
  Widget _buildHabitSkeleton() {
    return Row(
      children: [
        _buildSkeletonBox(36, 36, BorderRadius.circular(8)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSkeletonBox(120, 18, BorderRadius.circular(4)),
              const SizedBox(height: 8),
              _buildSkeletonBox(80, 14, BorderRadius.circular(4)),
            ],
          ),
        ),
        _buildSkeletonBox(24, 24, BorderRadius.circular(4)),
      ],
    );
  }
  
  Widget _buildSkeletonBox(double width, double height, BorderRadius borderRadius) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: borderRadius,
      ),
    );
  }
}