import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/profile/state/premium_role_state.dart';

class PremiumComparisonSection extends StatelessWidget {
  final PremiumRoleState state;

  const PremiumComparisonSection({
    super.key,
    required this.state,
  });

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
                ...(state.comparisonData.map((row) => TableRow(
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