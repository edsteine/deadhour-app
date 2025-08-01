import 'automatic_deal_service.dart';
import 'cashback_service.dart';
import '../../../utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/mock_data.dart';
import '../../business/services/ramadan_business_service.dart';

/// Service for handling all deal interactions (booking, sharing, saving, etc.)
class DealInteractionService {
  final CashbackService _cashbackService;
  final AutomaticDealService _automaticDealService;
  final RamadanBusinessService _ramadanService;

  DealInteractionService({
    CashbackService? cashbackService,
    AutomaticDealService? automaticDealService,
    RamadanBusinessService? ramadanService,
  })  : _cashbackService = cashbackService ?? CashbackService(),
        _automaticDealService = automaticDealService ?? AutomaticDealService(),
        _ramadanService = ramadanService ?? RamadanBusinessService();

  void showDealDetails(BuildContext context, dynamic deal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          final venue = MockData.venues.firstWhere(
            (v) => v.id == deal.venueId,
            orElse: () => MockData.venues.first,
          );

          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
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

                // Deal header
                Row(
                  children: [
                    Text(deal.statusIcon, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            venue.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.moroccoGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        deal.discountDisplay,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  deal.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                // Price and availability
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${deal.discountedPrice.toInt()} MAD',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.moroccoGreen,
                          ),
                        ),
                        Text(
                          '${deal.originalPrice.toInt()} MAD',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.lightText,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${deal.availableSpots} spots left',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          deal.timeLeftDisplay,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Book button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: deal.isValid ? () => bookDeal(context, deal) : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      deal.isValid ? 'Book Now' : 'Deal Expired',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Share and save buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => shareDeal(context, deal),
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => saveDeal(context, deal),
                        icon: const Icon(Icons.bookmark_border),
                        label: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void bookDeal(BuildContext context, dynamic deal, [WidgetRef? ref]) {
    Navigator.pop(context);

    // Check if user is authenticated before allowing booking
    // Note: For now we'll assume authentication is handled elsewhere
    // TODO: Properly handle authentication check when ref is available

    // Calculate cashback before booking
    final cashbackCalculation = _cashbackService.calculateCashback(deal, deal.discountedPrice);

    // User is authenticated, proceed with booking
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book this deal at ${deal.discountedPrice.toInt()} MAD?'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: AppTheme.moroccoGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cashback Earned',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '+${cashbackCalculation.cashbackAmount.toStringAsFixed(2)} MAD (${(cashbackCalculation.finalRate * 100).toStringAsFixed(1)}%)',
                          style: const TextStyle(
                            color: AppTheme.moroccoGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
            onPressed: () async {
              Navigator.pop(context);
              
              // Process cashback
              await _cashbackService.processCashback(deal, deal.discountedPrice);
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Booking confirmed!'),
                              Text(
                                'Earned ${cashbackCalculation.cashbackAmount.toStringAsFixed(2)} MAD cashback',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: AppColors.success,
                    action: SnackBarAction(
                      label: 'View',
                      textColor: Colors.white,
                      onPressed: () => showCashbackDetails(context),
                    ),
                  ),
                );
              }
            },
            child: const Text('Book & Earn Cashback'),
          ),
        ],
      ),
    );
  }

  void shareDeal(BuildContext context, dynamic deal) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deal shared successfully!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void saveDeal(BuildContext context, dynamic deal) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deal saved to your favorites!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void showCreateDealAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Deal'),
        content: const Text(
          'Are you a business owner? Switch to business mode to create deals for your venue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/business');
            },
            child: const Text('Go to Business'),
          ),
        ],
      ),
    );
  }

  void showCashbackDetails(BuildContext context) {
    final summary = _cashbackService.getCashbackSummary();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
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

                // Cashback details content
                const Text(
                  'Your Cashback',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Available: ${summary.availableAmount.toStringAsFixed(2)} MAD',
                  style: const TextStyle(fontSize: 18),
                ),
                // Add more cashback details as needed
              ],
            ),
          );
        },
      ),
    );
  }

  void showRamadanDeals(BuildContext context) {
    final strategies = _ramadanService.getRamadanDealStrategies();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Text('🌙', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('Ramadan Deal Strategies'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Seasonal Dead Hours Opportunities:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                ...strategies.map<Widget>((strategy) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.moroccoGold.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.moroccoGold.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strategy['dealType'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppTheme.moroccoGold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Time: ${strategy['timeSlot']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Discount: ${strategy['discountRange']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Benefit: ${strategy['businessBenefit']}',
                        style: const TextStyle(fontSize: 12, color: AppTheme.secondaryText),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void dispose() {
    _automaticDealService.dispose();
  }
}