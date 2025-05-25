import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class HabitCardWidget extends StatelessWidget {
  final int id;
  final String name;
  final int streak;
  final bool completedToday;
  final String category;
  final VoidCallback onToggleCompletion;
  final VoidCallback onTap;

  const HabitCardWidget({
    super.key,
    required this.id,
    required this.name,
    required this.streak,
    required this.completedToday,
    required this.category,
    required this.onToggleCompletion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = AppTheme.getCategoryColor(category);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: _getCategoryIcon(category),
                  color: categoryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'local_fire_department',
                          color: AppTheme.warning,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$streak day streak',
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: completedToday,
                  onChanged: (_) => onToggleCompletion(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'meditation':
        return 'self_improvement';
      case 'food':
        return 'restaurant';
      case 'travel':
        return 'flight';
      case 'work':
        return 'work';
      case 'emotional':
        return 'favorite';
      case 'ideas':
        return 'lightbulb';
      default:
        return 'article';
    }
  }
}