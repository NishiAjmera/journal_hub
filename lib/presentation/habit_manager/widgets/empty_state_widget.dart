import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onAddHabit;
  
  const EmptyStateWidget({
    super.key,
    required this.onAddHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: AppTheme.primary.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'event_repeat',
                  color: AppTheme.primary,
                  size: 25.w,
                ),
              ),
            ),
            
            SizedBox(height: 32),
            
            // Title
            Text(
              'No Habits Yet',
              style: AppTheme.lightTheme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 16),
            
            // Description
            Text(
              'Start building positive habits by creating your first habit tracker. Track your progress and build streaks to stay motivated.',
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 32),
            
            // Add habit button
            SizedBox(
              width: 80.w,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: onAddHabit,
                icon: const CustomIconWidget(
                  iconName: 'add',
                  color: Colors.white,
                  size: 24,
                ),
                label: Text('Add First Habit'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}