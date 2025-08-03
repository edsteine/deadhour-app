# DeadHour Complete Master Architecture & Screen Reference

**Version 4.0 - Unified Multi-Role System with Complete Screen Catalog**  
**Total Screens: 82 Active + 1 Deprecated**

---

## 🏗️ SYSTEM ARCHITECTURE OVERVIEW

### Core Principle: One User, Multiple Contexts

```yaml
Master Account:
  - Single email/password login
  - Verified identity (KYC once)
  - Core profile data
  - Payment methods (shared)
  
Contexts (User can have multiple):
  - Personal Context (Consumer) - Always exists
    - Personal bookings
    - Reviews as customer
    - Saved favorites
    
  - Business Contexts (0 to many)
    - Each business is separate
    - Own team members
    - Separate analytics
    - Independent payouts
    
  - Professional Context (0 or 1)
    - Guide/Cultural Ambassador
    - Tour offerings
    - Professional certifications
```

### Database Structure

```dart
// Core User Model
class User {
  String userId;
  String email;
  String phoneNumber;
  bool emailVerified;
  DateTime createdAt;
  
  // Personal Profile (always exists)
  PersonalProfile personalProfile;
  
  // Business Profiles (can have multiple)
  List<BusinessProfile> businessProfiles;
  
  // Professional Profiles
  GuideProfile? guideProfile;
  CulturalAmbassadorProfile? culturalProfile;
  
  // Current Active Context
  ActiveContext currentContext;
  
  // Shared across all contexts
  List<PaymentMethod> paymentMethods;
  NotificationSettings notificationSettings;
  PrivacySettings privacySettings;
}

enum ContextType {
  personal,
  business,
  guide,
  cultural
}

class ActiveContext {
  ContextType type;
  String? contextId; // businessId or guideId if applicable
  String contextName; // "Personal" or "John's Café"
}
```

---

## 📁 FOLDER STRUCTURE

```
lib/screens/
├── auth/                    # Authentication & account creation
├── context_switcher/        # Role/context switching
├── personal/               # Consumer context screens
│   ├── bookings/          # Personal bookings
│   ├── profile/           # Personal profile
│   └── discovery/         # Browse venues/deals
├── business/               # Business context screens
│   ├── [businessId]/      # Per-business screens
│   ├── onboarding/        # New business setup
│   └── switcher/          # Multi-business switching
├── guide/                  # Guide context screens
│   ├── profile/           # Guide profile
│   ├── bookings/          # Tour bookings
│   └── experiences/       # Tour management
├── cultural/               # Cultural ambassador screens
├── community/              # Social features
├── admin/                  # Admin screens
├── shared/                 # Shared components
│   ├── settings/          # Account-wide settings
│   ├── notifications/     # Unified notifications
│   └── errors/            # Error states
└── dev/                    # Development tools
```

---

## 📱 COMPLETE SCREEN CATALOG

## MODULE 1: AUTHENTICATION (`/auth`)
*Core authentication - no context needed*

### 1. Splash Screen
- **Route:** `/splash`
- **File:** `lib/screens/auth/splash_screen.dart`
- **Multi-Role Support:** Detects user's active contexts and last used role
- **Description:** The first screen users see when opening the app. Displays the DeadHour logo and app name while initializing app data and checking user authentication status. Automatically navigates to either Onboarding (for new users), Context Switcher (for multi-role users), or appropriate dashboard based on last active context.

### 2. Onboarding Screen
- **Route:** `/onboarding`
- **File:** `lib/screens/auth/onboarding_screen.dart`
- **Multi-Role Support:** Introduces the concept of multiple roles
- **Description:** Multi-page swipeable introduction for first-time users showcasing app features like discovering deals during dead hours, connecting with local businesses, and joining community rooms. Explains how users can be consumers, business owners, and guides all in one account. Includes skip option and progress indicators. Ends with options to continue as guest or create account.

### 3. Login Screen
- **Route:** `/login`
- **File:** `lib/screens/auth/login_screen.dart`
- **Multi-Role Support:** Single login for all roles
- **Description:** Unified login interface with email/password fields, remember me checkbox, and social login options (Google, Facebook, Apple). After login, checks user's available contexts and navigates to role selector if multiple contexts exist, or directly to appropriate dashboard. Includes forgot password link and option to switch to registration.

### 4. Register Screen
- **Route:** `/register`
- **File:** `lib/screens/auth/register_screen.dart`
- **Multi-Role Support:** Creates master account with personal context
- **Description:** Account creation form with fields for name, email, password, and password confirmation. Automatically creates personal (consumer) context. Includes terms of service agreement checkbox, social registration options, and option to indicate interest in business/guide roles for streamlined onboarding. Validates email format and password strength in real-time.

### 5. Verify Email Screen
- **Route:** `/verify-email`
- **File:** `lib/screens/auth/verify_email_screen.dart`
- **Description:** Post-registration email verification interface. Shows instructions to check email, provides 6-digit code input field, and resend code option with cooldown timer. Once verified, all contexts under this account are verified. Automatically proceeds to profile setup upon successful verification.

