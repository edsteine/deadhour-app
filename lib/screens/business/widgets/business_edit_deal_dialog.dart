import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusinessEditDealDialog extends StatelessWidget {
  const BusinessEditDealDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const BusinessEditDealDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Deal'),
      content: const Text('Select a deal to edit:'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate to create deal screen in edit mode
            context.go('/business/create-deal?mode=edit&id=mock_deal_1');
          },
          child: const Text('Edit Current Deal'),
        ),
      ],
    );
  }
}