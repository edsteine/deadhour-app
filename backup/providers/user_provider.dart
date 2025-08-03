import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../utils/mock_data.dart';

final userProvider = Provider<DeadHourUser?>((ref) {
  // In a real app, you would get the user from your authentication provider.
  // For now, we'll use the mock user.
  return MockData.currentUser;
});
