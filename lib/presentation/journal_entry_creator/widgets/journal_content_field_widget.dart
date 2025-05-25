import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class JournalContentFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isBold;
  final bool isItalic;
  final bool isBulletList;

  const JournalContentFieldWidget({
    super.key,
    required this.controller,
    required this.isBold,
    required this.isItalic,
    required this.isBulletList,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, we would apply the formatting to the text
    // Here we're just showing the field with different styles based on the formatting options
    
    TextStyle contentStyle = AppTheme.lightTheme.textTheme.bodyLarge!;
    
    if (isBold) {
      contentStyle = contentStyle.copyWith(fontWeight: FontWeight.bold);
    }
    
    if (isItalic) {
      contentStyle = contentStyle.copyWith(fontStyle: FontStyle.italic);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Journal Entry *',
          style: AppTheme.lightTheme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: 15,
            maxLength: 5000,
            style: contentStyle,
            decoration: InputDecoration(
              hintText: 'Write your thoughts here...',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              counterStyle: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some content for your journal';
              }
              return null;
            },
          ),
        ),
        if (isBulletList)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Bullet list formatting will be applied to selected text',
              style: AppTheme.lightTheme.textTheme.bodySmall!.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}