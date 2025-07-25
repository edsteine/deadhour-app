import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class RoleToggleNotifier extends StateNotifier<UserRole> {
  RoleToggleNotifier() : super(UserRole.consumer);

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setRole(UserRole role) {
    state = role;
  }

  void toggleLogin() {
    _isLoggedIn = !_isLoggedIn;
    if (!_isLoggedIn) {
      state = UserRole.consumer; // Reset to consumer if logged out
    }
  }
}

final roleToggleProvider = StateNotifierProvider<RoleToggleNotifier, UserRole>((ref) {
  return RoleToggleNotifier();
});
