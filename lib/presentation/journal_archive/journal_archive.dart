import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import './widgets/category_filter_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/journal_entry_card_widget.dart';
import './widgets/search_bar_widget.dart';

class JournalArchive extends StatefulWidget {
  const JournalArchive({super.key});

  @override
  State<JournalArchive> createState() => _JournalArchiveState();
}

class _JournalArchiveState extends State<JournalArchive> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;
  bool _hasMoreEntries = true;
  
  // Mock data for journal entries
  List<Map<String, dynamic>> _journalEntries = [];
  List<Map<String, dynamic>> _filteredEntries = [];
  
  @override
  void initState() {
    super.initState();
    _loadInitialEntries();
    
    // Set up scroll listener for pagination
    _scrollController.addListener(_scrollListener);
    
    // Set up search listener with debounce
    _searchController.addListener(_onSearchDebounced);
  }
  
  // Debounce timer for search
  DateTime? _lastSearchTime;
  
  void _onSearchDebounced() {
    final now = DateTime.now();
    _lastSearchTime = now;
    
    // Debounce search by 300ms
    Future.delayed(const Duration(milliseconds: 300), () {
      // Only process if this is still the latest search request
      if (_lastSearchTime == now) {
        setState(() {
          _searchQuery = _searchController.text.trim();
          _filterEntries();
        });
      }
    });
  }
  
  void _scrollListener() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMoreEntries) {
      _loadMoreEntries();
    }
  }
  
  Future<void> _loadInitialEntries() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Load mock data
    final mockEntries = _generateMockEntries(15);
    
    if (mounted) {
      setState(() {
        _journalEntries = mockEntries;
        _filterEntries();
        _isLoading = false;
      });
    }
  }
  
  Future<void> _loadMoreEntries() async {
    if (!_hasMoreEntries) return;
    
    setState(() {
      _isLoading = true;
    });
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Load more mock data
    final moreEntries = _generateMockEntries(10, 
        startId: _journalEntries.length + 1);
    
    // Simulate end of data after 50 entries
    final hasMore = _journalEntries.length + moreEntries.length < 50;
    
    if (mounted) {
      setState(() {
        _journalEntries.addAll(moreEntries);
        _filterEntries();
        _isLoading = false;
        _hasMoreEntries = hasMore;
      });
    }
  }
  
  Future<void> _refreshEntries() async {
    // Reset pagination state
    setState(() {
      _hasMoreEntries = true;
    });
    
    await _loadInitialEntries();
  }
  
  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _filterEntries();
    });
  }
  
  void _filterEntries() {
    _filteredEntries = _journalEntries.where((entry) {
      // Filter by category if not 'All'
      final categoryMatch = _selectedCategory == 'All' || 
          entry['category'] == _selectedCategory;
      
      // Filter by search query if not empty
      final searchMatch = _searchQuery.isEmpty || 
          entry['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          entry['content'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      
      return categoryMatch && searchMatch;
    }).toList();
  }
  
  void _openJournalEntry(Map<String, dynamic> entry) {
    // In a real app, this would navigate to the journal entry detail screen
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening entry: ${entry['title']}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Archive',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home-dashboard');
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBarWidget(
                controller: _searchController,
                onClear: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                    _filterEntries();
                  });
                },
              ),
            ),
            
            // Category Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CategoryFilterWidget(
                selectedCategory: _selectedCategory,
                onCategorySelected: _onCategorySelected,
              ),
            ),
            
            // Journal Entries List
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshEntries,
                color: AppTheme.primary,
                child: _buildEntriesList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEntriesList() {
    if (_journalEntries.isEmpty && _isLoading) {
      // Initial loading state
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (_filteredEntries.isEmpty && !_isLoading) {
      // Empty state
      return EmptyStateWidget(
        searchQuery: _searchQuery,
        selectedCategory: _selectedCategory,
      );
    }
    
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: _filteredEntries.length + (_isLoading && _hasMoreEntries ? 1 : 0),
      itemBuilder: (context, index) {
        // Show loading indicator at the bottom
        if (index == _filteredEntries.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        final entry = _filteredEntries[index];
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: JournalEntryCardWidget(
            entry: entry,
            onTap: () => _openJournalEntry(entry),
          ),
        );
      },
    );
  }
  
  // Helper method to generate mock journal entries
  List<Map<String, dynamic>> _generateMockEntries(int count, {int startId = 1}) {
    final categories = ['Work', 'Meditation', 'Food', 'Travel', 'Emotional', 'Ideas'];
    final now = DateTime.now();
    
    return List.generate(count, (index) {
      final id = startId + index;
      final daysAgo = index + (startId > 1 ? startId * 2 : 0);
      final date = now.subtract(Duration(days: daysAgo % 30, hours: (index * 7) % 24));
      final category = categories[index % categories.length];
      
      return {
        'id': id,
        'title': _getMockTitle(category, id),
        'content': _getMockContent(category, id),
        'category': category,
        'date': date,
        'isFavorite': id % 5 == 0, // Every 5th entry is a favorite
      };
    });
  }
  
  String _getMockTitle(String category, int id) {
    switch (category) {
      case 'Work':
        return 'Project brainstorming session #$id';
      case 'Meditation':
        return 'Morning mindfulness practice #$id';
      case 'Food':
        return 'Trying that new recipe #$id';
      case 'Travel':
        return 'Exploring the city #$id';
      case 'Emotional':
        return 'Reflecting on today\'s feelings #$id';
      case 'Ideas':
        return 'New app concept #$id';
      default:
        return 'Journal entry #$id';
    }
  }
  
  String _getMockContent(String category, int id) {
    switch (category) {
      case 'Work':
        return 'Today we had a productive meeting about the upcoming project. We discussed several key features and assigned tasks to team members. I\'m excited about the direction we\'re taking and the potential impact of our work. Need to follow up with Sarah about the design mockups.';
      case 'Meditation':
        return 'Spent 20 minutes in meditation this morning. Focused on breath awareness and noticed how my thoughts kept drifting to my upcoming presentation. Each time, I gently brought my attention back to my breath. Feeling centered and ready for the day ahead.';
      case 'Food':
        return 'Made that pasta recipe I\'ve been wanting to try. Used fresh basil from the garden and it made such a difference! The garlic bread turned out perfectly crispy. Next time I\'ll add a bit more red pepper flakes for extra kick. Definitely adding this to my regular rotation.';
      case 'Travel':
        return 'Explored the historic district today. The architecture was breathtaking - all those ornate details on buildings hundreds of years old. Found a charming little café tucked away on a side street where I had the best espresso. Made friends with a local who recommended visiting the viewpoint for sunset tomorrow.';
      case 'Emotional':
        return 'Feeling a mix of anxiety and excitement today. The job interview went well, but waiting for their response is nerve-wracking. Practiced some deep breathing when I felt overwhelmed. Reminded myself that whatever happens, I\'ve done my best and there will be other opportunities.';
      case 'Ideas':
        return 'Had an interesting idea for an app that helps people track their plant care routines. Could include features like watering schedules, light requirements, and progress photos. Might be useful to add seasonal care tips and troubleshooting for common issues. Need to research if something similar already exists.';
      default:
        return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';
    }
  }
}