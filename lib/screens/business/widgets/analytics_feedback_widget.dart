import 'package:flutter/material.dart';

/// Feedback widget showing customer reviews
class AnalyticsFeedbackWidget extends StatelessWidget {
  final String feedback;
  final String customer;
  final int rating;
  final String time;

  const AnalyticsFeedbackWidget({
    super.key,
    required this.feedback,
    required this.customer,
    required this.rating,
    required this.time,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feedback,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                customer,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              ...List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        size: 12,
                        color: index < rating ? Colors.amber : Colors.grey[300],
                      )),
              const Spacer(),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}