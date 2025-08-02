# DeadHour App - Comprehensive Screen and Route List

This document provides a complete list of all screens, their functionalities, and corresponding routes within the DeadHour application.

---

## Onboarding & Authentication

### 1. Splash Screen
- **Route:** `/splash`
- **File:** `lib/screens/auth/splash_screen.dart`
- **Functionality:** Displays the app logo and name while the app initializes. Navigates to either the Onboarding Screen or the Home Screen based on user's first-time status.

### 2. Onboarding Screen
- **Route:** `/onboarding`
- **File:** `lib/screens/auth/onboarding_screen.dart`
- **Functionality:** A multi-page introduction to the app's value proposition. New users are then directed to the main app in a guest/anonymous state.

### 3. Login Screen
- **Route:** `/login`
- **File:** `lib/screens/auth/login_screen.dart`
- **Functionality:** Allows existing users to log in. Triggered when a guest user attempts an action requiring an account (e.g., booking).

### 4. Register Screen
- **Route:** `/register`
- **File:** `lib/screens/auth/register_screen.dart`
- **Functionality:** Allows new users to create an account. Triggered when a guest user attempts an action requiring an account.

### 5. Verify Email Screen
- **Route:** `/verify-email`
- **File:** `lib/screens/auth/verify_email_screen.dart`
- **Functionality:** Prompts the user to check their email and enter a verification code or click a link to confirm their account after registration.

### 6. Forgot Password Screen
- **Route:** `/forgot-password`
- **File:** `lib/screens/auth/forgot_password_screen.dart`
- **Functionality:** The first step in the password reset flow where a user enters their email address to receive a verification code.

### 7. Reset Password Screen
- **Route:** `/reset-password`
- **File:** `lib/screens/auth/reset_password_screen.dart`
- **Functionality:** The second step in the password reset flow where the user enters the verification code and their new password.

---

## Developer & Navigation

### 8. Developer Menu Screen
- **Route:** `/dev-menu`
- **File:** `lib/screens/dev/dev_menu_screen.dart`
- **Functionality:** The main navigation hub for the mockup. It displays a simple, scrollable list of buttons, each navigating to a specific screen in the app. This replaces the user-facing bottom navigation for development and testing purposes.

---

## Venues

### 10. Venue Discovery Screen
- **Route:** `/venues`
- **File:** `lib/screens/home/venue_discovery_screen.dart`
- **Functionality:** Shows a list or map of venues, with advanced filtering.

### 15. Venue Detail Screen
- **Route:** `/venues/:venueId`
- **File:** `lib/screens/venues/venue_detail_screen.dart`
- **Functionality:** Shows detailed information about a specific venue, including deals, reviews, and cultural info.

### 21. Create/Edit Venue Profile Screen
- **Route:** `/business/venue/edit`
- **File:** `lib/screens/business/edit_venue_screen.dart`
- **Functionality:** A form for business owners to create and manage their venue's profile.

---

## Deals

### 9. Deals Screen
- **Route:** `/deals`
- **File:** `lib/screens/home/deals_screen.dart`
- **Functionality:** Displays a list of active deals, with filtering and sorting options.

### 22. Create Deal Screen
- **Route:** `/business/create-deal`
- **File:** `lib/screens/business/create_deal_screen.dart`
- **Functionality:** A form for business owners to create new deals for their dead hours.

### 23. Deal Management Screen
- **Route:** `/business/deals`
- **File:** `lib/screens/business/deal_management_screen.dart`
- **Functionality:** Allows business owners to view, edit, pause, or delete their active and past deals.

---

## Community & Rooms

### 11. Community Rooms Screen
- **Route:** `/community`
- **File:** `lib/screens/community/rooms_screen.dart`
- **Functionality:** Hub for all community rooms. Guests can view, but must log in to join or chat.

### 17. Room Detail Screen
- **Route:** `/community/room/:roomId`
- **File:** `lib/screens/community/room_detail_screen.dart`
- **Functionality:** Displays information about a specific community room.

### 18. Room Chat Screen
- **Route:** `/room/:roomId/chat`
- **File:** `lib/screens/community/room_chat_screen.dart`
- **Functionality:** The chat interface for a community room (requires login).

### 56. Room Management Screen
- **Route:** `/admin/rooms`
- **File:** `lib/screens/admin/room_management_screen.dart`
- **Functionality:** Admin-only screen to create, edit, and manage community rooms.

---

## Bookings

### 19. Booking Flow Screen
- **Route:** `/booking`
- **File:** `lib/screens/home/booking_flow_screen.dart`
- **Functionality:** A multi-step process for booking a deal (requires login).

### 24. Booking Management Screen
- **Route:** `/business/bookings`
- **File:** `lib/screens/business/booking_management_screen.dart`
- **Functionality:** A dashboard for businesses to view, manage, and confirm or decline incoming bookings.

### 25. Business Booking Detail Screen
- **Route:** `/business/bookings/:bookingId`
- **File:** `lib/screens/business/business_booking_detail_screen.dart`
- **Functionality:** Shows the complete details of a specific booking for the business to review.

