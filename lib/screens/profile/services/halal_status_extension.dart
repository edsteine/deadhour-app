import 'package:flutter/material.dart';

import 'halal_status.dart';

extension HalalStatusExtension on HalalStatus {
  String get displayName {
    switch (this) {
      case HalalStatus.certified:
        return 'Halal Certified';
      case HalalStatus.friendly:
        return 'Halal Friendly';
      case HalalStatus.notHalal:
        return 'Not Halal';
      case HalalStatus.unknown:
        return 'Unknown';
    }
  }

  Color get color {
    switch (this) {
      case HalalStatus.certified:
        return Colors.green;
      case HalalStatus.friendly:
        return Colors.lightGreen;
      case HalalStatus.notHalal:
        return Colors.red;
      case HalalStatus.unknown:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (this) {
      case HalalStatus.certified:
        return Icons.verified;
      case HalalStatus.friendly:
        return Icons.check_circle_outline;
      case HalalStatus.notHalal:
        return Icons.cancel;
      case HalalStatus.unknown:
        return Icons.help_outline;
    }
  }
}