import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class StreakHistoryWidget extends StatelessWidget {
  final List<bool> history;
  
  const StreakHistoryWidget({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    // Get the days of the week for the last 7 days
    final today = DateTime.now();
    final dayNames = List.generate(7, (index) {
      final day = today.subtract(Duration(days: index));
      return _getDayName(day.weekday);
    }).reversed.toList();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final isCompleted = history[6 - index]; // Reverse to show oldest to newest
        
        return Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppTheme.success : Colors.transparent,
                border: Border.all(
                  color: isCompleted ? AppTheme.success : AppTheme.border,
                  width: 1.5,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              dayNames[index],
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textTertiary,
              ),
            ),
          ],
        );
      }),
    );
  }
  
  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'M';
      case 2: return 'T';
      case 3: return 'W';
      case 4: return 'T';
      case 5: return 'F';
      case 6: return 'S';
      case 7: return 'S';
      default: return '';
    }
  }
}