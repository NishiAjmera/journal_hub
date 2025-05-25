import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class FormatToolbarWidget extends StatelessWidget {
  final bool isBold;
  final bool isItalic;
  final bool isBulletList;
  final VoidCallback onBoldPressed;
  final VoidCallback onItalicPressed;
  final VoidCallback onBulletListPressed;

  const FormatToolbarWidget({
    super.key,
    required this.isBold,
    required this.isItalic,
    required this.isBulletList,
    required this.onBoldPressed,
    required this.onItalicPressed,
    required this.onBulletListPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildFormatButton(
            context: context,
            icon: 'format_bold',
            isActive: isBold,
            onPressed: onBoldPressed,
            tooltip: 'Bold',
          ),
          _buildFormatButton(
            context: context,
            icon: 'format_italic',
            isActive: isItalic,
            onPressed: onItalicPressed,
            tooltip: 'Italic',
          ),
          _buildFormatButton(
            context: context,
            icon: 'format_list_bulleted',
            isActive: isBulletList,
            onPressed: onBulletListPressed,
            tooltip: 'Bullet List',
          ),
        ],
      ),
    );
  }

  Widget _buildFormatButton({
    required BuildContext context,
    required String icon,
    required bool isActive,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Expanded(
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: isActive
                  ? AppTheme.lightTheme.colorScheme.primaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: icon,
                color: isActive
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}