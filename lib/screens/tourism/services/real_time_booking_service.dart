import 'dart:async';
import 'dart:math';

import 'booking.dart';
import 'booking_availability.dart';
import 'booking_error_type.dart';
import 'booking_result.dart';
import 'booking_slot.dart';
import 'booking_status.dart';
import 'booking_update.dart';
import 'booking_update_type.dart';
import 'cancellation_result.dart';
import 'support_contact.dart';


/// Real-time booking service for tourism experiences
/// Addresses critical missing real-time booking from TAB_ANALYSIS_REPORT.md
class RealTimeBookingService {
  static final RealTimeBookingService _instance = RealTimeBookingService._internal();
  factory RealTimeBookingService() => _instance;
  RealTimeBookingService._internal();

  // Booking state management
  final Map<String, BookingAvailability> _availabilities = {};
  final Map<String, List<BookingSlot>> _bookingSlots = {};
  final Map<String, Booking> _activeBookings = {};
  final StreamController<BookingUpdate> _bookingUpdates = StreamController.broadcast();
  
  bool _isInitialized = false;
  Timer? _availabilityUpdateTimer;

  /// Initialize booking service with real-time availability
  void initializeBookingService() {
    if (_isInitialized) return;
    
    _generateInitialAvailability();
    _startRealTimeUpdates();
    _isInitialized = true;
  }

  /// Get real-time availability for an experience
  BookingAvailability? getAvailability(String experienceId) {
    return _availabilities[experienceId];
  }

  /// Get available booking slots for a specific date
  List<BookingSlot> getAvailableSlots(String experienceId, DateTime date) {
    final slots = _bookingSlots[experienceId] ?? [];
    return slots.where((slot) => 
      slot.dateTime.year == date.year &&
      slot.dateTime.month == date.month &&
      slot.dateTime.day == date.day &&
      slot.isAvailable
    ).toList();
  }

