import 'package:flutter/material.dart';

void showPremiumUpgrade(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Premium features coming soon! Currently all features are free during beta.'),
      duration: Duration(seconds: 3),
    ),
  );
}