### 6. Forgot Password Screen
- **Route:** `/forgot-password`
- **File:** `lib/screens/auth/forgot_password_screen.dart`
- **Description:** Password recovery initiation screen. Users enter their registered email address to receive a password reset code. Includes validation for email format and error handling for non-existent accounts. Shows success message and navigation to reset password screen.

### 7. Reset Password Screen
- **Route:** `/reset-password`
- **File:** `lib/screens/auth/reset_password_screen.dart`
- **Description:** Final step of password recovery. Users enter the verification code from email and create a new password for master account affecting all contexts. Includes password strength indicator, confirmation field, and automatic login upon successful reset.

---

## MODULE 2: CONTEXT SWITCHER (`/context_switcher`)
*Switching between roles/contexts*

### 8. Context Switcher Screen ⭐ NEW
- **Route:** `/switch-context`
- **File:** `lib/screens/context_switcher/context_switcher_screen.dart`
- **Multi-Role Feature:** Core navigation between roles
- **Description:** Beautiful card-based interface showing all user's contexts: Personal (shopping bag icon), Business profiles (briefcase icons) with venue names, Guide profile (map icon). Shows active context highlighted, quick stats per context (bookings today, revenue, pending actions), and one-tap switching. Accessible via profile picture dropdown or swipe gesture.

### 9. Add Context Screen ⭐ NEW
- **Route:** `/add-context`
- **File:** `lib/screens/context_switcher/add_context_screen.dart`
- **Multi-Role Feature:** Expand user capabilities
- **Description:** Hub for adding new roles to existing account. Shows available contexts: Add Business (for venue owners), Become a Guide (for tour guides), Cultural Ambassador (application). Each option shows requirements, benefits, approval process, and starts appropriate onboarding flow. Includes progress tracking for applications in review.

### 10. Context Selector Widget
- **Route:** N/A (Widget)
- **File:** `lib/screens/context_switcher/context_selector_widget.dart`
- **Description:** Dropdown widget shown in app header for quick context switching. Shows current context with colored badge and quick access to switch without leaving current screen.

---

## MODULE 3: PERSONAL/CONSUMER CONTEXT (`/personal`)
*Everything for personal/consumer activities*

### Personal Home & Profile

### 11. Personal Home Screen
- **Route:** `/personal/home`
- **File:** `lib/screens/personal/home/personal_home_screen.dart`
- **Context:** Personal/Consumer
- **Description:** Dynamic consumer homepage with personalized content based on preferences and behavior. Shows trending deals, nearby venues currently in dead hours, upcoming personal bookings with countdown timers, recommended experiences based on past activity, and quick action buttons. If user has business context, smart filtering prevents showing own business deals. Adapts layout based on time of day (lunch deals in morning, dinner deals in afternoon).

### 12. Personal Profile Screen
- **Route:** `/personal/profile`
- **File:** `lib/screens/personal/profile/personal_profile_screen.dart`
- **Multi-Role Support:** Shows all contexts in one place
- **Description:** Master profile dashboard showing user photo, name, verified status, and cards for each context (Personal, Businesses, Guide) with quick stats. Shows combined statistics across all roles: total bookings made, reviews written, businesses owned, tours guided. Quick access to context switcher, settings, and add new context. For guests, shows login/register prompt with benefits.

### 13. Edit Personal Profile Screen
- **Route:** `/personal/profile/edit`
- **File:** `lib/screens/personal/profile/edit_personal_profile_screen.dart`
- **Multi-Role Support:** Edits affect all contexts where applicable
- **Description:** Comprehensive profile editing interface. Users can update profile picture (with camera/gallery options), display name, bio, interests/preferences, dietary restrictions, location preferences, and privacy settings. Changes to master data (name, photo) reflect across all contexts. Includes validation and unsaved changes warning.

### 14. Public Profile Screen
- **Route:** `/user/:userId`
- **File:** `lib/screens/personal/profile/public_profile_screen.dart`
- **Multi-Role Support:** Shows user's public roles
- **Description:** Public-facing view of another user's profile. Shows their public information, active roles (especially Guide/Cultural Ambassador), recent reviews as consumer, shared experiences, owned businesses (if public), and option to message or book their services if they're a guide. Privacy settings control visibility.

### Personal Bookings (Consumer Side)

### 15. My Bookings List Screen
- **Route:** `/personal/bookings`
- **File:** `lib/screens/personal/bookings/my_bookings_list_screen.dart`
- **Context:** Personal/Consumer only
- **Description:** Comprehensive booking history showing upcoming reservations (with countdown timers and weather info), past bookings (with review prompts), and cancelled bookings. Each item shows venue photo, deal details, date/time, party size, and status. Includes filtering by date range, search by venue name, and export to calendar. Clearly separated from business incoming bookings.

### 16. Booking Detail Screen (Consumer View)
- **Route:** `/personal/bookings/:bookingId`
- **File:** `lib/screens/personal/bookings/booking_detail_screen.dart`
- **Context:** Personal/Consumer only
- **Description:** Detailed view of a specific booking showing QR code for check-in, interactive map with directions, venue contact info with one-tap calling, deal terms and restrictions, booking date/time with add to calendar, special requests made, and cancellation policy with refund info. Includes options to modify booking, share with friends, or contact venue through in-app messaging.

