# DeadHour App - Comprehensive Screen and Route List

This document provides a complete list of all screens, their functionalities, and corresponding routes within the DeadHour application.

---

## Authentication Flow

### 1. Splash Screen
- **Route:** `/splash`
- **File:** `lib/screens/auth/splash_screen.dart`
- **Functionality:** Displays the app logo and name while the app initializes. Navigates to either the Onboarding Screen or the Home Screen based on user's first-time status.

### 2. Onboarding Screen
- **Route:** `/onboarding`
- **File:** `lib/screens/auth/onboarding_screen.dart`
- **Functionality:** A multi-page introduction to the app's value proposition, explaining the dual-problem concept (business dead hours + social discovery).

### 3. Role Marketplace Screen
- **Route:** `/user-type`
- **File:** `lib/screens/auth/role_marketplace_screen.dart`
- **Functionality:** Allows new users to select their initial role (Consumer, Business, Guide) or existing users to add new roles.

### 4. Login Screen
- **Route:** `/login`
- **File:** `lib/screens/auth/login_screen.dart`
- **Functionality:** Allows existing users to log in using email/password or social providers.

### 5. Register Screen
- **Route:** `/register`
- **File:** `lib/screens/auth/register_screen.dart`
- **Functionality:** Allows new users to create an account.

### 6. Forgot Password Screen
- **Route:** `/forgot-password`
- **File:** `lib/screens/auth/forgot_password_screen.dart`
- **Functionality:** A multi-step flow for users to reset their password securely. Users enter their email to receive a verification code, then enter the code and a new password.

---

## Main Application Screens

### 7. Main Navigation Screen
- **Route:** `/home`, `/deals`, `/venues`, `/community`, `/tourism`, `/notifications`, `/profile`
- **File:** `lib/screens/home/main_navigation_screen.dart`
- **Functionality:** The main container for the app's primary sections, featuring a bottom navigation bar.

### 8. Deals Screen
- **Route:** `/deals` (within MainNavigationScreen)
- **File:** `lib/screens/home/deals_screen.dart`
- **Functionality:** Displays a list of active deals, with filtering and sorting options.

### 9. Venue Discovery Screen
- **Route:** `/venues` (within MainNavigationScreen)
- **File:** `lib/screens/home/venue_discovery_screen.dart`
- **Functionality:** Shows a list or map of venues, with advanced filtering.

### 10. Community Rooms Screen
- **Route:** `/community` (within MainNavigationScreen)
- **File:** `lib/screens/community/rooms_screen.dart`
- **Functionality:** Hub for all community rooms, with tabs for different room categories.

### 11. Tourism Screen
- **Route:** `/tourism` (within MainNavigationScreen)
- **File:** `lib/screens/tourism/tourism_screen.dart`
- **Functionality:** A dedicated section for tourists, featuring local experts, authentic experiences, and cultural tips.

### 12. Notifications Screen
- **Route:** `/notifications` (within MainNavigationScreen)
- **File:** `lib/screens/notifications/notifications_screen.dart`
- **Functionality:** Displays all user notifications, categorized for easy viewing.

### 13. Profile Screen
- **Route:** `/profile` (within MainNavigationScreen)
- **File:** `lib/screens/profile/profile_screen.dart`
- **Functionality:** User's profile, with access to settings, role management, and activity history.

---

## Detailed View Screens

### 14. Venue Detail Screen
- **Route:** `/venue-detail/:venueId`
- **File:** `lib/screens/venues/venue_detail_screen.dart`
- **Functionality:** Shows detailed information about a specific venue, including deals, reviews, and cultural info.

### 15. Room Detail Screen
- **Route:** `/room/:roomId`
- **File:** `lib/screens/community/room_detail_screen.dart`
- **Functionality:** Displays information about a specific community room.

### 16. Room Chat Screen
- **Route:** `/room/:roomId/chat`
- **File:** `lib/screens/community/room_chat_screen.dart`
- **Functionality:** The chat interface for a community room, where users can discuss deals and experiences.

### 17. Booking Flow Screen
- **Route:** `/booking`
- **File:** `lib/screens/home/booking_flow_screen.dart`
- **Functionality:** A multi-step process for booking a deal, including group coordination and payment.

---

## Business Role Screens

### 18. Business Dashboard Screen
- **Route:** `/business`
- **File:** `lib/screens/business/business_dashboard_screen.dart`
- **Functionality:** The main dashboard for business owners to manage their venue, deals, and analytics.

### 19. Create/Edit Venue Profile Screen
- **Route:** `/business/venue/edit`
- **File:** `lib/screens/business/edit_venue_screen.dart`
- **Functionality:** A form for business owners to create and manage their venue's profile, including name, address, photos, description, and operating hours.

### 20. Create Deal Screen
- **Route:** `/business/create-deal`
- **File:** `lib/screens/business/create_deal_screen.dart`
- **Functionality:** A form for business owners to create new deals for their dead hours.

### 21. Deal Management Screen
- **Route:** `/business/deals`
- **File:** `lib/screens/business/deal_management_screen.dart`
- **Functionality:** Allows business owners to view, edit, pause, or delete their active and past deals.

