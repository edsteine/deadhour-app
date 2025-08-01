import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/morocco_cultural_service.dart';
import '../../utils/theme.dart';

// Halal Status Widget for DeadHour App
// Displays halal certification and dietary information
class HalalStatusWidget extends ConsumerWidget {
  final Map<String, dynamic> item;
  final bool showLabel;
  final bool showIcon;
  final double iconSize;

  const HalalStatusWidget({
    super.key,
    required this.item,
    this.showLabel = true,
    this.showIcon = true,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListenableBuilder(
      listenable: MoroccoCulturalService(),
      builder: (context, child) {
        final culturalService = MoroccoCulturalService();

        if (!culturalService.isInitialized) {
          return const SizedBox.shrink();
        }

        final halalStatus = culturalService.getHalalStatus(item);

        return _buildStatusBadge(halalStatus);
      },
    );
  }

  Widget _buildStatusBadge(HalalStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: status.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              status.icon,
              size: iconSize,
              color: status.color,
            ),
            if (showLabel) const SizedBox(width: 4),
          ],
          if (showLabel)
            Text(
              status.displayName,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: status.color,
              ),
            ),
        ],
      ),
    );
  }
}

// Compact halal indicator for venue cards
class CompactHalalIndicator extends ConsumerWidget {
  final Map<String, dynamic> item;

  const CompactHalalIndicator({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListenableBuilder(
      listenable: MoroccoCulturalService(),
      builder: (context, child) {
        final culturalService = MoroccoCulturalService();

        if (!culturalService.isInitialized) {
          return const SizedBox.shrink();
        }

        final halalStatus = culturalService.getHalalStatus(item);

        // Only show for certified or not-halal to reduce visual clutter
        if (halalStatus == HalalStatus.unknown ||
            halalStatus == HalalStatus.friendly) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: halalStatus.color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                halalStatus.icon,
                size: 12,
                color: Colors.white,
              ),
              const SizedBox(width: 2),
              Text(
                halalStatus == HalalStatus.certified ? 'Halal' : 'Non-Halal',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Detailed halal information widget
class HalalInfoWidget extends ConsumerWidget {
  final Map<String, dynamic> item;

  const HalalInfoWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListenableBuilder(
      listenable: MoroccoCulturalService(),
      builder: (context, child) {
        final culturalService = MoroccoCulturalService();

        if (!culturalService.isInitialized) {
          return const SizedBox.shrink();
        }

        final halalStatus = culturalService.getHalalStatus(item);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.restaurant,
                      color: halalStatus.color,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Dietary Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                    'Halal Status', halalStatus.displayName, halalStatus.color),
                if (item['isHalalCertified'] == true) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow('Certification', 'Verified Halal Certificate',
                      Colors.green),
                ],
                if (item['hasAlcohol'] == true) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow('Alcohol', 'Available', Colors.orange),
                ],
                if (item['hasPork'] == true) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow('Pork', 'Available', Colors.red),
                ],
                if (item['vegetarianOptions'] == true) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow(
                      'Vegetarian', 'Options Available', Colors.green),
                ],
                if (item['veganOptions'] == true) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow('Vegan', 'Options Available', Colors.green),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryText,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

// Ramadan special widget
class RamadanSpecialWidget extends ConsumerWidget {
  const RamadanSpecialWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListenableBuilder(
      listenable: MoroccoCulturalService(),
      builder: (context, child) {
        final culturalService = MoroccoCulturalService();

        if (!culturalService.isInitialized || !culturalService.isRamadanMode) {
          return const SizedBox.shrink();
        }

        final schedule = culturalService.getRamadanSchedule();
        if (schedule == null) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade700, Colors.purple.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.nightlight_round,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Ramadan Kareem',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Special Hours',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildRamadanTime(
                      'Iftar',
                      _formatTime(schedule.iftarStart),
                      Icons.dinner_dining,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildRamadanTime(
                      'Suhoor',
                      _formatTime(schedule.suhoorEnd),
                      Icons.restaurant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRamadanTime(String label, String time, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}
