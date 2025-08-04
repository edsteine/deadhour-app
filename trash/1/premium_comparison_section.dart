import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

/// Premium vs Free comparison table
class PremiumComparisonSection extends StatelessWidget {
  const PremiumComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Free vs Premium',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            Table(
              border: TableBorder.all(
                color: Colors.grey.withValues(alpha: 0.3),
                width: 1,
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Feature',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Free',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Premium',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                ...([
                  ['Basic booking access', 'check', 'check'],
                  ['Community rooms', 'check', 'check'],
                  ['Deal notifications', 'check', 'check'],
                  ['Priority booking', 'close', 'check'],
                  ['Advanced analytics', 'close', 'check'],
                  ['Premium support', 'close', 'check'],
                  ['Exclusive deals', 'close', 'check'],
                  ['Multi-role optimization', 'close', 'check'],
                ].map((row) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(row[0]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        row[1] == 'check' ? Icons.check : Icons.close,
                        color: row[1] == 'check' ? AppTheme.moroccoGreen : Colors.red,
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        row[2] == 'check' ? Icons.check : Icons.close,
                        color: row[2] == 'check' ? AppTheme.moroccoGreen : Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}