import '../../../../deals/services/deal_validation_service.dart';
import 'package:flutter/material.dart';

class ValidationTypeChip extends StatelessWidget {
  final ValidationType type;

  const ValidationTypeChip({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;
    IconData icon;

    switch (type) {
      case ValidationType.verified:
        color = Colors.green;
        text = 'Verified';
        icon = Icons.verified;
        break;
      case ValidationType.confirmed:
        color = Colors.blue;
        text = 'Confirmed';
        icon = Icons.check_circle;
        break;
      case ValidationType.warning:
        color = Colors.orange;
        text = 'Warning';
        icon = Icons.warning;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}