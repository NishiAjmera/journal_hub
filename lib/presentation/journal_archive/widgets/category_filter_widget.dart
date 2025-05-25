import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class CategoryFilterWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilterWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    // Journal categories with their respective colors
    final List<Map<String, dynamic>> categories = [
      {  "name": 'All', 'color': AppTheme.primary},
      {  "name": 'Work', 'color': AppTheme.work},
      {  "name": 'Meditation', 'color': AppTheme.meditation},
      {  "name": 'Food', 'color': AppTheme.food},
      {  "name": 'Travel', 'color': AppTheme.travel},
      {  "name": 'Emotional', 'color': AppTheme.emotional},
      {  "name": 'Ideas', 'color': AppTheme.ideas},
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category['name'];
          
          return Padding(
            padding: EdgeInsets.only(
              right: 8.0,
              left: index == 0 ? 0 : 0,
            ),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (category['name'] != 'All')
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: category['color'],
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(
                    category['name'],
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.white 
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onCategorySelected(category['name']);
                }
              },
              backgroundColor: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
              selectedColor: category['color'],
              checkmarkColor: Colors.white,
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        },
      ),
    );
  }
}