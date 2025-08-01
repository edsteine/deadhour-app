import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


/// Action buttons for deal preview, save draft, and publish
class DealActionButtons extends StatelessWidget {
  final VoidCallback onSubmit;

  const DealActionButtons({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Preview and Save Draft buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement preview functionality
                },
                icon: const Icon(Icons.preview),
                label: const Text('Preview Deal'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement save draft functionality
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Draft'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Publish Deal button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.rocket_launch),
            label: const Text('Publish Deal'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}