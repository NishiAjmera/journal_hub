import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class HabitSkeletonWidget extends StatelessWidget {
  const HabitSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox skeleton
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.border.withAlpha(179),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 12),
                
                // Habit details skeleton
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppTheme.border.withAlpha(179),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 200,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppTheme.border.withAlpha(128),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Streak counter skeleton
                Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppTheme.border.withAlpha(128),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // 7-day history skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                return Column(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.border.withAlpha(153),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.border.withAlpha(128),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                );
              }),
            ),
            
            SizedBox(height: 8),
            
            // Reminder info skeleton
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppTheme.border.withAlpha(128),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  width: 60,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppTheme.border.withAlpha(128),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}