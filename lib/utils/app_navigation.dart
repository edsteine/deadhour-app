import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/app_routes_constants.dart';


// Navigation Helper
class AppNavigation {
  static void goToHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  static void goToDeals(BuildContext context) {
    context.go(AppRoutes.deals);
  }

  static void goToVenues(BuildContext context) {
    context.go(AppRoutes.venues);
  }

  static void goToVenueDetail(BuildContext context, String venueId) {
    context.go('${AppRoutes.venueDetail}/$venueId');
  }

  static void goToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  static void goToRegister(BuildContext context) {
    context.go(AppRoutes.register);
  }

  static void goToUserType(BuildContext context) {
    context.go(AppRoutes.userType);
  }

  static void goToCommunity(BuildContext context) {
    context.go(AppRoutes.community);
  }

  static void goToRoomDetail(BuildContext context, String roomId) {
    context.go('${AppRoutes.roomDetail}/$roomId');
  }

  static void goToBusiness(BuildContext context) {
    context.go(AppRoutes.business);
  }

  static void goToCreateDeal(BuildContext context) {
    context.go(AppRoutes.createDeal);
  }

  static void goToRevenueOptimization(BuildContext context) {
    context.go(AppRoutes.revenueOptimization);
  }

  static void goToBusinessAnalytics(BuildContext context) {
    context.go(AppRoutes.businessAnalytics);
  }

  static void goToTourism(BuildContext context) {
    context.go(AppRoutes.tourism);
  }

  static void goToLocalExpert(BuildContext context) {
    context.go(AppRoutes.localExpert);
  }

  static void goToSocialDiscovery(BuildContext context) {
    context.go(AppRoutes.socialDiscovery);
  }

  static void goToGuide(BuildContext context) {
    context.go(AppRoutes.guide);
  }

  static void goToProfile(BuildContext context) {
    context.go(AppRoutes.profile);
  }

  static void goToSettings(BuildContext context) {
    context.go(AppRoutes.settings);
  }

  static void goToNotifications(BuildContext context) {
    context.go(AppRoutes.notifications);
  }

  static void goToGroupBooking(BuildContext context) {
    context.go(AppRoutes.groupBooking);
  }

  static void goToAccessibilitySettings(BuildContext context) {
    context.push(AppRoutes.accessibilitySettings);
  }

  static void goToOfflineSettings(BuildContext context) {
    context.push(AppRoutes.offlineSettings);
  }

  static void goToBookingFlow(BuildContext context, Deal deal) {
    context.push(AppRoutes.bookingFlow, extra: deal);
  }

  static void goToAdmin(BuildContext context) {
    context.go(AppRoutes.admin);
  }

  static void pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }
}