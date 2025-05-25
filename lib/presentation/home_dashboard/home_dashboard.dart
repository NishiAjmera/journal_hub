import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_state_widget.dart';
import './widgets/habit_card_widget.dart';
import './widgets/journal_entry_card_widget.dart';
import './widgets/section_header_widget.dart';
import './widgets/skeleton_loader_widget.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  bool _isLoading = true;
  bool _hasJournalEntries = false;
  bool _hasHabits = false;
  
  // Journal entries data
  final List<Map<String, dynamic>> _journalEntries = [];
  
  // Habits data
  final List<Map<String, dynamic>> _habits = [];
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    
    // Load saved data from SharedPreferences
    await _loadSavedData();
    
    setState(() {
      _isLoading = false;
      _hasJournalEntries = _journalEntries.isNotEmpty;
      _hasHabits = _habits.isNotEmpty;
    });
  }
  
  Future<void> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load journal entries
      final journalEntriesJson = prefs.getString('journal_entries');
      if (journalEntriesJson != null) {
        final List<dynamic> decoded = jsonDecode(journalEntriesJson);
        _journalEntries.clear();
        for (var entry in decoded) {
          // Convert string date back to DateTime
          if (entry['date'] is String) {
            entry['date'] = DateTime.parse(entry['date']);
          }
          _journalEntries.add(Map<String, dynamic>.from(entry));
        }
      } else {
        // Load mock data if no saved data exists
        _loadMockJournalData();
      }
      
      // Load habits
      final habitsJson = prefs.getString('habits');
      if (habitsJson != null) {
        final List<dynamic> decoded = jsonDecode(habitsJson);
        _habits.clear();
        for (var habit in decoded) {
          _habits.add(Map<String, dynamic>.from(habit));
        }
      } else {
        // Load mock data if no saved data exists
        _loadMockHabitData();
      }
    } catch (e) {
      // If there's an error, load mock data
      _loadMockJournalData();
      _loadMockHabitData();
      
      print('Error loading data: $e');
    }
  }
  
  void _loadMockJournalData() {
    _journalEntries.clear();
    _journalEntries.addAll([
      {
        "id": 1,
        "title": "Morning Meditation Session",
        "content": "Today I practiced mindfulness meditation for 20 minutes. I focused on my breath and observed my thoughts without judgment. I felt much calmer and centered afterward.",
        "category": "Meditation",
        "date": DateTime.now().subtract(const Duration(hours: 5)),
      },
      {
        "id": 2,
        "title": "Client Meeting Notes",
        "content": "Had a productive meeting with the marketing team. We discussed the upcoming campaign strategy and assigned tasks. Need to follow up with Sarah about the design assets by Friday.",
        "category": "Work",
        "date": DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        "id": 3,
        "title": "New Recipe: Avocado Toast",
        "content": "Tried a new avocado toast recipe with cherry tomatoes, feta cheese, and a drizzle of olive oil. It was delicious and took only 10 minutes to prepare. Perfect for a quick breakfast!",
        "category": "Food",
        "date": DateTime.now().subtract(const Duration(days: 2)),
      },
    ]);
  }
  
  void _loadMockHabitData() {
    _habits.clear();
    _habits.addAll([
      {
        "id": 1,
        "name": "Morning Meditation",
        "streak": 7,
        "completedToday": true,
        "category": "Meditation",
      },
      {
        "id": 2,
        "name": "Read 30 Minutes",
        "streak": 12,
        "completedToday": false,
        "category": "Ideas",
      },
      {
        "id": 3,
        "name": "Drink 8 Glasses of Water",
        "streak": 5,
        "completedToday": true,
        "category": "Food",
      },
      {
        "id": 4,
        "name": "Evening Reflection",
        "streak": 21,
        "completedToday": false,
        "category": "Emotional",
      },
      {
        "id": 5,
        "name": "Weekly Planning",
        "streak": 4,
        "completedToday": true,
        "category": "Work",
      },
    ]);
  }
  
  Future<void> _onRefresh() async {
    await _loadData();
  }
  
  void _navigateToJournalEntryCreator() async {
    final result = await Navigator.pushNamed(context, '/journal-entry-creator');
    if (result == true) {
      // Reload data if a journal entry was created
      _loadData();
      Fluttertoast.showToast(
        msg: "Journal entry added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.success,
        textColor: Colors.white,
      );
    }
  }
  
  void _navigateToJournalArchive() {
    Navigator.pushNamed(context, '/journal-archive');
  }
  
  void _navigateToHabitManager() async {
    final result = await Navigator.pushNamed(context, '/habit-manager');
    if (result == true) {
      // Reload data if habits were updated
      _loadData();
      Fluttertoast.showToast(
        msg: "Habits updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.success,
        textColor: Colors.white,
      );
    }
  }
  
  void _toggleHabitCompletion(int habitId) async {
    setState(() {
      final habitIndex = _habits.indexWhere((habit) => habit["id"] == habitId);
      if (habitIndex != -1) {
        _habits[habitIndex]["completedToday"] = !_habits[habitIndex]["completedToday"];
        
        // Update streak
        if (_habits[habitIndex]["completedToday"]) {
          _habits[habitIndex]["streak"] = (_habits[habitIndex]["streak"] as int) + 1;
        } else {
          _habits[habitIndex]["streak"] = (_habits[habitIndex]["streak"] as int) - 1;
          if (_habits[habitIndex]["streak"] < 0) {
            _habits[habitIndex]["streak"] = 0;
          }
        }
      }
    });
    
    // Save updated habits
    await _saveHabits();
  }
  
  Future<void> _saveHabits() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert habits to JSON-serializable format
      final List<Map<String, dynamic>> serializableHabits = _habits.map((habit) {
        final Map<String, dynamic> copy = Map<String, dynamic>.from(habit);
        return copy;
      }).toList();
      
      await prefs.setString('habits', jsonEncode(serializableHabits));
    } catch (e) {
      print('Error saving habits: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Hub',
          style: AppTheme.lightTheme.textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const CustomIconWidget(
              iconName: 'search',
              color: AppTheme.textPrimary,
              size: 24,
            ),
            onPressed: () {
              // Search functionality would go here
            },
          ),
          IconButton(
            icon: const CustomIconWidget(
              iconName: 'settings',
              color: AppTheme.textPrimary,
              size: 24,
            ),
            onPressed: () {
              // Settings functionality would go here
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppTheme.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Journal Section
              SectionHeaderWidget(
                title: 'Journal',
                onSeeAllPressed: _navigateToJournalArchive,
              ),
              SizedBox(height: 2.h),
              
              if (_isLoading)
                _buildJournalSkeletonLoader()
              else if (_hasJournalEntries)
                _buildJournalEntries()
              else
                EmptyStateWidget(
                  title: 'No Journal Entries Yet',
                  message: 'Start capturing your thoughts, ideas, and experiences.',
                  actionLabel: 'Create First Entry',
                  onActionPressed: _navigateToJournalEntryCreator,
                  illustrationType: 'journal',
                ),
              
              SizedBox(height: 4.h),
              
              // Habits Section
              SectionHeaderWidget(
                title: 'Habits',
                onSeeAllPressed: _navigateToHabitManager,
              ),
              SizedBox(height: 2.h),
              
              if (_isLoading)
                _buildHabitsSkeletonLoader()
              else if (_hasHabits)
                _buildHabits()
              else
                EmptyStateWidget(
                  title: 'No Habits Tracked Yet',
                  message: 'Create habits to build consistency and track your progress.',
                  actionLabel: 'Create First Habit',
                  onActionPressed: _navigateToHabitManager,
                  illustrationType: 'habits',
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToJournalEntryCreator,
        tooltip: 'Create New Journal Entry',
        child: const CustomIconWidget(
          iconName: 'add',
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
  
  Widget _buildJournalEntries() {
    return Column(
      children: _journalEntries.take(3).map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: JournalEntryCardWidget(
            id: entry["id"],
            title: entry["title"],
            content: entry["content"],
            category: entry["category"],
            date: entry["date"],
            onTap: () {
              // Navigate to journal entry detail or edit screen
              _navigateToJournalEntryCreator();
            },
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildHabits() {
    return Column(
      children: _habits.take(5).map((habit) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: HabitCardWidget(
            id: habit["id"],
            name: habit["name"],
            streak: habit["streak"],
            completedToday: habit["completedToday"],
            category: habit["category"],
            onToggleCompletion: () => _toggleHabitCompletion(habit["id"]),
            onTap: () {
              // Navigate to habit detail or edit screen
              _navigateToHabitManager();
            },
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildJournalSkeletonLoader() {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SkeletonLoaderWidget(
            height: 120,
            width: double.infinity,
            type: 'journal',
          ),
        );
      }),
    );
  }
  
  Widget _buildHabitsSkeletonLoader() {
    return Column(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SkeletonLoaderWidget(
            height: 80,
            width: double.infinity,
            type: 'habit',
          ),
        );
      }),
    );
  }
}