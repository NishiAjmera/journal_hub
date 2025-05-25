import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_export.dart';

class JournalEntryCardWidget extends StatelessWidget {
  final Map<String, dynamic> entry;
  final VoidCallback onTap;

  const JournalEntryCardWidget({
    super.key,
    required this.entry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final category = entry['category'] as String;
    final date = entry['date'] as DateTime;
    final isFavorite = entry['isFavorite'] as bool;
    
    // Format date
    final formattedDate = DateFormat('MMM d, yyyy').format(date);
    final formattedTime = DateFormat('h:mm a').format(date);
    
    // Get category color
    final categoryColor = AppTheme.getCategoryColor(category);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Date, Category, and Favorite
              Row(
                children: [
                  // Category indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: categoryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: categoryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category,
                          style: AppTheme.lightTheme.textTheme.labelSmall!.copyWith(
                            color: categoryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 8),
                  
                  // Date
                  Expanded(
                    child: Text(
                      '$formattedDate at $formattedTime',
                      style: AppTheme.lightTheme.textTheme.bodySmall!.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ),
                  
                  // Favorite indicator
                  if (isFavorite)
                    const CustomIconWidget(
                      iconName: 'star',
                      color: AppTheme.warning,
                      size: 18,
                    ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Title
              Text(
                entry['title'],
                style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 8),
              
              // Content preview
              Text(
                entry['content'],
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 12),
              
              // Footer with read more indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Read more',
                    style: AppTheme.lightTheme.textTheme.labelSmall!.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w600,
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
            ],
          ),
        ),
      ),
    );
  }
}