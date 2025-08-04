import '../../../../../utils/theme.dart';
import 'package:flutter/material.dart';

class ValidationActionsWidget extends StatelessWidget {
  final VoidCallback onAddValidation;
  final VoidCallback onAddRating;

  const ValidationActionsWidget({
    super.key,
    required this.onAddValidation,
    required this.onAddRating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onAddValidation,
            icon: const Icon(Icons.rate_review),
            label: const Text('Add Review'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onAddRating,
            icon: const Icon(Icons.star),
            label: const Text('Rate Deal'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
            ),
          ),
        ),
      ],
    );
  }
}