import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onActionPressed;
  final String illustrationType;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onActionPressed,
    required this.illustrationType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withAlpha(128),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIllustration(),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onActionPressed,
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
  
  Widget _buildIllustration() {
    String iconName;
    Color iconColor;
    
    if (illustrationType == 'journal') {
      iconName = 'book';
      iconColor = AppTheme.primary;
    } else if (illustrationType == 'habits') {
      iconName = 'repeat';
      iconColor = AppTheme.meditation;
    } else {
      iconName = 'add_circle';
      iconColor = AppTheme.primary;
    }
    
    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        color: iconColor.withAlpha(26),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: CustomIconWidget(
          iconName: iconName,
          color: iconColor,
          size: 12.w,
        ),
      ),
    );
  }
}