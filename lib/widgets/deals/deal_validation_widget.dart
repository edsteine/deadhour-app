import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/services/deal_validation_service.dart';
import 'package:deadhour/services/validation/validation_types.dart';
import 'package:deadhour/services/validation/deal_validation.dart';
import 'package:deadhour/services/validation/deal_rating.dart';
import 'package:deadhour/services/validation/validation_summary.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/models/deal.dart';

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
        final validations =
            _validationService.getDealValidations(widget.deal.id);
        final rating = _validationService.getDealRating(widget.deal.id);

        if (widget.isCompact) {
          return _buildCompactView(summary, rating);
        }

        return _buildFullView(summary, validations, rating);
      },
    );
  }

  Widget _buildCompactView(ValidationSummary summary, DealRating? rating) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getStatusColor(summary.communityStatus).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              _getStatusColor(summary.communityStatus).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          _buildStatusIcon(summary.communityStatus),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getStatusText(summary.communityStatus),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(summary.communityStatus),
                    fontSize: 12,
                  ),
                ),
                if (rating != null)
                  Row(
                    children: [
                      _buildStarRating(rating.averageRating, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        '${rating.averageRating.toStringAsFixed(1)} (${rating.totalRatings})',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (summary.totalValidations > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${summary.totalValidations}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFullView(ValidationSummary summary,
      List<DealValidation> validations, DealRating? rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(summary, rating),
        const SizedBox(height: 16),
        if (rating != null) _buildRatingDetails(rating),
        if (rating != null) const SizedBox(height: 16),
        _buildValidationsList(validations),
        const SizedBox(height: 16),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildHeader(ValidationSummary summary, DealRating? rating) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getStatusColor(summary.communityStatus),
            _getStatusColor(summary.communityStatus).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildStatusIcon(summary.communityStatus, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Community ${_getStatusText(summary.communityStatus)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (rating != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating.averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildValidationBadge('✅', summary.confirmedCount, 'Confirmed'),
              const SizedBox(width: 12),
              _buildValidationBadge('🔥', summary.verifiedCount, 'Verified'),
              const SizedBox(width: 12),
              if (summary.warningCount > 0)
                _buildValidationBadge('⚠️', summary.warningCount, 'Warnings'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValidationBadge(String icon, int count, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text(
          '$count $label',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingDetails(DealRating rating) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStarRating(rating.averageRating),
                const SizedBox(width: 8),
                Text(
                  '${rating.averageRating.toStringAsFixed(1)} out of 5',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${rating.totalRatings} reviews',
                  style: const TextStyle(
                    color: AppTheme.secondaryText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildRatingCategory('Value', rating.valueForMoney)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildRatingCategory('Quality', rating.quality)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: _buildRatingCategory('Service', rating.service)),
                const SizedBox(width: 16),
                Expanded(
                    child:
                        _buildRatingCategory('Authentic', rating.authenticity)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingCategory(String label, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: rating / 5.0,
                backgroundColor: Colors.grey.shade300,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppTheme.moroccoGreen),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildValidationsList(List<DealValidation> validations) {
    if (validations.isEmpty) {
      return _buildEmptyValidations();
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
            .map((validation) => _buildValidationCard(validation)),
        if (validations.length > 3)
          TextButton(
            onPressed: () => _showAllValidations(validations),
            child: Text('View all ${validations.length} reviews'),
          ),
      ],
    );
  }

  Widget _buildValidationCard(DealValidation validation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  child: Text(validation.userAvatar),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            validation.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildValidationTypeChip(validation.validationType),
                        ],
                      ),
                      Text(
                        _formatTimeAgo(validation.timestamp),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _validationService.markHelpful(validation.id),
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.thumb_up, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${validation.helpfulCount}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              validation.comment,
              style: const TextStyle(fontSize: 14),
            ),
            if (validation.tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: validation.tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          labelStyle: const TextStyle(fontSize: 10),
                          visualDensity: VisualDensity.compact,
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildValidationTypeChip(ValidationType type) {
    Color color;
    String text;
    IconData icon;

    switch (type) {
      case ValidationType.verified:
        color = Colors.green;
        text = 'Verified';
        icon = Icons.verified;
        break;
      case ValidationType.confirmed:
        color = Colors.blue;
        text = 'Confirmed';
        icon = Icons.check_circle;
        break;
      case ValidationType.warning:
        color = Colors.orange;
        text = 'Warning';
        icon = Icons.warning;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyValidations() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.people_outline,
              size: 48,
              color: AppTheme.secondaryText,
            ),
            SizedBox(height: 12),
            Text(
              'Be the first to validate!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Help the community by sharing your experience with this deal.',
              style: TextStyle(
                color: AppTheme.secondaryText,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showAddValidation(),
            icon: const Icon(Icons.rate_review),
            label: const Text('Add Review'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showAddRating(),
            icon: const Icon(Icons.star),
            label: const Text('Rate Deal'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating(double rating, {double size = 16}) {
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

  Color _getStatusColor(CommunityStatus status) {
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

  String _getStatusText(CommunityStatus status) {
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

  Widget _buildStatusIcon(CommunityStatus status, {Color? color}) {
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
      color: color ?? _getStatusColor(status),
      size: 20,
    );
  }

  String _formatTimeAgo(DateTime timestamp) {
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

  void _showAllValidations(List<DealValidation> validations) {
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
                  itemBuilder: (context, index) =>
                      _buildValidationCard(validations[index]),
                ),
              ),
            ],
          ),
        ),
      ),
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