### 17-21. Create Booking Flow (5 screens)
- **Route:** `/personal/booking/create/*`
- **Files:** `lib/screens/personal/bookings/create_booking_flow/*`
- **Description:** Multi-step booking wizard with progress indicator:
  1. **Select Date/Time:** Calendar view with available slots, dead hour highlighting, party size selector
  2. **Choose Deal:** Available deals for selected time, regular menu options, special offers
  3. **Add Requests:** Dietary restrictions, seating preferences, special occasions
  4. **Review Details:** Summary of all selections, terms acceptance, modification options
  5. **Payment:** Secure payment with saved cards, add new payment method, split bill option

### 22. Booking Confirmation Screen
- **Route:** `/personal/booking/confirmation`
- **File:** `lib/screens/personal/bookings/booking_confirmation_screen.dart`
- **Description:** Success screen after booking with animated confirmation, booking reference number, venue details, calendar integration prompt, and sharing options. Shows estimated preparation time and suggests arrival time based on distance.

### Discovery Screens

### 23. Venue Discovery Screen
- **Route:** `/personal/venues`
- **File:** `lib/screens/personal/discovery/venue_discovery_screen.dart`
- **Context:** Personal/Consumer
- **Description:** Interactive venue browser with map/list toggle view. Features advanced filters (cuisine type, price range, distance, rating, amenities), real-time availability indicators, dead hour highlighting with discount percentages, and current wait times. Shows venue cards with hero image, name, cuisine, rating, distance, and current best deal. If user owns venues, their businesses are marked with "Your Business" badge and booking is disabled.

### 24. Venue Detail Screen
- **Route:** `/personal/venues/:venueId`
- **File:** `lib/screens/personal/discovery/venue_detail_screen.dart`
- **Multi-Role Aware:** Different view if own venue
- **Description:** Comprehensive venue page with photo gallery, description, amenities list with icons, full menu with prices, current deals with countdown timers, reviews with sentiment analysis, cultural information and specialties, and peak/dead hour chart. Includes business hours with dead hour indicators, contact options, and share functionality. If viewing own business, shows "Edit Business" button and analytics preview instead of booking options.

### 25. Deals Browse Screen
- **Route:** `/personal/deals`
- **File:** `lib/screens/personal/discovery/deals_browse_screen.dart`
- **Context:** Personal/Consumer
- **Description:** Deal discovery interface showing all active offers with filters for category, discount percentage (20%, 30%, 50%+), time slots, distance, and validity period. Each deal card shows eye-catching discount badge, venue name and photo, deal description, savings amount, time remaining, and quick booking button. Own business deals (if any) are marked but not bookable by owner. Includes deal alerts setup for favorite venues.

### 26. Deal Detail Screen
- **Route:** `/personal/deals/:dealId`
- **File:** `lib/screens/personal/discovery/deal_detail_screen.dart`
- **Description:** Individual deal page showing full terms and conditions, validity period with calendar, applicable days/times, quantity limits, combination restrictions, and redemption process. Features savings calculator, similar deals, and venue information with map.

### 27. Search Results Screen
- **Route:** `/personal/search`
- **File:** `lib/screens/personal/discovery/search_results_screen.dart`
- **Description:** Unified search results showing venues, deals, experiences, and users matching the query. Features tab-based organization, relevance sorting with ML-based ranking, filter refinement, search history, and smart suggestions. Includes typo correction and "did you mean" suggestions.

### Favorites & Reviews

### 28. Favorites Screen
- **Route:** `/personal/favorites`
- **File:** `lib/screens/personal/favorites/favorites_screen.dart`
- **Context:** Personal/Consumer only
- **Description:** User's saved content organized by type: favorite venues (with current status), saved deals (with expiry alerts), bookmarked experiences, and followed guides. Shows availability status, current prices, and quick booking options. Includes collection creation, sharing capabilities, and smart notifications for deals at favorite places.

### 29. Write Review Screen
- **Route:** `/personal/reviews/write`
- **File:** `lib/screens/personal/reviews/write_review_screen.dart`
- **Context:** Personal/Consumer
- **Description:** Review composition interface with 5-star rating, multiple aspect ratings (food, service, ambiance, value), photo upload capability (up to 10 photos), and text review with AI-powered prompts. Includes authenticity verification (proof of visit), review guidelines, and points/badges earned for quality reviews. Cannot review own businesses.

### 30. My Reviews Screen
- **Route:** `/personal/reviews`
- **File:** `lib/screens/personal/reviews/my_reviews_screen.dart`
- **Description:** All reviews written by user as consumer with edit/delete options, business owner responses, helpful votes received, and contribution stats.

---

## MODULE 4: BUSINESS CONTEXT (`/business`)
*Business owner features*

### Business Onboarding

### 31. Create Business Screen ⭐ NEW
- **Route:** `/business/create`
- **File:** `lib/screens/business/onboarding/create_business_screen.dart`
- **Multi-Role Feature:** Add business to existing account
- **Description:** Wizard for adding new business context to account. Collects business name, type/category, address with map verification, contact information, business hours, and initial team members. Creates new business profile under master account with pending verification status.

### 32. Business Verification Screen
- **Route:** `/business/verify`
- **File:** `lib/screens/business/onboarding/business_verification_screen.dart`
- **Description:** Upload required business documents: business license, tax ID, proof of ownership, food service permit (if applicable). Shows verification progress and estimated approval time.

