import 'package:flutter/material.dart';

/// Payment state management for payment screen
class PaymentState {
  // Payment method selection
  String selectedPaymentMethod = 'at_venue'; // 'at_venue', 'card', 'mobile_money', 'bank_transfer'

  // Card details
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final cardHolderController = TextEditingController();

  // Mobile money details
  final phoneController = TextEditingController();
  String selectedProvider = 'orange'; // 'orange', 'inwi', 'maroc_telecom'

  // Bank transfer details
  String selectedBank = 'attijariwafa'; // Morocco banks
  final accountController = TextEditingController();

  // Payment state
  bool isProcessing = false;
  bool savePaymentMethod = false;

  // Morocco-specific payment providers
  final List<Map<String, dynamic>> mobileProviders = [
    {
      'id': 'orange',
      'name': 'Orange Money',
      'icon': '🟠',
      'color': Colors.orange
    },
    {'id': 'inwi', 'name': 'inwi Money', 'icon': '🔵', 'color': Colors.blue},
    {
      'id': 'maroc_telecom',
      'name': 'Maroc Telecom Cash',
      'icon': '🔴',
      'color': Colors.red
    },
  ];

  final List<Map<String, dynamic>> banks = [
    {'id': 'attijariwafa', 'name': 'Attijariwafa Bank', 'icon': '🏦'},
    {'id': 'bmce', 'name': 'BMCE Bank', 'icon': '🏪'},
    {'id': 'bmci', 'name': 'BMCI', 'icon': '🏛️'},
    {'id': 'cih', 'name': 'CIH Bank', 'icon': '🏢'},
    {'id': 'credit_agricole', 'name': 'Crédit Agricole', 'icon': '🌾'},
  ];

  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    cardHolderController.dispose();
    phoneController.dispose();
    accountController.dispose();
  }
}