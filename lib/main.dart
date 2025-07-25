import 'package:flutter/material.dart';
import 'package:deadhour/app.dart'; // Import the main DeadHourApp from app.dart
import 'package:deadhour/utils/guest_mode.dart'; // Keep guest mode utility

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize guest mode state
  await GuestMode.initialize();
  
  runApp(const DeadHourApp()); // Use the DeadHourApp defined in app.dart
}

