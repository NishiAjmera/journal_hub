import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/add_habit_modal_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/habit_card_widget.dart';
import './widgets/habit_skeleton_widget.dart';

class HabitManager extends StatefulWidget {
  const HabitManager({super.key});

  @override
  State<HabitManager> createState() => _HabitManagerState();
}

class _HabitManagerState extends State<HabitManager> {
  bool _isLoading = true;
  bool _isRefreshing = false;
  List<Map<String, dynamic>> _habits = [];

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Get shared preferences
      final prefs = await SharedPreferences.getInstance();
      
      // Load habits
      final habitsJson = prefs.getString('habits');
      if (habitsJson != null) {
        final List<dynamic> decoded = jsonDecode(habitsJson);
        if (mounted) {
          setState(() {
            _habits = decoded.map((h) => Map<String, dynamic>.from(h)).toList();
            _isLoading = false;
          });
        }
      } else {
        // Load mock data if no saved data exists
        if (mounted) {
          setState(() {
            _habits = _getMockHabits();
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      // Load mock data on error
      if (mounted) {
        setState(() {
          _habits = _getMockHabits();
          _isLoading = false;
        });
      }
      print('Error loading habits: $e');
    }
  }

  Future<void> _refreshHabits() async {
    if (_isRefreshing) return;
    
    setState(() {
      _isRefreshing = true;
    });
    
    try {
      // Reload from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final habitsJson = prefs.getString('habits');
      
      if (mounted) {
        setState(() {
          if (habitsJson != null) {
            final List<dynamic> decoded = jsonDecode(habitsJson);
            _habits = decoded.map((h) => Map<String, dynamic>.from(h)).toList();
          } else {
            _habits = _getMockHabits();
          }
          _isRefreshing = false;
        });
      }
      
      Fluttertoast.showToast(
        msg: "Habits refreshed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
      print('Error refreshing habits: $e');
    }
  }

  List<Map<String, dynamic>> _getMockHabits() {
    return [
      {
        "id": "1",
        "name": "Morning Meditation",
        "description": "10 minutes of mindfulness to start the day",
        "streak": 5,
        "history": [true, true, true, true, true, false, false],
        "reminderEnabled": true,
        "reminderTime": "07:00 AM",
        "completedToday": false,
      },
      {
        "id": "2",
        "name": "Daily Journal",
        "description": "Write down thoughts and reflections",
        "streak": 12,
        "history": [true, true, true, true, true, true, true],
        "reminderEnabled": true,
        "reminderTime": "09:00 PM",
        "completedToday": true,
      },
      {
        "id": "3",
        "name": "Drink Water",
        "description": "8 glasses of water throughout the day",
        "streak": 3,
        "history": [true, true, true, false, false, true, false],
        "reminderEnabled": false,
        "reminderTime": null,
        "completedToday": false,
      },
      {
        "id": "4",
        "name": "Read a Book",
        "description": "Read at least 20 pages",
        "streak": 0,
        "history": [false, false, false, true, false, false, false],
        "reminderEnabled": true,
        "reminderTime": "08:30 PM",
        "completedToday": false,
      },
    ];
  }

  void _showAddHabitModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddHabitModalWidget(
        onHabitAdded: _handleHabitAdded,
      ),
    );
  }

  void _handleHabitAdded(Map<String, dynamic> newHabit) async {
    try {
      // Generate a unique ID based on timestamp
      final String id = DateTime.now().millisecondsSinceEpoch.toString();
      
      final habitToAdd = {
        ...newHabit,
        "id": id,
        "streak": 0,
        "history": List.filled(7, false),
        "completedToday": false,
      };
      
      setState(() {
        _habits.add(habitToAdd);
      });
      
      // Save to shared preferences
      await _saveHabits();
      
      Fluttertoast.showToast(
        msg: "New habit created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.success,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to create habit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.error,
        textColor: Colors.white,
      );
      print('Error adding habit: $e');
    }
  }
  
  Future<void> _saveHabits() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('habits', jsonEncode(_habits));
    } catch (e) {
      print('Error saving habits: $e');
    }
  }

  void _handleHabitCompletion(String habitId, bool isCompleted) async {
    setState(() {
      final habitIndex = _habits.indexWhere((habit) => habit["id"] == habitId);
      if (habitIndex != -1) {
        final habit = _habits[habitIndex];
        
        // Update completion status
        habit["completedToday"] = isCompleted;
        
        // Update streak and history if completed
        if (isCompleted) {
          habit["streak"] = (habit["streak"] as int) + 1;
          final history = List<bool>.from(habit["history"]);
          history[0] = true; // Today's status (first position in our mock data)
          habit["history"] = history;
        } else {
          // If unchecking, reduce streak
          habit["streak"] = (habit["streak"] as int) - 1;
          if (habit["streak"] < 0) {
            habit["streak"] = 0;
          }
          final history = List<bool>.from(habit["history"]);
          history[0] = false;
          habit["history"] = history;
        }
        
        _habits[habitIndex] = habit;
      }
    });
    
    // Save changes to shared preferences
    await _saveHabits();
  }

  void _handleHabitDismissed(String habitId, DismissDirection direction) async {
    // Get the habit before removing it
    final habit = _habits.firstWhere((h) => h["id"] == habitId);
    final habitName = habit["name"];
    
    // Remove the habit
    setState(() {
      _habits.removeWhere((h) => h["id"] == habitId);
    });
    
    // Save changes to shared preferences
    await _saveHabits();
    
    // Show different messages based on direction
    final action = direction == DismissDirection.endToStart ? "deleted" : "archived";
    
    // Show toast with undo option
    Fluttertoast.showToast(
      msg: "Habit $action",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.textPrimary,
      textColor: Colors.white,
    );
    
    // Show snackbar with undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$habitName has been $action'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () async {
            setState(() {
              _habits.add(habit);
              // Sort habits to maintain order
              _habits.sort((a, b) => a["id"].toString().compareTo(b["id"].toString()));
            });
            
            // Save changes to shared preferences
            await _saveHabits();
          },
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
          bottom: 10.h,
          left: 4.w,
          right: 4.w,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return to home dashboard with result to trigger refresh
        Navigator.pushNamed(context, '/home-dashboard', arguments: true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Habit Manager',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const CustomIconWidget(
              iconName: 'arrow_back',
              color: AppTheme.textPrimary,
              size: 24,
            ),
            onPressed: () {
              // Return to home dashboard with result to trigger refresh
              Navigator.pushNamed(context, '/home-dashboard', arguments: true);
            },
          ),
          actions: [
            IconButton(
              icon: const CustomIconWidget(
                iconName: 'refresh',
                color: AppTheme.textPrimary,
                size: 24,
              ),
              onPressed: _refreshHabits,
            ),
          ],
        ),
        body: _isLoading
            ? _buildLoadingState()
            : _habits.isEmpty
                ? EmptyStateWidget(onAddHabit: _showAddHabitModal)
                : _buildHabitList(),
        floatingActionButton: _habits.isEmpty
            ? null
            : FloatingActionButton(
                onPressed: _showAddHabitModal,
                child: const CustomIconWidget(
                  iconName: 'add',
                  color: Colors.white,
                  size: 24,
                ),
              ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) => const HabitSkeletonWidget(),
    );
  }

  Widget _buildHabitList() {
    return RefreshIndicator(
      onRefresh: _refreshHabits,
      color: AppTheme.primary,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          
          return Dismissible(
            key: Key(habit["id"]),
            background: _buildDismissibleBackground(DismissDirection.startToEnd),
            secondaryBackground: _buildDismissibleBackground(DismissDirection.endToStart),
            confirmDismiss: (direction) async {
              // Show confirmation dialog
              return await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    direction == DismissDirection.endToStart
                        ? 'Delete Habit'
                        : 'Archive Habit',
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  content: Text(
                    direction == DismissDirection.endToStart
                        ? 'Are you sure you want to delete this habit? This action cannot be undone.'
                        : 'Are you sure you want to archive this habit? You can restore it later.',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: direction == DismissDirection.endToStart
                            ? AppTheme.error
                            : AppTheme.primary,
                      ),
                      child: Text(
                        direction == DismissDirection.endToStart
                            ? 'Delete'
                            : 'Archive',
                      ),
                    ),
                  ],
                ),
              ) ?? false;
            },
            onDismissed: (direction) {
              _handleHabitDismissed(habit["id"], direction);
            },
            child: HabitCardWidget(
              habit: habit,
              onCompletionChanged: _handleHabitCompletion,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDismissibleBackground(DismissDirection direction) {
    final isDelete = direction == DismissDirection.endToStart;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isDelete ? AppTheme.error : AppTheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: isDelete ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isDelete)
            const CustomIconWidget(
              iconName: 'archive',
              color: Colors.white,
              size: 24,
            ),
          if (!isDelete) SizedBox(width: 8),
          Text(
            isDelete ? 'Delete' : 'Archive',
            style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          if (isDelete) SizedBox(width: 8),
          if (isDelete)
            const CustomIconWidget(
              iconName: 'delete',
              color: Colors.white,
              size: 24,
            ),
        ],
      ),
    );
  }
}