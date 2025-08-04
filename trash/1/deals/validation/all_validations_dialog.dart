import '../../../../deals/services/deal_validation_service.dart';
import 'package:flutter/material.dart';
import 'validation_card.dart';

class AllValidationsDialog {
  static void show(BuildContext context, List<DealValidation> validations) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'All Community Reviews',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: validations.length,
                  itemBuilder: (context, index) => ValidationCard(
                    validation: validations[index],
                    validationService: DealValidationService(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}