### 33. Business Setup Wizard
- **Route:** `/business/setup`
- **File:** `lib/screens/business/onboarding/business_setup_wizard_screen.dart`
- **Description:** Step-by-step business profile setup: upload photos, write description, add menu/services, set amenities, identify dead hours, create first deal. Includes completeness score and SEO tips.

### Business Switcher

### 34. Business Switcher Screen ⭐ NEW
- **Route:** `/business/switch`
- **File:** `lib/screens/business/switcher/business_switcher_screen.dart`
- **Multi-Role Feature:** Quick switch between owned businesses
- **Description:** Grid view of all owned businesses with venue photos, names, today's stats (bookings, revenue, new reviews), status indicators (issues, pending actions), and quick actions (view dashboard, create deal). Faster than full context switcher when managing multiple venues. Includes comparison mode for performance analysis.

### Business Dashboard & Profile

### 35. Business Dashboard Screen
- **Route:** `/business/:businessId/dashboard`
- **File:** `lib/screens/business/[businessId]/dashboard/business_dashboard_screen.dart`
- **Context:** Business
- **Description:** Command center for specific business showing today's bookings with arrival times, active deals performance with redemption rate, revenue metrics (today, week, month), urgent actions needed (reviews to respond to, low inventory), and quick stats cards. Features upcoming reservations list, recent reviews requiring response, and navigation to all business tools. Shows weather impact on expected traffic.

### 36. Business Profile Screen
- **Route:** `/business/:businessId/profile`
- **File:** `lib/screens/business/[businessId]/profile/business_profile_screen.dart`
- **Description:** Public-facing business profile as seen by consumers. Preview mode for testing changes before publishing.

### 37. Edit Business Profile Screen
- **Route:** `/business/:businessId/profile/edit`
- **File:** `lib/screens/business/[businessId]/profile/edit_business_profile_screen.dart`
- **Context:** Business
- **Description:** Comprehensive venue profile manager with sections for basic info (name, category, description), photos/videos (with professional tips), menu/services with pricing, amenities and features, business hours with holiday settings, dead hour identification with AI suggestions, cultural highlights and specialties, and SEO tags. Includes preview mode, completeness indicator, and competitor comparison.

### Business Bookings Management

### 38. Booking Management Screen
- **Route:** `/business/:businessId/bookings`
- **File:** `lib/screens/business/[businessId]/bookings/booking_management_screen.dart`
- **Context:** Business
- **Description:** Real-time booking dashboard with pending confirmations requiring action, today's arrivals with check-in status, upcoming reservations for the week, no-shows tracking with patterns, and waitlist management. Features quick confirm/decline buttons, customer history sidebar, table/resource management integration, and capacity optimization suggestions.

### 39. Business Booking Detail Screen
- **Route:** `/business/:businessId/bookings/:bookingId`
- **File:** `lib/screens/business/[businessId]/bookings/booking_detail_screen.dart`
- **Context:** Business
- **Description:** Detailed booking view showing complete customer profile with photo, booking history with this venue, lifetime value, special requests and dietary restrictions, payment status and method, and communication log. Includes options to modify booking, send pre-arrival message, add internal notes, and mark as VIP.

### 40. Booking Calendar Screen
- **Route:** `/business/:businessId/bookings/calendar`
- **File:** `lib/screens/business/[businessId]/bookings/booking_calendar_screen.dart`
- **Description:** Visual calendar showing all bookings with color coding by status, capacity visualization, and drag-drop rescheduling. Includes conflict detection and optimization suggestions.

### 41. Check-In Screen
- **Route:** `/business/:businessId/check-in`
- **File:** `lib/screens/business/[businessId]/bookings/check_in_screen.dart`
- **Description:** QR scanner for customer check-in with instant booking retrieval, deal validation, and welcome message trigger. Shows customer preferences and previous orders.

### Deals Management

### 42. Deals List Screen
- **Route:** `/business/:businessId/deals`
- **File:** `lib/screens/business/[businessId]/deals/deals_list_screen.dart`
- **Context:** Business
- **Description:** Deal inventory showing all active (with performance metrics), scheduled (upcoming deals), paused (temporarily disabled), and expired deals (with reactivation option). Each item displays redemption count, revenue generated, ROI calculation, and quick actions (edit, pause, duplicate, delete). Includes bulk operations and A/B test results.

### 43. Create Deal Screen
- **Route:** `/business/:businessId/deals/create`
- **File:** `lib/screens/business/[businessId]/deals/create_deal_screen.dart`
- **Context:** Business
- **Description:** Deal creation wizard for defining offer type (percentage, fixed amount, BOGO), target audience, validity period with date picker, specific time slots (dead hours highlighted), quantity limits, terms and conditions, and auto-renewal settings. Shows potential revenue impact calculator and competitor deal analysis.

### 44. Edit Deal Screen
- **Route:** `/business/:businessId/deals/:dealId/edit`
- **File:** `lib/screens/business/[businessId]/deals/edit_deal_screen.dart`
- **Description:** Modify existing deal with change history, impact preview, and customer notification options.

