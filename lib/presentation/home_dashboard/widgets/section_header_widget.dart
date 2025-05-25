import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllPressed;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'See All',
                style: AppTheme.lightTheme.textTheme.labelMedium!.copyWith(
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(width: 4),
              const CustomIconWidget(
                iconName: 'arrow_forward',
                color: AppTheme.primary,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}