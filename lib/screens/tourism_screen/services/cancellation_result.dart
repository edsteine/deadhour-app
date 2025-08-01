/// Cancellation result
class CancellationResult {
  final bool success;
  final String message;
  final double? refundAmount;
  final int? refundPercentage;
  final String? supportContact;

  const CancellationResult({
    required this.success,
    required this.message,
    this.refundAmount,
    this.refundPercentage,
    this.supportContact,
  });
}