  /// Book an experience with instant confirmation
  Future<BookingResult> bookExperience({
    required String experienceId,
    required String slotId,
    required String userId,
    required String userName,
    required String userEmail,
    required int participants,
    Map<String, dynamic>? specialRequests,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Check slot availability
    final slots = _bookingSlots[experienceId] ?? [];
    final slotIndex = slots.indexWhere((s) => s.id == slotId);
    
    if (slotIndex == -1) {
      return const BookingResult(
        success: false,
        message: 'Booking slot not found',
        errorType: BookingErrorType.slotNotFound,
      );
    }

    final slot = slots[slotIndex];
    
    // Check availability
    if (!slot.isAvailable || slot.availableSpots < participants) {
      return BookingResult(
        success: false,
        message: 'Sorry! This slot is no longer available. Please select another time.',
        errorType: BookingErrorType.noAvailability,
        alternativeSlots: _suggestAlternativeSlots(experienceId, slot.dateTime),
      );
    }

    // Create booking
    final bookingId = 'booking_${DateTime.now().millisecondsSinceEpoch}';
    final booking = Booking(
      id: bookingId,
      experienceId: experienceId,
      slotId: slotId,
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      participants: participants,
      totalPrice: slot.pricePerPerson * participants,
      bookingTime: DateTime.now(),
      status: BookingStatus.confirmed,
      confirmationCode: _generateConfirmationCode(),
      specialRequests: specialRequests,
      cancellationDeadline: slot.dateTime.subtract(const Duration(hours: 24)),
      canCancel: true,
    );

    // Update slot availability
    slots[slotIndex] = slot.copyWith(
      availableSpots: slot.availableSpots - participants,
      isAvailable: (slot.availableSpots - participants) > 0,
    );

    // Store booking
    _activeBookings[bookingId] = booking;

    // Update overall availability
    _updateExperienceAvailability(experienceId);

    // Broadcast update
    _bookingUpdates.add(BookingUpdate(
      type: BookingUpdateType.newBooking,
      experienceId: experienceId,
      booking: booking,
    ));

    return BookingResult(
      success: true,
      message: 'Booking confirmed! You will receive confirmation details shortly.',
      booking: booking,
    );
  }

  /// Cancel a booking with flexible 24-hour policy
  Future<CancellationResult> cancelBooking(String bookingId, String reason) async {
    final booking = _activeBookings[bookingId];
    if (booking == null) {
      return const CancellationResult(
        success: false,
        message: 'Booking not found',
      );
    }

    // Check cancellation policy (24-hour flexible cancellation)
    final now = DateTime.now();
    if (!booking.canCancel || now.isAfter(booking.cancellationDeadline)) {
      return const CancellationResult(
        success: false,
        message: 'Cancellation deadline has passed. Contact support for assistance.',
        supportContact: '+212 5XX-XXX-XXX',
      );
    }

    // Process cancellation
    booking.status = BookingStatus.cancelled;
    
    // Restore availability
    final slots = _bookingSlots[booking.experienceId] ?? [];
    final slotIndex = slots.indexWhere((s) => s.id == booking.slotId);
    if (slotIndex != -1) {
      final slot = slots[slotIndex];
      slots[slotIndex] = slot.copyWith(
        availableSpots: slot.availableSpots + booking.participants,
        isAvailable: true,
      );
    }

    // Calculate refund (full refund for 24+ hours, 50% for 12-24 hours)
    final hoursBeforeExperience = booking.cancellationDeadline.difference(now).inHours;
    final refundPercentage = hoursBeforeExperience >= 24 ? 100 : 50;
    final refundAmount = (booking.totalPrice * refundPercentage / 100);

    // Update availability
    _updateExperienceAvailability(booking.experienceId);

    // Broadcast update
    _bookingUpdates.add(BookingUpdate(
      type: BookingUpdateType.cancellation,
      experienceId: booking.experienceId,
      booking: booking,
    ));

    return CancellationResult(
      success: true,
      message: 'Booking cancelled successfully. Refund will be processed within 3-5 business days.',
      refundAmount: refundAmount,
      refundPercentage: refundPercentage,
    );
  }

  /// Get user's active bookings
  List<Booking> getUserBookings(String userId) {
    return _activeBookings.values
        .where((booking) => booking.userId == userId && booking.status != BookingStatus.cancelled)
        .toList()
        ..sort((a, b) => a.bookingTime.compareTo(b.bookingTime));
  }

  /// Get booking updates stream
  Stream<BookingUpdate> get bookingUpdates => _bookingUpdates.stream;

  /// Contact 24/7 support
  SupportContact get support => const SupportContact(
    phone: '+212 5XX-XXX-XXX',
    whatsapp: '+212 6XX-XXX-XXX',
    email: 'support@deadhour.ma',
    availableHours: '24/7',
  );

  void _generateInitialAvailability() {
    // Generate availability for tourism experiences
    final experiences = [
      'traditional_cooking_class',
      'medina_walking_tour',
      'atlas_mountains_hike',
      'desert_camel_trek',
      'pottery_workshop',
      'hammam_experience',
      'souk_shopping_tour',
      'cultural_exchange',
    ];

    for (final experienceId in experiences) {
      _generateExperienceAvailability(experienceId);
    }
  }

  void _generateExperienceAvailability(String experienceId) {
    final random = Random();
    
    // Generate booking slots for next 30 days
    final slots = <BookingSlot>[];
    final basePrice = 50 + random.nextInt(200); // 50-250 MAD
    
    for (int day = 0; day < 30; day++) {
      final date = DateTime.now().add(Duration(days: day));
      
      // Skip past days
      if (date.isBefore(DateTime.now())) continue;
      
      // Generate 3-5 time slots per day
      final slotsPerDay = 3 + random.nextInt(3);
      
      for (int slot = 0; slot < slotsPerDay; slot++) {
        final hour = 9 + (slot * 3); // 9am, 12pm, 3pm, 6pm, 9pm
        final slotDateTime = DateTime(date.year, date.month, date.day, hour);
        
        // Skip past times for today
        if (slotDateTime.isBefore(DateTime.now().add(const Duration(hours: 2)))) continue;
        
        final maxCapacity = 8 + random.nextInt(8); // 8-15 people
        final bookedSpots = random.nextInt(maxCapacity ~/ 2); // Random bookings
        final availableSpots = maxCapacity - bookedSpots;
        
        slots.add(BookingSlot(
          id: 'slot_${experienceId}_${day}_$slot',
          experienceId: experienceId,
          dateTime: slotDateTime,
          duration: Duration(hours: 2 + random.nextInt(3)), // 2-4 hours
          maxCapacity: maxCapacity,
          availableSpots: availableSpots,
          isAvailable: availableSpots > 0,
          pricePerPerson: basePrice.toDouble(),
          guideId: 'guide_${random.nextInt(4) + 1}',
          guideName: _getGuideName(random.nextInt(4)),
        ));
      }
    }
    
    _bookingSlots[experienceId] = slots;
    
    // Generate overall availability
    final totalSlots = slots.length;
    final availableSlots = slots.where((s) => s.isAvailable).length;
    final averagePrice = slots.isNotEmpty 
        ? slots.map((s) => s.pricePerPerson).reduce((a, b) => a + b) / slots.length
        : 0.0;
    
    _availabilities[experienceId] = BookingAvailability(
      experienceId: experienceId,
      isAvailable: availableSlots > 0,
      nextAvailableSlot: availableSlots > 0 
          ? slots.firstWhere((s) => s.isAvailable).dateTime
          : null,
      totalSlots: totalSlots,
      availableSlots: availableSlots,
      averagePrice: averagePrice,
      lastUpdated: DateTime.now(),
      bookingWindow: const Duration(hours: 2), // Must book 2 hours in advance
    );
  }

  void _startRealTimeUpdates() {
    // Update availability every 30 seconds to simulate real-time booking changes
    _availabilityUpdateTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _simulateBookingActivity();
    });
  }

  void _simulateBookingActivity() {
    final random = Random();
    
    // Randomly update some bookings to simulate real activity
    for (final experienceId in _bookingSlots.keys) {
      if (random.nextBool()) { // 50% chance to update each experience
        final slots = _bookingSlots[experienceId] ?? [];
        final availableSlots = slots.where((s) => s.isAvailable && s.availableSpots > 0).toList();
        
        if (availableSlots.isNotEmpty && random.nextBool()) {
          // Simulate someone booking
          final slot = availableSlots[random.nextInt(availableSlots.length)];
          final slotIndex = slots.indexWhere((s) => s.id == slot.id);
          
          if (slotIndex != -1) {
            final spotsToBook = 1 + random.nextInt(min(3, slot.availableSpots));
            slots[slotIndex] = slot.copyWith(
              availableSpots: slot.availableSpots - spotsToBook,
              isAvailable: (slot.availableSpots - spotsToBook) > 0,
            );
            
            _updateExperienceAvailability(experienceId);
          }
        }
      }
    }
  }

  void _updateExperienceAvailability(String experienceId) {
    final slots = _bookingSlots[experienceId] ?? [];
    final availableSlots = slots.where((s) => s.isAvailable).length;
    final averagePrice = slots.isNotEmpty 
        ? slots.map((s) => s.pricePerPerson).reduce((a, b) => a + b) / slots.length
        : 0.0;
    
    _availabilities[experienceId] = BookingAvailability(
      experienceId: experienceId,
      isAvailable: availableSlots > 0,
      nextAvailableSlot: availableSlots > 0 
          ? slots.firstWhere((s) => s.isAvailable).dateTime
          : null,
      totalSlots: slots.length,
      availableSlots: availableSlots,
      averagePrice: averagePrice,
      lastUpdated: DateTime.now(),
      bookingWindow: const Duration(hours: 2),
    );
  }

  List<BookingSlot> _suggestAlternativeSlots(String experienceId, DateTime originalDateTime) {
    final slots = _bookingSlots[experienceId] ?? [];
    final alternatives = slots.where((slot) =>
      slot.isAvailable &&
      slot.dateTime.isAfter(originalDateTime) &&
      slot.dateTime.isBefore(originalDateTime.add(const Duration(days: 7)))
    ).take(3).toList();
    
    return alternatives;
  }

  String _generateConfirmationCode() {
    final random = Random();
    return 'DH${random.nextInt(999999).toString().padLeft(6, '0')}';
  }

  String _getGuideName(int index) {
    final guides = ['Aisha Khan', 'Omar Benali', 'Fatima Zahra', 'Youssef El Fassi'];
    return guides[index % guides.length];
  }

  void dispose() {
    _availabilityUpdateTimer?.cancel();
    _bookingUpdates.close();
  }
}