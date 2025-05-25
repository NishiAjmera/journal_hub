import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final String searchQuery;
  final String selectedCategory;

  const EmptyStateWidget({
    super.key,
    required this.searchQuery,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    String message;
    String subMessage;
    String iconName;
    
    // Determine the appropriate empty state message based on filters
    if (searchQuery.isNotEmpty) {
      message = 'No results found';
      subMessage = 'Try different search terms or filters';
      iconName = 'search_off';
    } else if (selectedCategory != 'All') {
      message = 'No $selectedCategory entries yet';
      subMessage = 'Create your first $selectedCategory journal entry';
      iconName = 'note_add';
    } else {
      message = 'Your journal is empty';
      subMessage = 'Start writing to see entries here';
      iconName = 'book';
    }

    return ListView(
      children: [
        SizedBox(height: 10.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: AppTheme.textTertiary,
                size: 64,
              ),
              SizedBox(height: 3.h),
              Text(
                message,
                style: AppTheme.lightTheme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  subMessage,
                  style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 4.h),
              if (searchQuery.isEmpty)
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/journal-entry-creator');
                  },
                  icon: const CustomIconWidget(
                    iconName: 'add',
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text('Create New Entry'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}