### 22. Booking Management Screen
- **Route:** `/business/bookings`
- **File:** `lib/screens/business/booking_management_screen.dart`
- **Functionality:** A dashboard for businesses to view, manage, and confirm incoming bookings.

### 23. Revenue Optimization Screen
- **Route:** `/business/optimization`
- **File:** `lib/screens/business/revenue_optimization_screen.dart`
- **Functionality:** Provides tools and insights for businesses to optimize their revenue.

### 24. Analytics Dashboard Screen
- **Route:** `/business/analytics`
- **File:** `lib/screens/business/analytics_dashboard_screen.dart`
- **Functionality:** Detailed analytics for business performance.

---

## Guide & Tourism Screens

### 25. Guide Role Screen
- **Route:** `/guide`
- **File:** `lib/screens/guide/guide_role_screen.dart`
- **Functionality:** Dashboard for users with the "Guide" role to manage their services and earnings.

### 26. Create/Edit Guide Profile Screen
- **Route:** `/guide/profile/edit`
- **File:** `lib/screens/guide/edit_guide_profile_screen.dart`
- **Functionality:** Allows guides to create and manage their public profile, services, availability, and pricing.

### 27. Local Expert Screen
- **Route:** `/local-expert`
- **File:** `lib/screens/tourism/local_expert_screen.dart`
- **Functionality:** A directory of local experts and guides that tourists can connect with.

### 28. Social Discovery Screen
- **Route:** `/social-discovery`
- **File:** `lib/screens/social/social_discovery_screen.dart`
- **Functionality:** A dedicated screen for social features, including finding connections and creating experiences.

### 29. Tourist Home Screen
- **Route:** `/tourist-home`
- **File:** `lib/screens/home/tourist_home_screen.dart`
- **Functionality:** A specialized home screen for users identified as tourists.

---

## Consumer & Profile Management

### 30. Settings Screen
- **Route:** `/settings`
- **File:** `lib/screens/profile/settings_screen.dart`
- **Functionality:** Main settings page for the app.

### 31. My Bookings Screen
- **Route:** `/profile/bookings`
- **File:** `lib/screens/profile/my_bookings_screen.dart`
- **Functionality:** Allows consumers to view their upcoming and past bookings, and manage booking details.

### 32. Payment Methods Screen
- **Route:** `/settings/payment-methods`
- **File:** `lib/screens/settings/payment_methods_screen.dart`
- **Functionality:** Allows users to add, remove, and manage their saved payment methods.

### 33. Accessibility Settings Screen
- **Route:** `/settings/accessibility`
- **File:** `lib/screens/settings/accessibility_settings_screen.dart`
- **Functionality:** Settings for accessibility features like high contrast and large text.

### 34. Offline Settings Screen
- **Route:** `/settings/offline`
- **File:** `lib/screens/settings/offline_settings_screen.dart`
- **Functionality:** Manage offline data and sync settings.

### 35. Role Switching Screen
- **Route:** `/roles/switching`
- **File:** `lib/screens/profile/role_switching_screen.dart`
- **Functionality:** Allows users to switch between their active roles.

### 36. Premium Role Screen
- **Route:** `/roles/premium`
- **File:** `lib/screens/profile/premium_role_screen.dart`
- **Functionality:** A screen detailing the benefits of the Premium role and allowing users to upgrade.

---

## Admin & Other Screens

### 37. User Management Screen
- **Route:** `/admin/users`
- **File:** `lib/screens/admin/user_management_screen.dart`
- **Functionality:** Admin-only dashboard to search, view, and manage user accounts and roles.

### 38. Content Moderation Screen
- **Route:** `/admin/moderation`
- **File:** `lib/screens/admin/content_moderation_screen.dart`
- **Functionality:** Admin-only queue to review and act on flagged content (reviews, chat messages, etc.).

### 39. Room Management Screen
- **Route:** `/admin/rooms`
- **File:** `lib/screens/admin/room_management_screen.dart`
- **Functionality:** Admin-only screen to create, edit, and manage community rooms.

### 40. Network Effects Dashboard Screen
- **Route:** `/admin`
- **File:** `lib/screens/admin/network_effects_dashboard_screen.dart`
- **Functionality:** An admin-only screen to monitor the platform's network effects.

### 41. Community Health Dashboard Screen
- **Route:** `/admin/community-health`
- **File:** `lib/screens/admin/community_health_dashboard_screen.dart`
- **Functionality:** An admin screen to monitor the health and engagement of community rooms.

### 42. Payment Screen
- **Route:** `/payment`
- **File:** `lib/screens/payment/payment_screen.dart`
- **Functionality:** Handles the payment process for bookings and subscriptions.

### 43. Cultural Ambassador Application Screen
- **Route:** `/cultural-ambassador-application`
- **File:** `lib/screens/cultural/cultural_ambassador_application_screen.dart`
- **Functionality:** A form for users to apply to become a cultural ambassador.

### 44. Group Booking Screen
- **Route:** `/group-booking`
- **File:** `lib/screens/social/group_booking_screen.dart`
- **Functionality:** A screen for coordinating and managing group bookings.

---
