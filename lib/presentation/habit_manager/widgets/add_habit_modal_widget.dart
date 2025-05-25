import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class AddHabitModalWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onHabitAdded;
  
  const AddHabitModalWidget({
    super.key,
    required this.onHabitAdded,
  });

  @override
  State<AddHabitModalWidget> createState() => _AddHabitModalWidgetState();
}

class _AddHabitModalWidgetState extends State<AddHabitModalWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  bool _reminderEnabled = false;
  TimeOfDay _reminderTime = TimeOfDay(hour: 20, minute: 0); // Default 8:00 PM
  
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppTheme.lightTheme.colorScheme.surface,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }
  
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newHabit = {
        "name": _nameController.text.trim(),
        "description": _descriptionController.text.trim(),
        "reminderEnabled": _reminderEnabled,
        "reminderTime": _reminderEnabled ? _formatTimeOfDay(_reminderTime) : null,
      };
      
      widget.onHabitAdded(newHabit);
      Navigator.pop(context);
    }
  }
  
  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    // Calculate bottom padding to avoid keyboard
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      padding: EdgeInsets.only(
        bottom: bottomPadding > 0 ? bottomPadding : 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create New Habit',
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.textPrimary,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: 24),
              
              // Name field
              Text(
                'Habit Name *',
                style: AppTheme.lightTheme.textTheme.labelLarge,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter habit name',
                  counterText: '',
                ),
                maxLength: 30,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 16),
              
              // Description field
              Text(
                'Description (Optional)',
                style: AppTheme.lightTheme.textTheme.labelLarge,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter a short description',
                  counterText: '',
                ),
                maxLength: 100,
                maxLines: 2,
              ),
              
              SizedBox(height: 24),
              
              // Reminder toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Set Reminder',
                    style: AppTheme.lightTheme.textTheme.labelLarge,
                  ),
                  Switch(
                    value: _reminderEnabled,
                    onChanged: (value) {
                      setState(() {
                        _reminderEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              
              // Time picker (only visible if reminder is enabled)
              if (_reminderEnabled) ...[
                SizedBox(height: 16),
                InkWell(
                  onTap: _selectTime,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reminder Time',
                          style: AppTheme.lightTheme.textTheme.bodyLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              _formatTimeOfDay(_reminderTime),
                              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 8),
                            const CustomIconWidget(
                              iconName: 'access_time',
                              color: AppTheme.primary,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              
              SizedBox(height: 32),
              
              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Create Habit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}