import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/services/deal_suggestions_service.dart';

class CreateDealSuggestionsSection extends StatelessWidget {
  final bool showSuggestions;
  final VoidCallback onToggleSuggestions;
  final List<DealSuggestion> suggestions;
  final Function(DealSuggestion) onApplySuggestion;

  const CreateDealSuggestionsSection({
    super.key,
    required this.showSuggestions,
    required this.onToggleSuggestions,
    required this.suggestions,
    required this.onApplySuggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSectionHeader('💡 Smart Suggestions'),
            const Spacer(),
            TextButton.icon(
              onPressed: onToggleSuggestions,
              icon: Icon(
                  showSuggestions ? Icons.visibility_off : Icons.visibility),
              label: Text(showSuggestions ? 'Hide' : 'Show'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'AI-powered suggestions based on your business type and current market data',
          style: TextStyle(
            color: AppTheme.secondaryText,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return _buildSuggestionCard(context, suggestion);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.moroccoGreen,
      ),
    );
  }

  Widget _buildSuggestionCard(BuildContext context, DealSuggestion suggestion) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: () => onApplySuggestion(suggestion),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      suggestion.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        suggestion.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.moroccoGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${suggestion.discountPercentage}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  suggestion.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.schedule,
                        size: 14, color: AppTheme.secondaryText),
                    const SizedBox(width: 4),
                    Text(
                      '${suggestion.targetTime.format(context)} - ${suggestion.endTime.format(context)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 14,
                      color: _getEffectivenessColor(suggestion.effectivenessScore),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${suggestion.effectivenessScore}% effective',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _getEffectivenessColor(suggestion.effectivenessScore),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Tap to apply',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.moroccoGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getEffectivenessColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
}