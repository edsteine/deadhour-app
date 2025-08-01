import 'package:flutter/material.dart';

import '../services/real_time_booking_service.dart';
import 'booking/booking_action_button.dart';
import 'booking/booking_availability_status.dart';
import 'booking/booking_contact_information.dart';
import 'booking/booking_date_selection.dart';
import 'booking/booking_dialogs.dart';
import 'booking/booking_header.dart';
import 'booking/booking_participant_selection.dart';
import 'booking/booking_price_summary.dart';
import 'booking/booking_special_requests.dart';
import 'booking/booking_time_slot_selection.dart';

/// Real-time booking widget for tourism experiences
/// Addresses critical missing instant booking from TAB_ANALYSIS_REPORT.md
class RealTimeBookingWidget extends StatefulWidget {
  final String experienceId;
  final String experienceTitle;
  final String experienceDescription;
  final String userId;

  const RealTimeBookingWidget({
    super.key,
    required this.experienceId,
    required this.experienceTitle,
    required this.experienceDescription,
    required this.userId,
  });

  @override
  State<RealTimeBookingWidget> createState() => _RealTimeBookingWidgetState();
}

class _RealTimeBookingWidgetState extends State<RealTimeBookingWidget> {
  final RealTimeBookingService _bookingService = RealTimeBookingService();
  BookingAvailability? _availability;
  List<BookingSlot> _selectedDateSlots = [];
  DateTime _selectedDate = DateTime.now();
  BookingSlot? _selectedSlot;
  int _participants = 1;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specialRequestsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bookingService.initializeBookingService();
    _loadAvailability();
    _loadSlotsForSelectedDate();
  }

  void _loadAvailability() {
    final availability = _bookingService.getAvailability(widget.experienceId);
    setState(() {
      _availability = availability;
    });
  }

  void _loadSlotsForSelectedDate() {
    final slots = _bookingService.getAvailableSlots(widget.experienceId, _selectedDate);
    setState(() {
      _selectedDateSlots = slots;
      _selectedSlot = null; // Reset slot selection when date changes
    });
  }

  Future<void> _bookExperience() async {
    if (_selectedSlot == null) {
      _showError('Please select a time slot');
      return;
    }

    if (_nameController.text.trim().isEmpty || _emailController.text.trim().isEmpty) {
      _showError('Please fill in your name and email');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await _bookingService.bookExperience(
      experienceId: widget.experienceId,
      slotId: _selectedSlot!.id,
      userId: widget.userId,
      userName: _nameController.text.trim(),
      userEmail: _emailController.text.trim(),
      participants: _participants,
      specialRequests: _specialRequestsController.text.trim().isNotEmpty 
          ? {'requests': _specialRequestsController.text.trim()}
          : null,
    );

    setState(() {
      _isLoading = false;
    });

    if (result.success && result.booking != null) {
      BookingDialogs.showBookingSuccess(context, result.booking!, widget.experienceTitle);
    } else {
      BookingDialogs.showBookingError(
        context, 
        result, 
        _onAlternativeSlotSelected, 
        () => BookingDialogs.showSupportContact(context, _bookingService.support),
      );
    }
  }

  void _onAlternativeSlotSelected(BookingSlot slot) {
    setState(() {
      _selectedDate = DateTime(
        slot.dateTime.year,
        slot.dateTime.month,
        slot.dateTime.day,
      );
      _selectedSlot = slot;
    });
    _loadSlotsForSelectedDate();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          BookingHeader(
            experienceTitle: widget.experienceTitle,
            experienceDescription: widget.experienceDescription,
            onClose: () => Navigator.pop(context),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Real-time availability status
                  BookingAvailabilityStatus(availability: _availability),
                  const SizedBox(height: 24),
                  
                  // Date selection
                  BookingDateSelection(
                    selectedDate: _selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                      _loadSlotsForSelectedDate();
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Time slot selection
                  if (_selectedDateSlots.isNotEmpty) 
                    BookingTimeSlotSelection(
                      slots: _selectedDateSlots,
                      selectedSlot: _selectedSlot,
                      onSlotSelected: (slot) {
                        setState(() {
                          _selectedSlot = slot;
                        });
                      },
                    ),
                  const SizedBox(height: 24),
                  
                  // Participant count
                  BookingParticipantSelection(
                    participants: _participants,
                    selectedSlot: _selectedSlot,
                    onParticipantsChanged: (count) {
                      setState(() {
                        _participants = count;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Contact information
                  BookingContactInformation(
                    nameController: _nameController,
                    emailController: _emailController,
                  ),
                  const SizedBox(height: 24),
                  
                  // Special requests
                  BookingSpecialRequests(
                    specialRequestsController: _specialRequestsController,
                  ),
                  const SizedBox(height: 24),
                  
                  // Price summary
                  if (_selectedSlot != null) 
                    BookingPriceSummary(
                      selectedSlot: _selectedSlot!,
                      participants: _participants,
                    ),
                ],
              ),
            ),
          ),
          
          // Book button
          BookingActionButton(
            selectedSlot: _selectedSlot,
            participants: _participants,
            isLoading: _isLoading,
            onBook: _bookExperience,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }
}