### 32. Guide Bookings Screen
- **Route:** `/guide/bookings`
- **File:** `lib/screens/guide/guide_bookings_screen.dart`
- **Functionality:** Allows guides to see their schedule, manage booking requests, and view their upcoming appointments.

### 42. My Bookings Screen
- **Route:** `/profile/bookings`
- **File:** `lib/screens/profile/my_bookings_screen.dart`
- **Functionality:** Allows consumers to view their upcoming and past bookings.

### 43. Consumer Booking Detail Screen
- **Route:** `/profile/bookings/:bookingId`
- **File:** `lib/screens/profile/consumer_booking_detail_screen.dart`
- **Functionality:** Shows detailed information about a specific booking, including QR code for check-in, venue details, and options to cancel or contact the business.

### 62. Group Booking Screen
- **Route:** `/group-booking`
- **File:** `lib/screens/social/group_booking_screen.dart`
- **Functionality:** A screen for coordinating and managing group bookings.

---

## Reviews

### 26. Reply to Review Screen
- **Route:** `/business/reviews/:reviewId/reply`
- **File:** `lib/screens/business/reply_to_review_screen.dart`
- **Functionality:** A form for business owners to write and submit a public reply to a specific user review.

### 44. Write Review Screen
- **Route:** `/review/write`
- **File:** `lib/screens/reviews/write_review_screen.dart`
- **Functionality:** A form for users to write and submit a review for a venue or experience after their booking is complete.

---

## User Profile & Roles

### 14. Profile Screen
- **Route:** `/profile`
- **File:** `lib/screens/profile/profile_screen.dart`
- **Functionality:** User's profile. For guests, this screen is a prompt to log in or register. For logged-in users, it provides access to settings, role management, and activity history.

### 16. Public User Profile Screen
- **Route:** `/user/:userId`
- **File:** `lib/screens/profile/public_user_profile_screen.dart`
- **Functionality:** Displays a user's public profile, showing their roles (e.g., Guide), activity, and reviews.

### 40. Edit Profile Screen
- **Route:** `/profile/edit`
- **File:** `lib/screens/profile/edit_profile_screen.dart`
- **Functionality:** Allows users to update their personal information, such as name, profile picture, and bio.

### 45. Role Marketplace Screen
- **Route:** `/roles`
- **File:** `lib/screens/profile/role_marketplace_screen.dart`
- **Functionality:** A central marketplace where existing, logged-in users can browse, learn about, and activate new roles (e.g., Business, Guide).

### 46. Role Switching Screen
- **Route:** `/roles/switching`
- **File:** `lib/screens/profile/role_switching_screen.dart`
- **Functionality:** Allows users to switch between their active roles.

### 47. Premium Role Screen
- **Route:** `/roles/premium`
- **File:** `lib/screens/profile/premium_role_screen.dart`
- **Functionality:** A screen detailing the benefits of the Premium role and allowing users to upgrade.

---

## Business Role

### 20. Business Dashboard Screen
- **Route:** `/business`
- **File:** `lib/screens/business/business_dashboard_screen.dart`
- **Functionality:** The main dashboard for business owners to manage their venue, deals, and analytics.

### 27. Revenue Optimization Screen
- **Route:** `/business/optimization`
- **File:** `lib/screens/business/revenue_optimization_screen.dart`
- **Functionality:** Provides tools and insights for businesses to optimize their revenue.

### 28. Analytics Dashboard Screen
- **Route:** `/business/analytics`
- **File:** `lib/screens/business/analytics_dashboard_screen.dart`
- **Functionality:** Detailed analytics for business performance.

### 29. Business Payouts & Earnings Screen
- **Route:** `/business/payouts`
- **File:** `lib/screens/business/business_payouts_screen.dart`
- **Functionality:** Allows business owners to view their earnings, manage payout methods, and see their transaction history.

---

## Guide Role & Tourism

### 12. Tourism Screen
- **Route:** `/tourism`
- **File:** `lib/screens/tourism/tourism_screen.dart`
- **Functionality:** A dedicated section for tourists, featuring local experts and authentic experiences.

### 30. Guide Role Screen
- **Route:** `/guide`
- **File:** `lib/screens/guide/guide_role_screen.dart`
- **Functionality:** Dashboard for users with the "Guide" role to manage their services and earnings.

### 31. Create/Edit Guide Profile Screen
- **Route:** `/guide/profile/edit`
- **File:** `lib/screens/guide/edit_guide_profile_screen.dart`
- **Functionality:** Allows guides to create and manage their public profile, services, availability, and pricing.

### 33. Guide Payouts & Earnings Screen
- **Route:** `/guide/payouts`
- **File:** `lib/screens/guide/guide_payouts_screen.dart`
- **Functionality:** Allows guides to view their earnings, manage payout methods, and see their transaction history.

