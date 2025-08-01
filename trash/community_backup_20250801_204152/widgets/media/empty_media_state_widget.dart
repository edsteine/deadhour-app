import '../../services/rich_media_service.dart';
import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

class EmptyMediaStateWidget extends StatelessWidget {
  final MediaType selectedType;
  final VoidCallback onUploadPressed;

  const EmptyMediaStateWidget({
    super.key,
    required this.selectedType,
    required this.onUploadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            selectedType.icon,
            style: const TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 12),
          Text(
            'No ${selectedType.displayName.toLowerCase()}s yet',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Be the first to share ${selectedType.displayName.toLowerCase()}s in this room!',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onUploadPressed,
            icon: const Icon(Icons.add_a_photo),
            label: Text('Upload ${selectedType.displayName}'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}