### 45. Deal Analytics Screen
- **Route:** `/business/:businessId/deals/:dealId/analytics`
- **File:** `lib/screens/business/[businessId]/deals/deal_analytics_screen.dart`
- **Description:** Deep analytics showing redemption timeline graph, customer demographics breakdown, revenue vs. discount analysis, repeat customer rate, and cross-sell performance. Features A/B testing setup and competitor benchmarking.

### Team Management

### 46. Team Management Screen ⭐ NEW
- **Route:** `/business/:businessId/team`
- **File:** `lib/screens/business/[businessId]/team/team_management_screen.dart`
- **Multi-Role Feature:** Invite team without sharing account
- **Description:** Manage team members for specific business showing current team with roles, pending invitations, activity logs, and performance metrics. Invite employees by email, set granular permissions (view only, manage bookings, edit deals, view finances), and track actions. Team members get limited access without seeing owner's personal or other business data.

### 47. Invite Team Member Screen
- **Route:** `/business/:businessId/team/invite`
- **File:** `lib/screens/business/[businessId]/team/invite_team_member_screen.dart`
- **Description:** Send team invitations with role selection, custom message, and permission presets (manager, staff, viewer).

### 48. Team Permissions Screen
- **Route:** `/business/:businessId/team/permissions`
- **File:** `lib/screens/business/[businessId]/team/team_permissions_screen.dart`
- **Description:** Granular permission matrix for team members: bookings (view/manage/delete), deals (create/edit/pause), analytics (view only/export), and financials (none/view/full).

### Analytics & Financials

### 49. Analytics Dashboard Screen
- **Route:** `/business/:businessId/analytics`
- **File:** `lib/screens/business/[businessId]/analytics/analytics_dashboard_screen.dart`
- **Context:** Business
- **Description:** Comprehensive analytics with revenue trends (daily/weekly/monthly/yearly), customer acquisition funnel, deal performance comparison, peak hours heat map, customer demographics, and competitor benchmarking. Features customizable date ranges, export options (PDF/Excel), and predictive insights with AI recommendations.

### 50. Revenue Optimization Screen
- **Route:** `/business/:businessId/revenue`
- **File:** `lib/screens/business/[businessId]/analytics/revenue_screen.dart`
- **Description:** AI-powered recommendations for maximizing revenue through optimal pricing suggestions, deal timing recommendations, inventory management, upselling opportunities, and capacity optimization. Shows potential impact of each suggestion with implementation guides and success probability.

### 51. Customer Insights Screen
- **Route:** `/business/:businessId/customers`
- **File:** `lib/screens/business/[businessId]/analytics/customer_insights_screen.dart`
- **Description:** Customer behavior analytics including lifetime value distribution, retention cohorts, preference patterns, and churn prediction. Features customer segmentation and targeted campaign creation.

### 52. Payouts Screen
- **Route:** `/business/:businessId/payouts`
- **File:** `lib/screens/business/[businessId]/financials/payouts_screen.dart`
- **Context:** Business
- **Description:** Financial dashboard showing pending payouts with dates, transaction history with filters, fee breakdowns (platform, processing), tax documents and reports, and bank account management. Features payout scheduling, multiple bank accounts per business, and detailed transaction records with CSV export.

### Reviews

### 53. Reviews Management Screen
- **Route:** `/business/:businessId/reviews`
- **File:** `lib/screens/business/[businessId]/reviews/reviews_management_screen.dart`
- **Description:** Central hub for all reviews: unresponded (requiring action), recent (last 30 days), all-time with filters. Shows sentiment analysis, response rate metrics, and reputation score trends.

### 54. Reply to Review Screen
- **Route:** `/business/:businessId/reviews/:reviewId/reply`
- **File:** `lib/screens/business/[businessId]/reviews/reply_to_review_screen.dart`
- **Context:** Business
- **Description:** Review response interface with template suggestions based on sentiment (positive, neutral, negative), tone analyzer, response best practices tips, and option to offer compensation for service recovery. Responses show business name, not personal name. Includes translation for non-native language reviews.

---

## MODULE 5: GUIDE CONTEXT (`/guide`)
*Tour guide features*

### 55. Become Guide Screen ⭐ NEW
- **Route:** `/guide/apply`
- **File:** `lib/screens/guide/onboarding/become_guide_screen.dart`
- **Multi-Role Feature:** Add guide role to account
- **Description:** Application process to add guide context to existing account. Requires verification documents, certifications upload, language proficiency, specialization selection (historical, food, adventure), and background check consent. Once approved, guide context is added to account with badge.

### 56. Guide Dashboard Screen
- **Route:** `/guide/dashboard`
- **File:** `lib/screens/guide/dashboard/guide_dashboard_screen.dart`
- **Context:** Guide
- **Description:** Guide command center showing today's tours with participant details, upcoming bookings for the week, earnings summary with tips, tourist inquiries requiring response, and weather alerts affecting tours. Features schedule management, quick customer communication, performance metrics, and resource checklist. Separate from personal bookings and business management.

### 57. Guide Profile Screen (Public)
- **Route:** `/guide/profile`
- **File:** `lib/screens/guide/profile/guide_profile_screen.dart`
- **Description:** Public guide profile displaying certifications and badges, expertise areas with icons, tour offerings with prices, availability calendar, languages spoken with proficiency, and reviews with rating. Includes video introduction, instant messaging button, package booking options, and social proof indicators.

