import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class SocialActionHelpers {
  static void showAdvancedFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Advanced Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Price Range'),
            RangeSlider(
              values: const RangeValues(50, 300),
              max: 500,
              onChanged: (values) {},
            ),
            const SizedBox(height: 16),
            const Text('Group Size'),
            DropdownButton<String>(
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                    value: 'small', child: Text('Small (2-8 people)')),
                DropdownMenuItem(
                    value: 'medium', child: Text('Medium (8-15 people)')),
                DropdownMenuItem(
                    value: 'large', child: Text('Large (15+ people)')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void viewExperienceDetails(
      BuildContext context, Map<String, dynamic> experience) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Experience Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // Add detailed experience information here
                const SizedBox(height: 16),
                const Text('Full experience details would be shown here...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void createNewExperience(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening experience creation wizard...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  static void contactHost(
      BuildContext context, Map<String, dynamic> experience) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening chat with host...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  static void joinExperience(
      BuildContext context, Map<String, dynamic> experience) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Join ${experience['title']}'),
        content: Text('Confirm booking for ${experience['price']} MAD?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Successfully joined experience!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  static void startHostApplication(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting host application process...'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  static void messageConnection(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening chat with $name...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  static void exploreCategory(BuildContext context, String category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exploring $category experiences...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }
}
