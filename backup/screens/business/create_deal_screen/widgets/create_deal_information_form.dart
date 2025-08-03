import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

class CreateDealInformationForm extends StatelessWidget {
  final TextEditingController titleController;
  final bool isHalalCertified;
  final bool isPrayerTimeAware;
  final ValueChanged<bool> onHalalChanged;
  final ValueChanged<bool> onPrayerTimeAwareChanged;

  const CreateDealInformationForm({
    super.key,
    required this.titleController,
    required this.isHalalCertified,
    required this.isPrayerTimeAware,
    required this.onHalalChanged,
    required this.onPrayerTimeAwareChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('🎯 Deal Information'),
        const SizedBox(height: 16),

        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Deal Name',
            hintText: 'e.g., Afternoon Coffee Special',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a deal name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        SwitchListTile(
          title: const Text('Halal Certified'),
          subtitle: const Text(
              'Indicate if this deal is for halal-certified venues/products'),
          value: isHalalCertified,
          onChanged: onHalalChanged,
        ),
        
        SwitchListTile(
          title: const Text('Prayer Time Aware'),
          subtitle: const Text(
              'Consider prayer times when promoting this deal'),
          value: isPrayerTimeAware,
          onChanged: onPrayerTimeAwareChanged,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.moroccoGreen,
      ),
    );
  }
}