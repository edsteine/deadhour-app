import '../../../../deals/services/deal_validation_service.dart';
import 'package:flutter/material.dart';

class ValidationUtils {
  static Color getStatusColor(CommunityStatus status) {
    switch (status) {
      case CommunityStatus.trusted:
        return Colors.green;
      case CommunityStatus.verified:
        return Colors.blue;
      case CommunityStatus.caution:
        return Colors.orange;
      case CommunityStatus.warning:
        return Colors.red;
      case CommunityStatus.unverified:
        return Colors.grey;
    }
  }

  static String getStatusText(CommunityStatus status) {
    switch (status) {
      case CommunityStatus.trusted:
        return 'Trusted';
      case CommunityStatus.verified:
        return 'Verified';
      case CommunityStatus.caution:
        return 'Use Caution';
      case CommunityStatus.warning:
        return 'Warning';
      case CommunityStatus.unverified:
        return 'Unverified';
    }
  }

  static Widget buildStatusIcon(CommunityStatus status, {Color? color}) {
    IconData icon;
    switch (status) {
      case CommunityStatus.trusted:
        icon = Icons.verified_user;
        break;
      case CommunityStatus.verified:
        icon = Icons.check_circle;
        break;
      case CommunityStatus.caution:
        icon = Icons.info;
        break;
      case CommunityStatus.warning:
        icon = Icons.warning;
        break;
      case CommunityStatus.unverified:
        icon = Icons.help_outline;
        break;
    }

    return Icon(
      icon,
      color: color ?? getStatusColor(status),
      size: 20,
    );
  }

  static Widget buildStarRating(double rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating
                  ? Icons.star_half
                  : Icons.star_border,
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }

  static String formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}