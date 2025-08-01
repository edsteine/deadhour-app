import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import 'user_provider.dart';

class RoleToggleNotifier extends StateNotifier<UserRole> {
  RoleToggleNotifier(this._ref) : super(UserRole.consumer);
  
  final Ref _ref;
  bool _isLoggedIn = false;
  List<UserRole> _activeRoles = [UserRole.consumer];

  bool get isLoggedIn => _isLoggedIn;
  List<UserRole> get activeRoles => _activeRoles;
  
  // Get current user from userProvider
  DeadHourUser? get currentUser => _ref.watch(userProvider);

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
      // Use roles from userProvider if available, otherwise use defaults
      final user = currentUser;
      if (user != null && user.activeRoles.isNotEmpty) {
        _activeRoles = user.activeRoles.toList();
        state = user.activeRoles.first;
      } else {
        // Default roles for demo
        _activeRoles = [UserRole.consumer, UserRole.business, UserRole.guide];
        state = UserRole.consumer;
      }
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
  return RoleToggleNotifier(ref);
});