### 58. Edit Guide Profile Screen
- **Route:** `/guide/profile/edit`
- **File:** `lib/screens/guide/profile/edit_guide_profile_screen.dart`
- **Context:** Guide
- **Description:** Guide profile builder with sections for qualifications and certifications, languages with proficiency levels, specializations and expertise, tour packages with pricing, standard availability rules, cancellation policy, and emergency procedures. Includes verification badge requirements and professional photo guidelines.

### 59. Guide Bookings Screen
- **Route:** `/guide/bookings`
- **File:** `lib/screens/guide/bookings/guide_bookings_screen.dart`
- **Context:** Guide
- **Description:** Booking calendar showing confirmed tours with groups, pending requests requiring approval, blocked dates for personal time, and weather contingencies. Features drag-and-drop rescheduling, group size management, automated reminder system, and route planning integration.

### 60. Create Experience Screen
- **Route:** `/guide/experiences/create`
- **File:** `lib/screens/guide/experiences/create_experience_screen.dart`
- **Context:** Guide
- **Description:** Experience designer for creating custom tours or events. Includes interactive route planner, duration estimator, pricing calculator, photo requirements, accessibility options, and safety considerations. Features template library, collaboration with venues, and marketing preview.

### 61. Guide Payouts Screen
- **Route:** `/guide/payouts`
- **File:** `lib/screens/guide/financials/guide_payouts_screen.dart`
- **Context:** Guide
- **Description:** Financial tracking showing tour earnings by type, tips received with gratitude option, platform fees breakdown, tax withholding info, and earning goals progress. Includes performance bonuses, seasonal trend analysis, and separate bank account from business payouts.

---

## MODULE 6: COMMUNITY (`/community`)
*Social features - context aware*

### 62. Community Rooms Screen
- **Route:** `/community`
- **File:** `lib/screens/community/rooms/rooms_list_screen.dart`
- **Multi-Role Aware:** Shows role-specific rooms
- **Description:** Community hub showing rooms relevant to active context. Categories include: Foodies (consumers), Business Networking (owners), Guide Community (guides), Tourist Groups (visitors). Each room card displays member count, activity heat indicator, recent topics, and join button. Business owners see business networking rooms, guides see guide community, consumers see foodie groups. Guests can browse but must login to participate.

### 63. Room Detail Screen
- **Route:** `/community/room/:roomId`
- **File:** `lib/screens/community/rooms/room_detail_screen.dart`
- **Multi-Role Aware:** Join with current context
- **Description:** Room information showing description, community rules, moderator list, member directory, pinned announcements, and recent activity. User joins with their active context identity (as business owner, guide, or consumer). Features notification preferences and mute options.

### 64. Room Chat Screen
- **Route:** `/community/room/:roomId/chat`
- **File:** `lib/screens/community/rooms/room_chat_screen.dart`
- **Multi-Role Aware:** Posts show context badge
- **Description:** Real-time chat interface with message history, typing indicators, user presence, and rich media support. Shows user's active context badge (Business Owner, Guide, Consumer) next to name for transparency. Supports text, images, polls, event planning, and location sharing. Includes moderation tools, user mentions, thread replies, and translation.

### 65. Social Discovery Screen
- **Route:** `/social/discover`
- **File:** `lib/screens/community/social/social_discovery_screen.dart`
- **Description:** Social exploration for finding connections based on active context interests. Shows trending topics, upcoming meetups, group activities, and suggested connections. Features event creation and RSVP management.

### 66. User Search Screen
- **Route:** `/social/users`
- **File:** `lib/screens/community/social/user_search_screen.dart`
- **Description:** User discovery with search by name, username, interests, or role. Shows user cards with public roles, recent activity, mutual connections, and message button. Includes filters for guides, locals, business owners, or specific expertise.

### 67. Group Booking Screen
- **Route:** `/social/group-booking`
- **File:** `lib/screens/community/social/group_booking_screen.dart`
- **Context:** Personal/Consumer only
- **Description:** Collaborative booking organizer for planning group outings. Features participant invitation, preference voting, availability coordination, cost splitting calculator, deposit handling, and group chat. Manages individual payments and dietary restrictions.

### 68. Direct Messaging Screen
- **Route:** `/messages/:userId`
- **File:** `lib/screens/community/messaging/direct_message_screen.dart`
- **Multi-Role Aware:** Shows sender's context
- **Description:** Private chat with message history, read receipts, media sharing, and voice messages. Shows which context you're messaging from with option to switch context within conversation. Supports booking discussions, deal sharing, and location sharing.

### 69. Conversations List Screen
- **Route:** `/messages`
- **File:** `lib/screens/community/messaging/conversations_list_screen.dart`
- **Description:** All conversations across all contexts with unread badges, context indicators, search function, and archive option.

---

## MODULE 7: CULTURAL AMBASSADOR (`/cultural`)
*Cultural preservation and promotion features*

### 70. Cultural Ambassador Application Screen
- **Route:** `/cultural/apply`
- **File:** `lib/screens/cultural/cultural_ambassador_application_screen.dart`
- **Multi-Role Feature:** Add cultural role
- **Description:** Application form requiring cultural knowledge quiz, community involvement history, content creation samples, and language skills. Includes multi-step verification process, reference checks, and interview scheduling. Explains benefits and responsibilities of the role.

