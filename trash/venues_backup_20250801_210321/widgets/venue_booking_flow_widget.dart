import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/theme.dart';
import '../../profile/services/auth_helpers.dart';

/// Booking flow widgets for venue bookings, deals, and group bookings
class VenueBookingFlowWidget extends StatelessWidget {
  final WidgetRef ref;

  const VenueBookingFlowWidget({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // This is a utility class
  }

  /// Show booking options modal
  static void showBookingOptions(
    BuildContext context,
    TabController tabController,
    WidgetRef ref,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Booking Options',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                ListTile(
                  leading: const Icon(Icons.local_offer, color: AppTheme.moroccoGreen),
                  title: const Text('Book a Deal'),
                  subtitle: const Text('Save money with current offers'),
                  onTap: () {
                    Navigator.pop(context);
                    tabController.animateTo(1); // Switch to deals tab
                  },
                ),
                
                ListTile(
                  leading: const Icon(Icons.restaurant, color: AppTheme.moroccoGreen),
                  title: const Text('Regular Booking'),
                  subtitle: const Text('Book at regular prices'),
                  onTap: () {
                    Navigator.pop(context);
                    _showRegularBooking(context, ref);
                  },
                ),
                
                ListTile(
                  leading: const Icon(Icons.group, color: AppTheme.moroccoGreen),
                  title: const Text('Group Booking'),
                  subtitle: const Text('Book for 6+ people'),
                  onTap: () {
                    Navigator.pop(context);
                    _showGroupBooking(context, ref);
                  },
                ),
                
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Show regular booking dialog
  static void _showRegularBooking(BuildContext context, WidgetRef ref) {
    if (!AuthHelpers.requireAuthForBooking(context, ref)) {
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Regular Booking'),
        content: const Text('Would you like to make a regular booking at standard prices?'),
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
                  content: Text('Booking request sent! We\'ll contact you shortly.'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }

  /// Show group booking dialog
  static void _showGroupBooking(BuildContext context, WidgetRef ref) {
    if (!AuthHelpers.requireAuthForBooking(context, ref)) {
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Group Booking'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Group booking for 6+ people'),
            SizedBox(height: 8),
            Text('Special group rates may apply. How many people?'),
          ],
        ),
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
                  content: Text('Group booking request sent! We\'ll contact you for details.'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Request Quote'),
          ),
        ],
      ),
    );
  }

  /// Show deal details modal
  static void showDealDetails(BuildContext context, dynamic deal, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  deal.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  deal.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '${deal.discountedPrice.toInt()} MAD',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${deal.originalPrice.toInt()} MAD',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppTheme.lightText,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: deal.isValid ? () => _bookDeal(context, deal, ref) : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      deal.isValid ? 'Book This Deal' : 'Deal Expired',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Book a deal
  static void _bookDeal(BuildContext context, dynamic deal, WidgetRef ref) {
    Navigator.pop(context);
    
    if (!AuthHelpers.requireAuthForBooking(context, ref)) {
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deal Booking'),
        content: Text('Book this deal at ${deal.discountedPrice.toInt()} MAD?'),
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
                  content: Text('Deal booked successfully! Check your email for confirmation.'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}