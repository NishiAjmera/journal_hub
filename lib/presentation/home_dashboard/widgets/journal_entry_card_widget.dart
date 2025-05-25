import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_export.dart';

class JournalEntryCardWidget extends StatelessWidget {
  final int id;
  final String title;
  final String content;
  final String category;
  final DateTime date;
  final VoidCallback onTap;

  const JournalEntryCardWidget({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = AppTheme.getCategoryColor(category);
    final String formattedDate = _formatDate(date);
    
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: AppTheme.lightTheme.textTheme.labelMedium!.copyWith(
                            color: categoryColor,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title.isNotEmpty ? title : 'Untitled Entry',
                style: AppTheme.lightTheme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today, ${DateFormat('h:mm a').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${DateFormat('h:mm a').format(date)}';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE, h:mm a').format(date);
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
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