### 34. Local Expert Screen
- **Route:** `/local-expert`
- **File:** `lib/screens/tourism/local_expert_screen.dart`
- **Functionality:** A directory of local experts and guides that tourists can connect with.

### 35. Social Discovery Screen
- **Route:** `/social-discovery`
- **File:** `lib/screens/social/social_discovery_screen.dart`
- **Functionality:** A dedicated screen for social features, including finding connections and creating experiences.

### 37. Create Experience Screen
- **Route:** `/create-experience`
- **File:** `lib/screens/social/create_experience_screen.dart`
- **Functionality:** A form that allows users (likely guides or consumers) to propose and outline a new custom experience or event.

### 38. Tourist Home Screen
- **Route:** `/tourist-home`
- **File:** `lib/screens/home/tourist_home_screen.dart`
- **Functionality:** A specialized home screen for users identified as tourists.

---

## Settings & Legal

### 39. Settings Screen
- **Route:** `/settings`
- **File:** `lib/screens/profile/settings_screen.dart`
- **Functionality:** Main settings page, providing navigation to various account and app settings.

### 41. Change Password Screen
- **Route:** `/settings/change-password`
- **File:** `lib/screens/settings/change_password_screen.dart`
- **Functionality:** Allows a logged-in user to change their password.

### 48. Payment Methods Screen
- **Route:** `/settings/payment-methods`
- **File:** `lib/screens/settings/payment_methods_screen.dart`
- **Functionality:** Allows users to add, remove, and manage their saved payment methods.

### 49. Notification Settings Screen
- **Route:** `/settings/notifications`
- **File:** `lib/screens/settings/notification_settings_screen.dart`
- **Functionality:** Allows users to customize which push and email notifications they receive.

### 50. Privacy Settings Screen
- **Route:** `/settings/privacy`
- **File:** `lib/screens/settings/privacy_settings_screen.dart`
- **Functionality:** Provides options for managing data privacy and sharing preferences.

### 51. Accessibility Settings Screen
- **Route:** `/settings/accessibility`
- **File:** `lib/screens/settings/accessibility_settings_screen.dart`
- **Functionality:** Settings for accessibility features like high contrast and large text.

### 52. Offline Settings Screen
- **Route:** `/settings/offline`
- **File:** `lib/screens/settings/offline_settings_screen.dart`
- **Functionality:** Manage offline data and sync settings.

### 53. About & Legal Screen
- **Route:** `/settings/about`
- **File:** `lib/screens/settings/about_legal_screen.dart`
- **Functionality:** Displays the app version, terms of service, privacy policy, and other legal information.

---

## Admin

### 54. User Management Screen
- **Route:** `/admin/users`
- **File:** `lib/screens/admin/user_management_screen.dart`
- **Functionality:** Admin-only dashboard to search, view, and manage user accounts and roles.

### 55. Content Moderation Screen
- **Route:** `/admin/moderation`
- **File:** `lib/screens/admin/content_moderation_screen.dart`
- **Functionality:** Admin-only queue to review and act on flagged content (reviews, chat messages, etc.).

### 57. Application Review Screen
- **Route:** `/admin/applications`
- **File:** `lib/screens/admin/application_review_screen.dart`
- **Functionality:** Admin-only screen to review and approve/deny applications for special roles like Cultural Ambassador.

### 58. Network Effects Dashboard Screen
- **Route:** `/admin`
- **File:** `lib/screens/admin/network_effects_dashboard_screen.dart`
- **Functionality:** An admin-only screen to monitor the platform's network effects.

### 59. Community Health Dashboard Screen
- **Route:** `/admin/community-health`
- **File:** `lib/screens/admin/community_health_dashboard_screen.dart`
- **Functionality:** An admin screen to monitor the health and engagement of community rooms.

---

## Miscellaneous & Utilities

### 13. Notifications Screen
- **Route:** `/notifications`
- **File:** `lib/screens/notifications/notifications_screen.dart`
- **Functionality:** Displays all user notifications (requires login).

### 36. User Search Screen
- **Route:** `/user-search`
- **File:** `lib/screens/social/user_search_screen.dart`
- **Functionality:** Allows users to search for other users on the platform to connect with.

### 60. Payment Screen
- **Route:** `/payment`
- **File:** `lib/screens/payment/payment_screen.dart`
- **Functionality:** Handles the payment process for bookings and subscriptions.

### 61. Cultural Ambassador Application Screen
- **Route:** `/cultural-ambassador-application`
- **File:** `lib/screens/cultural/cultural_ambassador_application_screen.dart`
- **Functionality:** A form for users to apply to become a cultural ambassador.

---

## Deprecated / For Future Use

### Main Navigation Screen (Future Implementation)
- **Route:** `/home`, `/deals`, `/venues`, `/community`, `/tourism`, `/notifications`, `/profile`
- **File:** `lib/screens/home/main_navigation_screen.dart`
- **Functionality:** The main container for the app's primary sections, featuring a bottom navigation bar. Accessible to both guest and logged-in users.

---