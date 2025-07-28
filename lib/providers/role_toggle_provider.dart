import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class RoleToggleNotifier extends StateNotifier<UserRole> {
  RoleToggleNotifier() : super(UserRole.consumer);

  bool _isLoggedIn = false;
  List<UserRole> _activeRoles = [UserRole.consumer];

  bool get isLoggedIn => _isLoggedIn;
  List<UserRole> get activeRoles => _activeRoles;

  void setRole(UserRole role) {
    if (_activeRoles.contains(role)) {
      state = role;
    }
  }

  void toggleLogin() {
    _isLoggedIn = !_isLoggedIn;
    if (!_isLoggedIn) {
      state = UserRole.consumer;
      _activeRoles = [UserRole.consumer];
    } else {
      // In a real app, you would fetch the user's roles from a backend
      _activeRoles = [UserRole.consumer, UserRole.business, UserRole.guide];
    }
  }

  void addRole(UserRole role) {
    if (!_activeRoles.contains(role)) {
      _activeRoles.add(role);
      // In a real app, you would update the user's roles in the backend
    }
  }
}

final roleToggleProvider =
    StateNotifierProvider<RoleToggleNotifier, UserRole>((ref) {
  return RoleToggleNotifier();
});
