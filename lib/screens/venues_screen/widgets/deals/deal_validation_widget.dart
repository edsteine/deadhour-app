

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';





import 'package:deadhour/utils/app_theme.dart';

class DealValidationWidget extends ConsumerStatefulWidget {
  final Deal deal;
  final bool isCompact;

  const DealValidationWidget({
    super.key,
    required this.deal,
    this.isCompact = false,
  });

  @override
  ConsumerState<DealValidationWidget> createState() =>
      _DealValidationWidgetState();
}

class _DealValidationWidgetState extends ConsumerState<DealValidationWidget> {
  final DealValidationService _validationService = DealValidationService();

  @override
  void initState() {
    super.initState();
    _validationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _validationService,
      builder: (context, child) {
        final summary = _validationService.getValidationSummary(widget.deal.id);
        final validations = _validationService.getDealValidations(widget.deal.id);
        final rating = _validationService.getDealRating(widget.deal.id);

        if (widget.isCompact) {
          return CompactValidationView(
            summary: summary,
            rating: rating,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValidationHeader(summary: summary, rating: rating),
            const SizedBox(height: 16),
            if (rating != null) RatingDetailsWidget(rating: rating),
            if (rating != null) const SizedBox(height: 16),
            ValidationsListWidget(
              validations: validations,
              validationService: _validationService,
            ),
            const SizedBox(height: 16),
            ValidationActionsWidget(
              onAddValidation: _showAddValidation,
              onAddRating: _showAddRating,
            ),
          ],
        );
      },
    );
  }

  void _showAddValidation() {
    // This would show a form to add validation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add validation form would open here'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _showAddRating() {
    // This would show a form to add rating
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add rating form would open here'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }
}