import 'package:flutter/material.dart';

class BusinessActivityModal extends StatelessWidget {
  const BusinessActivityModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const BusinessActivityModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 10, // Mock data
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(_getActivityIcon(index)),
                      ),
                      title: Text(_getActivityTitle(index)),
                      subtitle: Text(_getActivitySubtitle(index)),
                      trailing: Text(_getActivityTime(index)),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getActivityIcon(int index) {
    final icons = [
      Icons.person_add,
      Icons.shopping_cart,
      Icons.star,
      Icons.message,
      Icons.analytics,
    ];
    return icons[index % icons.length];
  }

  String _getActivityTitle(int index) {
    final titles = [
      'New customer booking',
      'Deal order completed',
      'Review received',
      'Customer message',
      'Analytics update',
    ];
    return titles[index % titles.length];
  }

  String _getActivitySubtitle(int index) {
    final subtitles = [
      'Table for 4 at 15:30',
      '20% off lunch special',
      '5 stars from Ahmed K.',
      'Question about menu',
      'Weekly performance report',
    ];
    return subtitles[index % subtitles.length];
  }

  String _getActivityTime(int index) {
    final times = ['2m ago', '15m ago', '1h ago', '3h ago', '1d ago'];
    return times[index % times.length];
  }
}