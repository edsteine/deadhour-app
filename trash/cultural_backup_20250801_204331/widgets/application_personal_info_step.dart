import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../application_state.dart';

/// Personal information step for cultural ambassador application
class ApplicationPersonalInfoStep extends StatefulWidget {
  final ApplicationState state;

  const ApplicationPersonalInfoStep({
    super.key,
    required this.state,
  });

  @override
  State<ApplicationPersonalInfoStep> createState() => _ApplicationPersonalInfoStepState();
}

class _ApplicationPersonalInfoStepState extends State<ApplicationPersonalInfoStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tell us about yourself to get started with your cultural ambassador application.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 24),
          
          // Name
          TextFormField(
            controller: widget.state.nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email
          TextFormField(
            controller: widget.state.emailController,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              hintText: 'your.email@example.com',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Email is required';
              }
              if (!value!.contains('@')) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Phone
          TextFormField(
            controller: widget.state.phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: '+212 6 12 34 56 78',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Phone number is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // City
          TextFormField(
            controller: widget.state.cityController,
            decoration: const InputDecoration(
              labelText: 'City',
              hintText: 'Casablanca, Marrakech, Rabat...',
              prefixIcon: Icon(Icons.location_city),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'City is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Languages
          const Text(
            'Languages You Speak',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.state.moroccanLanguages.map((language) {
              final isSelected = widget.state.selectedLanguages.contains(language);
              return FilterChip(
                selected: isSelected,
                label: Text(language),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      widget.state.selectedLanguages.add(language);
                    } else {
                      widget.state.selectedLanguages.remove(language);
                    }
                  });
                },
                selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                checkmarkColor: AppTheme.moroccoGreen,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}