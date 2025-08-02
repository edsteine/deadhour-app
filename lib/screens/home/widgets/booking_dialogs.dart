import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/models/venue.dart';
import 'package:deadhour/utils/mock_data.dart';

class BookingDialogs {
  static void showGroupBookingInfo(BuildContext context, Venue venue, VoidCallback onBookGroup) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.group, color: AppTheme.moroccoGreen),
            SizedBox(width: 8),
            Text('Group Booking'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${venue.name} offers special group rates!',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(Icons.people, size: 16, color: AppTheme.moroccoGreen),
                SizedBox(width: 8),
                Text('6+ people: 10% discount'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.people_alt, size: 16, color: AppTheme.moroccoGreen),
                SizedBox(width: 8),
                Text('10+ people: 15% discount'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.schedule, size: 16, color: AppTheme.moroccoGreen),
                SizedBox(width: 8),
                Text('Best rates during dead hours'),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Tip: Invite friends from the community for better deals!',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.secondaryText,
                ),
              ),
            ),
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
              onBookGroup();
            },
            child: const Text('Book for Group'),
          ),
        ],
      ),
    );
  }

  static void showGroupBookingForm(BuildContext context, Venue venue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Group Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How many people in your group for ${venue.name}?'),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Number of people',
                hintText: 'Minimum 6 for group rates',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
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
                  content: Text('Group booking request sent! We\'ll contact you with details.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Request Quote'),
          ),
        ],
      ),
    );
  }

  static void showDealBookingDialog(BuildContext context, Venue venue, dynamic deal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book ${deal.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('At ${venue.name}'),
            const SizedBox(height: 8),
            Text('Original Price: ${deal.originalPrice.toInt()} MAD'),
            Text(
              'Deal Price: ${deal.discountedPrice.toInt()} MAD',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.moroccoGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text('${deal.availableSpots} spots left'),
            Text('Valid until: ${deal.timeLeftDisplay}'),
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
                  content: Text('Deal booked successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Book Deal'),
          ),
        ],
      ),
    );
  }

  static void showRegularBookingDialog(BuildContext context, Venue venue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book at ${venue.name}'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Number of people',
                hintText: 'How many people?',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Preferred date & time',
                hintText: 'When would you like to visit?',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Special requests',
                hintText: 'Any special requirements?',
              ),
              maxLines: 2,
            ),
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
                  content:
                      Text('Booking request sent! We\'ll contact you soon.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }

  static void showVenueBooking(BuildContext context, Venue venue) {
    final deals = MockData.deals
        .where((deal) => deal.venueId == venue.id && deal.isValid)
        .toList();

    if (deals.isNotEmpty) {
      showDealBookingDialog(context, venue, deals.first);
    } else {
      showRegularBookingDialog(context, venue);
    }
  }
}