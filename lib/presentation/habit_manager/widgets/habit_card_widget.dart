import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import './streak_history_widget.dart';

class HabitCardWidget extends StatefulWidget {
  final Map<String, dynamic> habit;
  final Function(String, bool) onCompletionChanged;

  const HabitCardWidget({
    super.key,
    required this.habit,
    required this.onCompletionChanged,
  });

  @override
  State<HabitCardWidget> createState() => _HabitCardWidgetState();
}

class _HabitCardWidgetState extends State<HabitCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  void _handleCheckboxChange(bool? isChecked) {
    if (isChecked == null) return;
    
    // Only animate when checking, not unchecking
    if (isChecked && !widget.habit["completedToday"]) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
    
    widget.onCompletionChanged(widget.habit["id"], isChecked);
  }

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = widget.habit["completedToday"];
    final int streak = widget.habit["streak"];
    final List<bool> history = List<bool>.from(widget.habit["history"]);
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isCompleted
              ? BorderSide(color: AppTheme.success, width: 1.5)
              : BorderSide.none,
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: isCompleted,
                      onChanged: _handleCheckboxChange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  
                  // Habit details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.habit["name"],
                          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                            decoration: isCompleted ? TextDecoration.lineThrough : null,
                            color: isCompleted ? AppTheme.textSecondary : AppTheme.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.habit["description"],
                          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Streak counter
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: streak > 0 ? AppTheme.primary.withAlpha(26) : AppTheme.border.withAlpha(128),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'local_fire_department',
                          color: streak > 0 ? AppTheme.primary : AppTheme.textTertiary,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          streak.toString(),
                          style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                            color: streak > 0 ? AppTheme.primary : AppTheme.textTertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 12),
              
              // 7-day history
              StreakHistoryWidget(history: history),
              
              // Reminder info if enabled
              if (widget.habit["reminderEnabled"])
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'notifications',
                        color: AppTheme.textTertiary,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.habit["reminderTime"],
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}