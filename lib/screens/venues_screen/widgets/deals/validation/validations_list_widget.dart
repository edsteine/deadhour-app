


import 'package:flutter/material.dart';




class ValidationsListWidget extends StatelessWidget {
  final List<DealValidation> validations;
  final DealValidationService validationService;

  const ValidationsListWidget({
    super.key,
    required this.validations,
    required this.validationService,
  });

  @override
  Widget build(BuildContext context) {
    if (validations.isEmpty) {
      return const EmptyValidationsWidget();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Community Feedback',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...validations
            .take(3)
            .map((validation) => ValidationCard(
                  validation: validation,
                  validationService: validationService,
                )),
        if (validations.length > 3)
          TextButton(
            onPressed: () => AllValidationsDialog.show(context, validations),
            child: Text('View all ${validations.length} reviews'),
          ),
      ],
    );
  }
}