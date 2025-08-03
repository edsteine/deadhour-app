import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

class CreateDealActionButtons extends StatelessWidget {
  final VoidCallback onPreviewPressed;
  final VoidCallback onSaveDraftPressed;
  final VoidCallback onPublishPressed;

  const CreateDealActionButtons({
    super.key,
    required this.onPreviewPressed,
    required this.onSaveDraftPressed,
    required this.onPublishPressed,
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
                onPressed: onPreviewPressed,
                icon: const Icon(Icons.preview),
                label: const Text('Preview Deal'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onSaveDraftPressed,
                icon: const Icon(Icons.save),
                label: const Text('Save Draft'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Publish button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onPublishPressed,
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