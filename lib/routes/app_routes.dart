import 'package:flutter/material.dart';
import '../presentation/journal_entry_creator/journal_entry_creator.dart';
import '../presentation/journal_archive/journal_archive.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/habit_manager/habit_manager.dart';

class AppRoutes {
  static const String initial = '/';
  static const String journalEntryCreator = '/journal-entry-creator';
  static const String journalArchive = '/journal-archive';
  static const String homeDashboard = '/home-dashboard';
  static const String habitManager = '/habit-manager';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const HomeDashboard(), // Set home dashboard as initial route
    journalEntryCreator: (context) => const JournalEntryCreator(),
    journalArchive: (context) => const JournalArchive(),
    homeDashboard: (context) => const HomeDashboard(),
    habitManager: (context) => const HabitManager(),
  };
}