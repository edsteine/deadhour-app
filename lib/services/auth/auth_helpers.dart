import 'package:deadhour/models/user.dart';

class AuthHelpers {
  static DeadHourUser createMockUser(String identifier) {
    return DeadHourUser(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: identifier.contains('@') ? identifier : 'user@deadhour.ma',
      name: 'Ahmed Hassan',
      phone: identifier.startsWith('+212') ? identifier : '+212612345678',
      city: 'Casablanca',
      profileImageUrl: 'https://i.pravatar.cc/150?u=$identifier',
      activeRoles: {UserRole.consumer},
      isVerified: true,
      joinDate: DateTime.now().subtract(const Duration(days: 30)),
    );
  }

  static Set<UserRole> determineUserRoles(String userType) {
    switch (userType) {
      case 'business':
        return {UserRole.consumer, UserRole.business};
      case 'guide':
        return {UserRole.consumer, UserRole.guide};
      case 'tourist':
        return {UserRole.consumer};
      default:
        return {UserRole.consumer};
    }
  }

  static String generateAuthToken(String userId) {
    return 'mock_token_$userId';
  }

  static String generateRefreshToken() {
    return 'refreshed_token_${DateTime.now().millisecondsSinceEpoch}';
  }
}