import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/auth_service.dart';

class BusinessSignOutDialog extends StatelessWidget {
  const BusinessSignOutDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const BusinessSignOutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out of your business account?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(context);
            // Clear user session and navigate to auth screen
            try {
              await AuthService().logout();
              debugPrint('User signed out from business dashboard');
              context.go('/auth/login');
            } catch (e) {
              debugPrint('Logout error: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error signing out. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text('Sign Out'),
        ),
      ],
    );
  }
}