### 71. Cultural Ambassador Dashboard
- **Route:** `/cultural/dashboard`
- **File:** `lib/screens/cultural/cultural_ambassador_dashboard_screen.dart`
- **Context:** Cultural Ambassador
- **Description:** Ambassador workspace showing content creation tasks, cultural event calendar, venue verification requests, translation needs, and community impact metrics. Features content templates, collaboration tools, event planning, and reward tracking. Includes cultural preservation initiatives and heritage documentation projects.

---

## MODULE 8: SHARED (`/shared`)
*Shared across all contexts*

### Settings

### 72. Settings Main Screen
- **Route:** `/settings`
- **File:** `lib/screens/shared/settings/settings_main_screen.dart`
- **Multi-Role Support:** Unified settings hub
- **Description:** Master settings affecting all contexts. Categories include: Account (email, password, verification), Personal Preferences (language, timezone), Business Settings (per business), Guide Settings (if applicable), Payment Methods (shared across contexts), Privacy & Security, and About & Legal.

### 73. Account Settings Screen
- **Route:** `/settings/account`
- **File:** `lib/screens/shared/settings/account_settings_screen.dart`
- **Description:** Manage master account: change email, update password, two-factor authentication, login sessions, and account deletion.

### 74. Payment Methods Screen
- **Route:** `/settings/payment`
- **File:** `lib/screens/shared/settings/payment_methods_screen.dart`
- **Multi-Role Support:** Shared payment methods
- **Description:** Manage payment methods used across all contexts. Add/remove cards, set defaults per context (personal vs. business expenses), view transaction history, and manage billing addresses.

### 75. Notification Settings Screen
- **Route:** `/settings/notifications`
- **File:** `lib/screens/shared/settings/notification_settings_screen.dart`
- **Multi-Role Support:** Per-context preferences
- **Description:** Granular controls per context: Personal (deal alerts, booking reminders), Business (new reservations, reviews), Guide (tour requests, weather alerts). Set quiet hours per role, email preferences, and push notification channels.

### 76. Privacy Settings Screen
- **Route:** `/settings/privacy`
- **File:** `lib/screens/shared/settings/privacy_settings_screen.dart`
- **Multi-Role Support:** Control visibility per context
- **Description:** Separate privacy controls for each context. Hide business ownership from personal profile, control guide service discoverability, manage data sharing per role, and blocked users list.

### Notifications & Premium

### 77. Notifications Center Screen
- **Route:** `/notifications`
- **File:** `lib/screens/shared/notifications/notifications_center_screen.dart`
- **Multi-Role Support:** Unified notification center
- **Description:** All notifications across all contexts in one place. Each notification shows context icon and color coding. Categories: Bookings (personal and business), Messages, Deals, Reviews, System Updates. Features mark all as read, swipe actions, and deep linking to relevant screens.

### 78. Premium Upgrade Screen
- **Route:** `/premium`
- **File:** `lib/screens/shared/premium/premium_upgrade_screen.dart`
- **Multi-Role Support:** Benefits across all contexts
- **Description:** Premium membership sales page showing benefits: no ads as consumer, priority placement as business, featured guide status, early access to features, and premium support. Single subscription enhances all contexts. Includes pricing tiers and testimonials.

### Support & Errors

### 79. Support Screen
- **Route:** `/support`
- **File:** `lib/screens/shared/support/support_screen.dart`
- **Description:** Unified support with FAQ, help articles, contact form, live chat, and ticket tracking. Context selector to specify which role needs help.

### 80. Error Screen
- **Route:** `/error`
- **File:** `lib/screens/shared/errors/error_screen.dart`
- **Description:** User-friendly error display for various scenarios (network, server, not found). Shows appropriate illustration, clear explanation, and context-aware recovery options.

### 81. Empty State Screen
- **Route:** `/empty`
- **File:** `lib/screens/shared/errors/empty_state_screen.dart`
- **Description:** Placeholder for empty content with contextual illustrations and CTAs. Messages like "No bookings yet" or "Create your first deal" based on context.

---

## MODULE 9: ADMIN (`/admin`)
*Platform administration*

### 82. Admin Login Screen
- **Route:** `/admin/login`
- **File:** `lib/screens/admin/auth/admin_login_screen.dart`
- **Description:** Secure admin authentication with two-factor authentication, IP restriction, role-based access control, and session management. Includes audit logging of all admin actions.

### 83. User Management Screen
- **Route:** `/admin/users`
- **File:** `lib/screens/admin/users/user_management_screen.dart`
- **Multi-Role Support:** View all user contexts
- **Description:** Admin view showing users' master accounts and all associated contexts. Can view user details, suspend specific contexts, ban entire accounts, reset passwords, and view activity logs. Includes bulk operations and export capabilities.

### 84. Content Moderation Screen
- **Route:** `/admin/moderation`
- **File:** `lib/screens/admin/moderation/content_moderation_screen.dart`
- **Description:** Moderation queue for reviewing flagged content (reviews, messages, photos). Shows context, reporter details, violation history, and AI-suggested actions. Features quick actions and moderation guidelines.

