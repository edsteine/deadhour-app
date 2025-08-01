import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


class ConnectionCard extends StatelessWidget {
  final String name;
  final String role;
  final double rating;
  final String connection;
  final Function(String) onMessageConnection;

  const ConnectionCard({
    super.key,
    required this.name,
    required this.role,
    required this.rating,
    required this.connection,
    required this.onMessageConnection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('https://via.placeholder.com/50'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  connection,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text('$rating'),
                ],
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => onMessageConnection(name),
                child: const Text('Message', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
