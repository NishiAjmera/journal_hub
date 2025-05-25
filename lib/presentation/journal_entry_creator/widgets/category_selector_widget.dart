import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class CategorySelectorWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const CategorySelectorWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Journal categories with their respective colors
    final List<Map<String, dynamic>> categories = [
      {  "name": 'Work', 'color': AppTheme.work},
      {  "name": 'Meditation', 'color': AppTheme.meditation},
      {  "name": 'Food', 'color': AppTheme.food},
      {  "name": 'Travel', 'color': AppTheme.travel},
      {  "name": 'Emotional', 'color': AppTheme.emotional},
      {  "name": 'Ideas', 'color': AppTheme.ideas},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category *',
          style: AppTheme.lightTheme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedCategory.isNotEmpty ? selectedCategory : null,
          decoration: InputDecoration(
            hintText: 'Select a category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a category';
            }
            return null;
          },
          items: categories.map((category) {
            return DropdownMenuItem<String>(
              value: category['name'],
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: category['color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    category['name'],
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onCategoryChanged(value);
            }
          },
        ),
      ],
    );
  }
}