class PricingSuggestion {
  final int discountPercentage;
  final String reasoning;
  final String expectedIncrease;

  PricingSuggestion({
    required this.discountPercentage,
    required this.reasoning,
    required this.expectedIncrease,
  });
}