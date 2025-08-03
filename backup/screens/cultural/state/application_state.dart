import 'package:flutter/material.dart';

/// Application state management for Cultural Ambassador Application
class ApplicationState extends ChangeNotifier {
  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController languagesController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController motivationController = TextEditingController();

  // Application state
  bool _isSubmitting = false;
  int _currentStep = 0;

  // Cultural expertise selections
  final List<String> _selectedExpertise = [];
  final List<String> _selectedLanguages = [];
  final List<String> _availabilityDays = [];

  // Static data
  final List<Map<String, dynamic>> culturalExpertise = [
    {'id': 'traditional_cuisine', 'name': 'Traditional Cuisine', 'icon': '🍽️'},
    {'id': 'historical_sites', 'name': 'Historical Sites', 'icon': '🏛️'},
    {'id': 'local_arts', 'name': 'Local Arts & Crafts', 'icon': '🎨'},
    {'id': 'music_dance', 'name': 'Music & Dance', 'icon': '🎵'},
    {'id': 'religious_culture', 'name': 'Religious Culture', 'icon': '🕌'},
    {'id': 'berber_culture', 'name': 'Berber Culture', 'icon': '🏔️'},
    {'id': 'market_souks', 'name': 'Markets & Souks', 'icon': '🛒'},
    {'id': 'desert_experiences', 'name': 'Desert Experiences', 'icon': '🐪'},
  ];

  final List<String> moroccanLanguages = [
    'Arabic',
    'Berber/Tamazight',
    'French',
    'English',
    'Spanish',
    'German',
    'Italian',
    'Dutch'
  ];

  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  // Getters
  bool get isSubmitting => _isSubmitting;
  int get currentStep => _currentStep;
  List<String> get selectedExpertise => List.unmodifiable(_selectedExpertise);
  List<String> get selectedLanguages => List.unmodifiable(_selectedLanguages);
  List<String> get availabilityDays => List.unmodifiable(_availabilityDays);

  // Setters
  set isSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  set currentStep(int value) {
    _currentStep = value;
    notifyListeners();
  }

  // Expertise management
  void toggleExpertise(String expertiseId) {
    if (_selectedExpertise.contains(expertiseId)) {
      _selectedExpertise.remove(expertiseId);
    } else {
      _selectedExpertise.add(expertiseId);
    }
    notifyListeners();
  }

  // Language management
  void toggleLanguage(String language) {
    if (_selectedLanguages.contains(language)) {
      _selectedLanguages.remove(language);
    } else {
      _selectedLanguages.add(language);
    }
    notifyListeners();
  }

  // Availability management
  void toggleAvailabilityDay(String day) {
    if (_availabilityDays.contains(day)) {
      _availabilityDays.remove(day);
    } else {
      _availabilityDays.add(day);
    }
    notifyListeners();
  }

  // Navigation helpers
  void nextStep() {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  // Validation
  bool validateCurrentStep() {
    // For MVP implementation, skip validation - this is a future feature placeholder
    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    experienceController.dispose();
    languagesController.dispose();
    aboutController.dispose();
    motivationController.dispose();
    super.dispose();
  }
}