import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_selector_widget.dart';
import './widgets/format_toolbar_widget.dart';
import './widgets/journal_content_field_widget.dart';

class JournalEntryCreator extends StatefulWidget {
  const JournalEntryCreator({super.key});

  @override
  State<JournalEntryCreator> createState() => _JournalEntryCreatorState();
}

class _JournalEntryCreatorState extends State<JournalEntryCreator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  
  String _selectedCategory = '';
  bool _hasChanges = false;
  bool _isSaving = false;
  DateTime? _lastAutoSave;
  
  // Text formatting states
  bool _isBold = false;
  bool _isItalic = false;
  bool _isBulletList = false;

  @override
  void initState() {
    super.initState();
    _loadDraft();
    _setupAutoSave();
    
    // Listen for changes to track unsaved content
    _titleController.addListener(_onContentChanged);
    _contentController.addListener(_onContentChanged);
    
    // Focus on content field automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  void _onContentChanged() {
    if (!_hasChanges && (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty)) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  void _setupAutoSave() {
    // Set up timer for auto-saving every 30 seconds
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        _autoSaveDraft();
        _setupAutoSave(); // Schedule next auto-save
      }
    });
  }

  Future<void> _loadDraft() async {
    // Simulate loading draft from local storage
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Mock data for demonstration
    final Map<String, dynamic> draftData = {
      'title': '',
      'content': '',
      'category': '',
      'lastSaved': DateTime.now().toString(),
    };
    
    if (mounted) {
      setState(() {
        _titleController.text = draftData['title'];
        _contentController.text = draftData['content'];
        _selectedCategory = draftData['category'];
        _lastAutoSave = DateTime.tryParse(draftData['lastSaved']);
        _hasChanges = false;
      });
    }
  }

  Future<void> _autoSaveDraft() async {
    if (!_hasChanges) return;
    
    // Simulate saving to local storage
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (mounted) {
      setState(() {
        _lastAutoSave = DateTime.now();
      });
    }
  }

  Future<void> _saveEntry() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSaving = true;
      });
      
      // Simulate saving to storage
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        setState(() {
          _isSaving = false;
          _hasChanges = false;
        });
        
        Fluttertoast.showToast(
          msg: "Journal entry saved successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppTheme.success,
          textColor: Colors.white,
        );
        
        // Navigate back or to dashboard
        if (mounted) {
          Navigator.of(context).pushNamed('/home-dashboard');
        }
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;
    
    // Show confirmation dialog if there are unsaved changes
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Discard changes?',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Text(
          'You have unsaved changes. Are you sure you want to discard them?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.lightTheme.colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
            ),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
      _hasChanges = true;
    });
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
    });
    // In a real app, this would apply formatting to the selected text
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
    // In a real app, this would apply formatting to the selected text
  }

  void _toggleBulletList() {
    setState(() {
      _isBulletList = !_isBulletList;
    });
    // In a real app, this would apply formatting to the selected text
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'New Journal Entry',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const CustomIconWidget(
              iconName: 'arrow_back',
              color: AppTheme.textPrimary,
              size: 24,
            ),
            onPressed: () async {
              if (await _onWillPop()) {
                if (mounted) Navigator.of(context).pop();
              }
            },
          ),
          actions: [
            if (_lastAutoSave != null)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    'Auto-saved ${_getTimeAgo(_lastAutoSave!)}',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                ),
              ),
          ],
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Selector
                        CategorySelectorWidget(
                          selectedCategory: _selectedCategory,
                          onCategoryChanged: _onCategoryChanged,
                        ),
                        
                        SizedBox(height: 3.h),
                        
                        // Title Field
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: 'Title (Optional)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          maxLength: 50,
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                        ),
                        
                        SizedBox(height: 2.h),
                        
                        // Formatting Toolbar
                        FormatToolbarWidget(
                          isBold: _isBold,
                          isItalic: _isItalic,
                          isBulletList: _isBulletList,
                          onBoldPressed: _toggleBold,
                          onItalicPressed: _toggleItalic,
                          onBulletListPressed: _toggleBulletList,
                        ),
                        
                        SizedBox(height: 2.h),
                        
                        // Content Field
                        JournalContentFieldWidget(
                          controller: _contentController,
                          isBold: _isBold,
                          isItalic: _isItalic,
                          isBulletList: _isBulletList,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Save Button (Fixed at bottom)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(13),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveEntry,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save Journal Entry'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}