### 85. Platform Analytics Screen
- **Route:** `/admin/analytics`
- **File:** `lib/screens/admin/analytics/platform_analytics_screen.dart`
- **Description:** Platform health monitoring showing user growth by context, engagement metrics, viral coefficients, retention cohorts, and revenue by segment. Features real-time alerts, trend analysis, and growth experiment tracking.

---

## MODULE 10: DEVELOPMENT (`/dev`)
*Development tools*

### 86. Developer Menu Screen
- **Route:** `/dev-menu`
- **File:** `lib/screens/dev/dev_menu_screen.dart`
- **Multi-Role Support:** Test context switching
- **Description:** Development navigation hub with organized links to all screens, context switching tester, test data generators, debug tools, and performance monitoring. Features screen search, favorites, recent history, and state inspection. Only visible in development builds.

---

## ⚠️ DEPRECATED SCREENS

### Main Navigation Screen (DEPRECATED)
- **Route:** `/main-navigation`
- **File:** `lib/screens/deprecated/main_navigation_screen.dart`
- **Description:** [DEPRECATED - DO NOT USE] Originally planned as main container with bottom navigation bar. Replaced by context-aware navigation system where each context has its own navigation structure.

---

## 📊 NAVIGATION ARCHITECTURE

### Context-Aware Navigation
```dart
// Navigation changes based on active context
class AppNavigator {
  static String getHomeRoute() {
    switch (activeContext.type) {
      case ContextType.personal:
        return '/personal/home';
      case ContextType.business:
        return '/business/${activeContext.contextId}/dashboard';
      case ContextType.guide:
        return '/guide/dashboard';
      case ContextType.cultural:
        return '/cultural/dashboard';
      default:
        return '/personal/home';
    }
  }
}
```

### Bottom Navigation (Context-Dependent)
```dart
// Personal Context Bottom Nav
[Home, Discover, Bookings, Community, Profile]

// Business Context Bottom Nav  
[Dashboard, Bookings, Deals, Analytics, Settings]

// Guide Context Bottom Nav
[Dashboard, Tours, Calendar, Earnings, Profile]

// Cultural Context Bottom Nav
[Dashboard, Content, Events, Impact, Profile]
```

---

## 🎯 MULTI-ROLE USER FLOWS

### New User Journey
1. **Register** → Creates master account + personal context
2. **Explore as Consumer** → Browse, book, review
3. **Add Business** → Apply to add business context
4. **Manage Business** → Switch to business context
5. **Become Guide** → Add guide context later
6. **Switch Freely** → Toggle between all contexts

### Context Switching Flow
1. **Any Screen** → Tap profile picture
2. **Context Menu** → Shows current context
3. **Switch Context** → Select different role
4. **UI Updates** → Navigation and features change
5. **Maintain State** → Return to previous context later

---

## 🔒 SECURITY & PERMISSIONS

### Permission Levels
```yaml
Master Account:
  - Change password
  - Manage payment methods
  - Delete entire account
  
Personal Context:
  - Make bookings
  - Write reviews
  - Save favorites
  
Business Context:
  - Manage specific business
  - Invite team members
  - View business analytics
  - Cannot see other businesses
  
Team Member (Business):
  - Limited business access
  - Cannot see owner's personal data
  - Cannot see owner's other businesses
  
Guide Context:
  - Manage tours
  - Guide analytics
  - Separate from business
```

---

## 📈 STATISTICS

### Screen Distribution by Module
- **Authentication:** 7 screens
- **Context Switcher:** 3 screens
- **Personal/Consumer:** 20 screens
- **Business:** 24 screens
- **Guide:** 7 screens
- **Community:** 8 screens
- **Cultural:** 2 screens
- **Shared/Settings:** 10 screens
- **Admin:** 4 screens
- **Development:** 1 screen
- **Deprecated:** 1 screen

### Total Counts
- **Active Screens:** 86
- **Deprecated Screens:** 1
- **Total Screens:** 87
- **Context-Aware Screens:** 52
- **Multi-Role Specific:** 12

---

## 🚀 IMPLEMENTATION PRIORITIES

### Phase 1 - MVP (Launch)
1. Core authentication (screens 1-7)
2. Personal context (screens 11-30)
3. Single business context (screens 35-54)
4. Basic context switching (screens 8-10)
5. Essential shared screens (screens 72-81)

### Phase 2 - Growth
1. Multiple businesses support (screen 34)
2. Team management (screens 46-48)
3. Guide context (screens 55-61)
4. Community features (screens 62-69)
5. Advanced analytics (screens 49-51)

### Phase 3 - Scale
1. Cultural ambassador (screens 70-71)
2. Admin tools (screens 82-85)
3. Premium features (screen 78)
4. API for third-party integration
5. White-label options

---

## ✅ SUCCESS METRICS

- **Adoption:** % users with multiple contexts
- **Engagement:** Context switches per user per month
- **Retention:** Retention rate for multi-context vs. single-context users
- **Revenue:** Average revenue per context type
- **Satisfaction:** NPS score per context type
- **Efficiency:** Time to switch contexts (<2 seconds)

---

**This architecture enables DeadHour to be a true platform where users seamlessly move between being customers, business owners, and service providers - all with one account, one login, and zero friction.**