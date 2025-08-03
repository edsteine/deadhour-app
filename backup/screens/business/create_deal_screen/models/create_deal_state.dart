import 'package:flutter/material.dart';

class CreateDealState {
  // Controllers
  final TextEditingController titleController;
  final TextEditingController communityMessageController;

  // Deal Configuration
  String dealType;
  int discountPercentage;
  String targetItems;
  
  // Schedule Configuration
  TimeOfDay startTime;
  TimeOfDay endTime;
  List<String> selectedDays;
  
  // Capacity Configuration
  int maxCustomersPerDay;
  int maxPerTimeSlot;
  
  // Feature Flags
  bool notifyCommunity;
  bool isHalalCertified;
  bool isPrayerTimeAware;
  bool showSuggestions;
  
  // Business Context
  final String businessType;
  
  // Static Data
  final List<String> weekDays = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  CreateDealState({
    String? initialTitle,
    String? initialMessage,
    this.dealType = 'percentage',
    this.discountPercentage = 35,
    this.targetItems = 'all',
    this.startTime = const TimeOfDay(hour: 14, minute: 0),
    this.endTime = const TimeOfDay(hour: 16, minute: 0),
    List<String>? selectedDays,
    this.maxCustomersPerDay = 20,
    this.maxPerTimeSlot = 8,
    this.notifyCommunity = true,
    this.isHalalCertified = false,
    this.isPrayerTimeAware = false,
    this.showSuggestions = true,
    this.businessType = 'food',
  }) : 
    titleController = TextEditingController(
      text: initialTitle ?? 'Afternoon Coffee Special'
    ),
    communityMessageController = TextEditingController(
      text: initialMessage ?? 'Perfect afternoon study spot! Quiet atmosphere, great coffee, free WiFi. Beat the afternoon energy dip with our special! ☕'
    ),
    selectedDays = selectedDays ?? ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  // Helper methods for connected operations
  void updateFromSuggestion(DealSuggestion suggestion, String businessType) {
    titleController.text = suggestion.title;
    discountPercentage = suggestion.discountPercentage;
    startTime = suggestion.targetTime;
    endTime = suggestion.endTime;
  }
  
  void updateSchedule({
    TimeOfDay? newStartTime,
    TimeOfDay? newEndTime,
    List<String>? newSelectedDays,
  }) {
    if (newStartTime != null) startTime = newStartTime;
    if (newEndTime != null) endTime = newEndTime;
    if (newSelectedDays != null) selectedDays = newSelectedDays;
  }
  
  void updateCapacity({
    int? newMaxCustomersPerDay,
    int? newMaxPerTimeSlot,
  }) {
    if (newMaxCustomersPerDay != null) maxCustomersPerDay = newMaxCustomersPerDay;
    if (newMaxPerTimeSlot != null) maxPerTimeSlot = newMaxPerTimeSlot;
  }
  
  void updateDealType({
    String? newDealType,
    int? newDiscountPercentage,
    String? newTargetItems,
  }) {
    if (newDealType != null) dealType = newDealType;
    if (newDiscountPercentage != null) discountPercentage = newDiscountPercentage;
    if (newTargetItems != null) targetItems = newTargetItems;
  }
  
  void updateFeatures({
    bool? newNotifyCommunity,
    bool? newIsHalalCertified,
    bool? newIsPrayerTimeAware,
    bool? newShowSuggestions,
  }) {
    if (newNotifyCommunity != null) notifyCommunity = newNotifyCommunity;
    if (newIsHalalCertified != null) isHalalCertified = newIsHalalCertified;
    if (newIsPrayerTimeAware != null) isPrayerTimeAware = newIsPrayerTimeAware;
    if (newShowSuggestions != null) showSuggestions = newShowSuggestions;
  }
  
  // Validation
  bool isValid() {
    return titleController.text.isNotEmpty &&
           selectedDays.isNotEmpty &&
           startTime.hour < endTime.hour;
  }
  
  // Data export for API/persistence
  Map<String, dynamic> toJson() {
    return {
      'title': titleController.text,
      'communityMessage': communityMessageController.text,
      'dealType': dealType,
      'discountPercentage': discountPercentage,
      'targetItems': targetItems,
      'startHour': startTime.hour,
      'startMinute': startTime.minute,
      'endHour': endTime.hour,
      'endMinute': endTime.minute,
      'selectedDays': selectedDays,
      'maxCustomersPerDay': maxCustomersPerDay,
      'maxPerTimeSlot': maxPerTimeSlot,
      'notifyCommunity': notifyCommunity,
      'isHalalCertified': isHalalCertified,
      'isPrayerTimeAware': isPrayerTimeAware,
      'businessType': businessType,
    };
  }
  
  void dispose() {
    titleController.dispose();
    communityMessageController.dispose();
  }
}

// Import for DealSuggestion if not already available
class DealSuggestion {
  final String title;
  final int discountPercentage;
  final TimeOfDay targetTime;
  final TimeOfDay endTime;
  final String icon;
  final String description;
  final int effectivenessScore;
  
  DealSuggestion({
    required this.title,
    required this.discountPercentage,
    required this.targetTime,
    required this.endTime,
    required this.icon,
    required this.description,
    required this.effectivenessScore,
  });
}