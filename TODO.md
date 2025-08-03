# DeadHour Real Codebase Structure & Implementation Plan

**Based on existing lib/backup/ code + all_screens.md requirements**

## CURRENT STATUS: Codebase Analysis

### EXISTING STRUCTURE (lib/backup/)

```
lib/backup/                           # Current working code
├── screens/                          # ~35 screens implemented
│   ├── auth/                         # ✅ 5/7 screens exist
│   │   ├── splash_screen.dart        # ✅ EXISTS
│   │   ├── onboarding_screen.dart    # ✅ EXISTS  
│   │   ├── login_screen.dart         # ✅ EXISTS
│   │   ├── register_screen.dart      # ✅ EXISTS
│   │   ├── role_marketplace_screen.dart # ✅ EXISTS (context switcher)
│   │   ├── verify_email_screen.dart  # ❌ MISSING
│   │   ├── forgot_password_screen.dart # ❌ MISSING
│   │   └── reset_password_screen.dart # ❌ MISSING
│   ├── business/                     # ✅ 4/24 screens exist
│   │   ├── business_dashboard_screen.dart # ✅ EXISTS
│   │   ├── analytics_dashboard_screen.dart # ✅ EXISTS  
│   │   ├── create_deal_screen.dart   # ✅ EXISTS (complex subfolder)
│   │   ├── revenue_optimization_screen.dart # ✅ EXISTS
│   │   └── [20 screens missing]      # ❌ MISSING most business screens
│   ├── community/                    # ✅ 3/8 screens exist
│   │   ├── rooms_screen.dart         # ✅ EXISTS (rooms list)
│   │   ├── room_detail_screen.dart   # ✅ EXISTS
│   │   ├── room_chat_screen.dart     # ✅ EXISTS (complex subfolder)
│   │   └── [5 screens missing]       # ❌ MISSING social/messaging
│   ├── cultural/                     # ✅ 1/2 screens exist
│   │   ├── cultural_ambassador_application_screen.dart # ✅ EXISTS
│   │   └── cultural_ambassador_dashboard_screen.dart # ❌ MISSING
│   ├── guide/                        # ✅ 1/7 screens exist
│   │   ├── guide_role_screen.dart    # ✅ EXISTS
│   │   └── [6 screens missing]       # ❌ MISSING most guide screens
│   ├── home/                         # ✅ 6 screens exist (personal context)
│   │   ├── home_screen.dart          # ✅ EXISTS
│   │   ├── deals_screen.dart         # ✅ EXISTS
│   │   ├── venue_discovery_screen.dart # ✅ EXISTS
│   │   ├── booking_flow_screen.dart  # ✅ EXISTS
│   │   ├── tourist_home_screen.dart  # ✅ EXISTS
│   │   └── main_navigation_screen.dart # ✅ EXISTS (deprecated)
│   ├── profile/                      # ✅ 4/6 screens exist
│   │   ├── profile_screen.dart       # ✅ EXISTS
│   │   ├── premium_role_screen.dart  # ✅ EXISTS
│   │   ├── settings_screen.dart      # ✅ EXISTS
│   │   └── [role_switching related]  # ✅ EXISTS (separate folder)
│   ├── role_switching_screen/        # ✅ EXISTS (separate implementation)
│   ├── social/                       # ✅ 2/3 screens exist
│   │   ├── social_discovery_screen.dart # ✅ EXISTS
│   │   ├── group_booking_screen.dart # ✅ EXISTS (complex subfolder)
│   │   └── [user search missing]     # ❌ MISSING
│   ├── tourism/                      # ✅ 2 screens exist
│   │   ├── tourism_screen.dart       # ✅ EXISTS
│   │   └── local_expert_screen.dart  # ✅ EXISTS
│   ├── venues/                       # ✅ 1 screen exists
│   │   └── venue_detail_screen.dart  # ✅ EXISTS
│   ├── notifications/                # ✅ 1 screen exists
│   │   └── notifications_screen.dart # ✅ EXISTS
│   ├── payment/                      # ✅ 1 screen exists
│   │   └── payment_screen.dart       # ✅ EXISTS (complex subfolder)
│   ├── settings/                     # ✅ 2 screens exist
│   │   ├── accessibility_settings_screen.dart # ✅ EXISTS
│   │   └── offline_settings_screen.dart # ✅ EXISTS
│   └── admin/                        # ✅ 2/4 screens exist
│       ├── community_health_dashboard_screen.dart # ✅ EXISTS
│       ├── network_effects_dashboard_screen.dart # ✅ EXISTS
│       └── [2 screens missing]       # ❌ MISSING admin auth & moderation
└── [shared global files at root level as needed]
```

## TARGET STRUCTURE (86 Screens from all_screens.md)

### SCREENS TO REORGANIZE/CREATE

**GROUPED FOLDER STRUCTURE (Following all_screens.md)**
```
lib/screens/                          # Grouped by modules as per architecture
├── auth/                             # MODULE 1: Authentication (7 screens)
│   ├── splash_screen/                # Screen 1
│   │   ├── splash_screen.dart        # MOVE from backup/screens/auth/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── utils/
│   │   └── widgets/
│   ├── onboarding_screen/            # Screen 2
│   │   ├── onboarding_screen.dart    # MOVE from backup/screens/auth/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── utils/
│   │   └── widgets/
│   ├── login_screen/                 # Screen 3
│   │   ├── login_screen.dart         # MOVE from backup/screens/auth/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── utils/
│   │   └── widgets/
│   ├── register_screen/              # Screen 4
│   │   ├── register_screen.dart      # MOVE from backup/screens/auth/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── utils/
│   │   └── widgets/
│   ├── verify_email_screen/          # Screen 5
│   │   ├── verify_email_screen.dart  # CREATE new
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── utils/
│   │   └── widgets/
│   ├── forgot_password_screen/       # Screen 6
│   │   ├── forgot_password_screen.dart # CREATE new
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── utils/
│   │   └── widgets/
│   └── reset_password_screen/        # Screen 7
│       ├── reset_password_screen.dart # CREATE new
│       ├── models/
│       ├── services/
│       ├── providers/
│       ├── utils/
│       └── widgets/
├── context_switcher/                 # MODULE 2: Role/Context Switching (3 screens)
│   ├── context_switcher_screen/      # Screen 8
│   │   ├── context_switcher_screen.dart # MOVE from backup/screens/role_switching_screen/
│   │   ├── models/
│   │   │   └── context_data.dart     # Context switching models
│   │   ├── services/
│   │   │   └── context_service.dart  # Context management logic
│   │   ├── providers/
│   │   │   └── context_provider.dart # Context state management
│   │   ├── utils/
│   │   └── widgets/
│   │       ├── context_card.dart     # Context selection cards
│   │       └── context_selector.dart # Quick context switcher
│   ├── add_context_screen/           # Screen 9
│   │   ├── add_context_screen.dart   # EXTRACT from role_marketplace_screen
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── utils/
│   │   └── widgets/
│   └── widgets/
│       └── context_selector_widget/  # Screen 10 (widget component)
│           ├── context_selector_widget.dart # CREATE new
│           ├── models/
│           ├── services/
│           ├── providers/
│           ├── utils/
│           └── widgets/
├── personal/                         # MODULE 3: Consumer Context (20 screens)
│   ├── home/
│   │   └── personal_home_screen/     # Screen 11
│   │       ├── personal_home_screen.dart # MOVE from backup/screens/home/home_screen.dart
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── profile/
│   │   ├── personal_profile_screen/  # Screen 12
│   │   │   ├── personal_profile_screen.dart # MOVE from backup/screens/profile/profile_screen.dart
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── edit_personal_profile_screen/ # Screen 13
│   │   │   ├── edit_personal_profile_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   └── public_profile_screen/    # Screen 14
│   │       ├── public_profile_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── bookings/
│   │   ├── my_bookings_list_screen/  # Screen 15
│   │   │   ├── my_bookings_list_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── booking_detail_screen/    # Screen 16
│   │   │   ├── booking_detail_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── create_booking_flow/
│   │   │   ├── select_datetime_screen/ # Screen 17
│   │   │   │   ├── select_datetime_screen.dart # SPLIT from booking_flow
│   │   │   │   ├── models/
│   │   │   │   ├── services/
│   │   │   │   ├── providers/
│   │   │   │   ├── utils/
│   │   │   │   └── widgets/
│   │   │   ├── choose_deal_screen/   # Screen 18
│   │   │   │   ├── choose_deal_screen.dart # SPLIT from booking_flow
│   │   │   │   ├── models/
│   │   │   │   ├── services/
│   │   │   │   ├── providers/
│   │   │   │   ├── utils/
│   │   │   │   └── widgets/
│   │   │   ├── add_requests_screen/  # Screen 19
│   │   │   │   ├── add_requests_screen.dart # SPLIT from booking_flow
│   │   │   │   ├── models/
│   │   │   │   ├── services/
│   │   │   │   ├── providers/
│   │   │   │   ├── utils/
│   │   │   │   └── widgets/
│   │   │   ├── review_details_screen/ # Screen 20
│   │   │   │   ├── review_details_screen.dart # SPLIT from booking_flow
│   │   │   │   ├── models/
│   │   │   │   ├── services/
│   │   │   │   ├── providers/
│   │   │   │   ├── utils/
│   │   │   │   └── widgets/
│   │   │   └── payment_screen/       # Screen 21
│   │   │       ├── payment_screen.dart # MOVE from backup/screens/payment/
│   │   │       ├── models/
│   │   │       ├── services/
│   │   │       ├── providers/
│   │   │       ├── utils/
│   │   │       └── widgets/          # ✅ EXISTS (well organized)
│   │   └── booking_confirmation_screen/ # Screen 22
│   │       ├── booking_confirmation_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── discovery/
│   │   ├── venue_discovery_screen/   # Screen 23
│   │   │   ├── venue_discovery_screen.dart # MOVE from backup/screens/home/
│   │   │   ├── models/
│   │   │   │   └── venue_filter.dart # Venue filtering models
│   │   │   ├── services/
│   │   │   │   └── venue_search_service.dart # Venue search logic
│   │   │   ├── providers/
│   │   │   │   └── venue_provider.dart # Venue state management
│   │   │   ├── utils/
│   │   │   │   └── venue_helpers.dart # Venue utility functions
│   │   │   └── widgets/
│   │   │       ├── venue_card.dart   # Venue display card
│   │   │       ├── venue_map.dart    # Map view widget
│   │   │       └── venue_filters.dart # Filter widgets
│   │   ├── venue_detail_screen/      # Screen 24
│   │   │   ├── venue_detail_screen.dart # MOVE from backup/screens/venues/
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── deals_browse_screen/      # Screen 25
│   │   │   ├── deals_browse_screen.dart # MOVE from backup/screens/home/deals_screen.dart
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── deal_detail_screen/       # Screen 26
│   │   │   ├── deal_detail_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   └── search_results_screen/    # Screen 27
│   │       ├── search_results_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── favorites/
│   │   └── favorites_screen/         # Screen 28
│   │       ├── favorites_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   └── reviews/
│       ├── write_review_screen/      # Screen 29
│       │   ├── write_review_screen.dart # CREATE new
│       │   ├── models/
│       │   ├── services/
│       │   ├── providers/
│       │   ├── utils/
│       │   └── widgets/
│       └── my_reviews_screen/        # Screen 30
│           ├── my_reviews_screen.dart # CREATE new
│           ├── models/
│           ├── services/
│           ├── providers/
│           ├── utils/
│           └── widgets/
├── business/                         # MODULE 4: Business Context (24 screens)
│   ├── onboarding/
│   │   ├── create_business_screen/   # Screen 31
│   │   │   ├── create_business_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── business_verification_screen/ # Screen 32
│   │   │   ├── business_verification_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   └── business_setup_wizard_screen/ # Screen 33
│   │       ├── business_setup_wizard_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── switcher/
│   │   └── business_switcher_screen/ # Screen 34
│   │       ├── business_switcher_screen.dart # CREATE new (multi-business)
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   └── [businessId]/                 # Per-business screens
│       ├── dashboard/
│       │   └── business_dashboard_screen/ # Screen 35
│       │       ├── business_dashboard_screen.dart # MOVE from backup/screens/business/
│       │       ├── models/
│       │       │   └── dashboard_data.dart # Dashboard models
│       │       ├── services/
│       │       │   ├── dashboard_service.dart # Dashboard data service
│       │       │   └── analytics_service.dart # Business analytics
│       │       ├── providers/
│       │       │   └── dashboard_provider.dart # Dashboard state
│       │       ├── utils/
│       │       │   └── dashboard_helpers.dart # Dashboard utilities
│       │       └── widgets/
│       │           ├── revenue_card.dart # Revenue display
│       │           ├── stats_overview.dart # Statistics overview
│       │           └── quick_actions.dart # Quick action buttons
│       ├── profile/
│       │   ├── business_profile_screen/ # Screen 36
│       │   │   ├── business_profile_screen.dart # CREATE new
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   └── edit_business_profile_screen/ # Screen 37
│       │       ├── edit_business_profile_screen.dart # CREATE new
│       │       ├── models/
│       │       ├── services/
│       │       ├── providers/
│       │       ├── utils/
│       │       └── widgets/
│       ├── bookings/
│       │   ├── booking_management_screen/ # Screen 38
│       │   │   ├── booking_management_screen.dart # CREATE new
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   ├── booking_detail_screen/ # Screen 39
│       │   │   ├── business_booking_detail_screen.dart # CREATE new
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   ├── booking_calendar_screen/ # Screen 40
│       │   │   ├── booking_calendar_screen.dart # CREATE new
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   └── check_in_screen/      # Screen 41
│       │       ├── check_in_screen.dart # CREATE new
│       │       ├── models/
│       │       ├── services/
│       │       ├── providers/
│       │       ├── utils/
│       │       └── widgets/
│       ├── deals/
│       │   ├── deals_list_screen/    # Screen 42
│       │   │   ├── deals_list_screen.dart # CREATE new
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   ├── create_deal_screen/   # Screen 43 ✅ ALREADY EXISTS (good example)
│       │   │   ├── create_deal_screen.dart # MOVE from backup/screens/business/
│       │   │   ├── models/
│       │   │   │   └── create_deal_state.dart # ✅ EXISTS
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/          # ✅ EXISTS (many widgets)
│       │   │       ├── create_deal_header.dart
│       │   │       ├── create_deal_type_selector.dart
│       │   │       ├── create_deal_information_form.dart
│       │   │       └── [many more widgets]
│       │   ├── edit_deal_screen/     # Screen 44
│       │   │   ├── edit_deal_screen.dart # CREATE new
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   └── deal_analytics_screen/ # Screen 45
│       │       ├── deal_analytics_screen.dart # CREATE new
│       │       ├── models/
│       │       ├── services/
│       │       ├── providers/
│       │       ├── utils/
│       │       └── widgets/
│       ├── team/
│       │   ├── team_management_screen/ # Screen 46
│       │   │   ├── team_management_screen.dart # CREATE new
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   ├── invite_team_member_screen/ # Screen 47
│       │   │   ├── invite_team_member_screen.dart # CREATE new
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   └── team_permissions_screen/ # Screen 48
│       │       ├── team_permissions_screen.dart # CREATE new
│       │       ├── models/
│       │       ├── services/
│       │       ├── providers/
│       │       ├── utils/
│       │       └── widgets/
│       ├── analytics/
│       │   ├── analytics_dashboard_screen/ # Screen 49
│       │   │   ├── analytics_dashboard_screen.dart # MOVE from backup/screens/business/
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/          # ✅ EXISTS (many widgets)
│       │   ├── revenue_optimization_screen/ # Screen 50
│       │   │   ├── revenue_optimization_screen.dart # MOVE from backup/screens/business/
│       │   │   ├── models/
│       │   │   ├── services/
│       │   │   ├── providers/
│       │   │   ├── utils/
│       │   │   └── widgets/
│       │   └── customer_insights_screen/ # Screen 51
│       │       ├── customer_insights_screen.dart # CREATE new
│       │       ├── models/
│       │       ├── services/
│       │       ├── providers/
│       │       ├── utils/
│       │       └── widgets/
│       ├── financials/
│       │   └── payouts_screen/       # Screen 52
│       │       ├── payouts_screen.dart # CREATE new
│       │       ├── models/
│       │       ├── services/
│       │       ├── providers/
│       │       ├── utils/
│       │       └── widgets/
│       └── reviews/
│           ├── reviews_management_screen/ # Screen 53
│           │   ├── reviews_management_screen.dart # CREATE new
│           │   ├── models/
│           │   ├── services/
│           │   ├── providers/
│           │   ├── utils/
│           │   └── widgets/
│           └── reply_to_review_screen/ # Screen 54
│               ├── reply_to_review_screen.dart # CREATE new
│               ├── models/
│               ├── services/
│               ├── providers/
│               ├── utils/
│               └── widgets/
├── guide/                            # MODULE 5: Guide Context (7 screens)
│   ├── onboarding/
│   │   └── become_guide_screen/      # Screen 55
│   │       ├── become_guide_screen.dart # RENAME from backup/screens/guide/guide_role_screen.dart
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── dashboard/
│   │   └── guide_dashboard_screen/   # Screen 56
│   │       ├── guide_dashboard_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── profile/
│   │   ├── guide_profile_screen/     # Screen 57
│   │   │   ├── guide_profile_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   └── edit_guide_profile_screen/ # Screen 58
│   │       ├── edit_guide_profile_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── bookings/
│   │   └── guide_bookings_screen/    # Screen 59
│   │       ├── guide_bookings_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── experiences/
│   │   └── create_experience_screen/ # Screen 60
│   │       ├── create_experience_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   └── financials/
│       └── guide_payouts_screen/     # Screen 61
│           ├── guide_payouts_screen.dart # CREATE new
│           ├── models/
│           ├── services/
│           ├── providers/
│           ├── utils/
│           └── widgets/
├── community/                        # MODULE 6: Community (8 screens)
│   ├── rooms/
│   │   ├── rooms_list_screen/        # Screen 62
│   │   │   ├── rooms_list_screen.dart # MOVE from backup/screens/community/rooms_screen.dart
│   │   │   ├── models/
│   │   │   │   └── room_filter.dart  # Room filtering models
│   │   │   ├── services/
│   │   │   │   └── room_service.dart # Room management
│   │   │   ├── providers/
│   │   │   │   └── room_provider.dart # Room state
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   │       ├── room_card.dart    # Room display card
│   │   │       ├── room_tabs.dart    # Room category tabs
│   │   │       └── room_search.dart  # Room search widget
│   │   ├── room_detail_screen/       # Screen 63
│   │   │   ├── room_detail_screen.dart # MOVE from backup/screens/community/
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   └── room_chat_screen/         # Screen 64 ✅ ALREADY EXISTS (good example)
│   │       ├── room_chat_screen.dart # MOVE from backup/screens/community/
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/              # ✅ EXISTS (well organized)
│   │           ├── room_chat_messages_list.dart
│   │           ├── room_chat_message_reactions.dart
│   │           └── [many more widgets]
│   ├── social/
│   │   ├── social_discovery_screen/  # Screen 65
│   │   │   ├── social_discovery_screen.dart # MOVE from backup/screens/social/
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── user_search_screen/       # Screen 66
│   │   │   ├── user_search_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   └── group_booking_screen/     # Screen 67
│   │       ├── group_booking_screen.dart # MOVE from backup/screens/social/
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/              # ✅ EXISTS (well organized)
│   └── messaging/
│       ├── direct_message_screen/    # Screen 68
│       │   ├── direct_message_screen.dart # CREATE new
│       │   ├── models/
│       │   ├── services/
│       │   ├── providers/
│       │   ├── utils/
│       │   └── widgets/
│       └── conversations_list_screen/ # Screen 69
│           ├── conversations_list_screen.dart # CREATE new
│           ├── models/
│           ├── services/
│           ├── providers/
│           ├── utils/
│           └── widgets/
├── cultural/                         # MODULE 7: Cultural Ambassador (2 screens)
│   ├── cultural_ambassador_application_screen/ # Screen 70
│   │   ├── cultural_ambassador_application_screen.dart # MOVE from backup/screens/cultural/
│   │   ├── models/
│   │   ├── services/
│   │   ├── providers/
│   │   ├── utils/
│   │   └── widgets/                  # ✅ EXISTS (well organized)
│   └── cultural_ambassador_dashboard_screen/ # Screen 71
│       ├── cultural_ambassador_dashboard_screen.dart # CREATE new
│       ├── models/
│       ├── services/
│       ├── providers/
│       ├── utils/
│       └── widgets/
├── shared/                           # MODULE 8: Shared Components (10 screens)
│   ├── settings/
│   │   ├── settings_main_screen/     # Screen 72
│   │   │   ├── settings_main_screen.dart # MOVE from backup/screens/profile/settings_screen.dart
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── account_settings_screen/  # Screen 73
│   │   │   ├── account_settings_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── payment_methods_screen/   # Screen 74
│   │   │   ├── payment_methods_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   ├── notification_settings_screen/ # Screen 75
│   │   │   ├── notification_settings_screen.dart # CREATE new
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── providers/
│   │   │   ├── utils/
│   │   │   └── widgets/
│   │   └── privacy_settings_screen/  # Screen 76
│   │       ├── privacy_settings_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── notifications/
│   │   └── notifications_center_screen/ # Screen 77
│   │       ├── notifications_center_screen.dart # MOVE from backup/screens/notifications/
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── premium/
│   │   └── premium_upgrade_screen/   # Screen 78
│   │       ├── premium_upgrade_screen.dart # MOVE from backup/screens/profile/premium_role_screen.dart
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/              # ✅ EXISTS (well organized)
│   ├── support/
│   │   └── support_screen/           # Screen 79
│   │       ├── support_screen.dart   # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   └── errors/
│       ├── error_screen/             # Screen 80
│       │   ├── error_screen.dart     # CREATE new
│       │   ├── models/
│       │   ├── services/
│       │   ├── providers/
│       │   ├── utils/
│       │   └── widgets/
│       └── empty_state_screen/       # Screen 81
│           ├── empty_state_screen.dart # CREATE new
│           ├── models/
│           ├── services/
│           ├── providers/
│           ├── utils/
│           └── widgets/
├── admin/                            # MODULE 9: Admin (4 screens)
│   ├── auth/
│   │   └── admin_login_screen/       # Screen 82
│   │       ├── admin_login_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── users/
│   │   └── user_management_screen/   # Screen 83
│   │       ├── user_management_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   ├── moderation/
│   │   └── content_moderation_screen/ # Screen 84
│   │       ├── content_moderation_screen.dart # CREATE new
│   │       ├── models/
│   │       ├── services/
│   │       ├── providers/
│   │       ├── utils/
│   │       └── widgets/
│   └── analytics/
│       └── platform_analytics_screen/ # Screen 85
│           ├── platform_analytics_screen.dart # MOVE from backup/screens/admin/
│           ├── models/
│           ├── services/
│           ├── providers/
│           ├── utils/
│           └── widgets/
└── dev/                              # MODULE 10: Development (1 screen)
    └── dev_menu_screen/              # Screen 86
        ├── dev_menu_screen.dart      # CREATE new
        ├── models/
        ├── services/
        ├── providers/
        ├── utils/
        └── widgets/
```

## COMPLETE IMPLEMENTATION PLAN

**PHASE 1: REORGANIZE EXISTING (35 screens to move)**
1. Create module folders with grouped screen folders
2. Move existing screens from backup/ to proper grouped structure
3. Organize existing widgets into screen-specific folders
4. Update all imports throughout codebase

**PHASE 2: CREATE MISSING SCREENS (51 new screens)**
1. Missing auth screens (3): verify_email, forgot_password, reset_password
2. Missing personal screens (15): bookings, reviews, favorites, profiles
3. Missing business screens (20): onboarding, team, analytics, reviews
4. Missing guide screens (6): dashboard, profile, bookings, experiences
5. Missing community screens (5): messaging, user search
6. Missing shared screens (2): support, error handling

**PHASE 3: ENHANCE ARCHITECTURE**
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── personal_profile_screen/          # Screen 12 folder
│   ├── personal_profile_screen.dart  # MOVE from backup/screens/profile/profile_screen.dart
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── venue_discovery_screen/           # Screen 23 folder
│   ├── venue_discovery_screen.dart   # MOVE from backup/screens/home/
│   ├── models/
│   │   └── venue_filter.dart         # Venue filtering models
│   ├── services/
│   │   └── venue_search_service.dart # Venue search logic
│   ├── providers/
│   │   └── venue_provider.dart       # Venue state management
│   ├── utils/
│   │   └── venue_helpers.dart        # Venue utility functions
│   └── widgets/
│       ├── venue_card.dart           # Venue display card
│       ├── venue_map.dart            # Map view widget
│       └── venue_filters.dart        # Filter widgets
├── venue_detail_screen/              # Screen 24 folder
│   ├── venue_detail_screen.dart      # MOVE from backup/screens/venues/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── business_dashboard_screen/        # Screen 35 folder
│   ├── business_dashboard_screen.dart # MOVE from backup/screens/business/
│   ├── models/
│   │   └── dashboard_data.dart       # Dashboard models
│   ├── services/
│   │   ├── dashboard_service.dart    # Dashboard data service
│   │   └── analytics_service.dart    # Business analytics
│   ├── providers/
│   │   └── dashboard_provider.dart   # Dashboard state
│   ├── utils/
│   │   └── dashboard_helpers.dart    # Dashboard utilities
│   └── widgets/
│       ├── revenue_card.dart         # Revenue display
│       ├── stats_overview.dart       # Statistics overview
│       └── quick_actions.dart        # Quick action buttons
├── create_deal_screen/               # Screen 43 folder ✅ ALREADY EXISTS (good example)
│   ├── create_deal_screen.dart       # ✅ MOVE from backup/screens/business/
│   ├── models/
│   │   └── create_deal_state.dart    # ✅ EXISTS
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/                      # ✅ EXISTS (many widgets)
│       ├── create_deal_header.dart
│       ├── create_deal_type_selector.dart
│       ├── create_deal_information_form.dart
│       └── [many more widgets]
├── rooms_list_screen/                # Screen 62 folder
│   ├── rooms_list_screen.dart        # MOVE from backup/screens/community/rooms_screen.dart
│   ├── models/
│   │   └── room_filter.dart          # Room filtering models
│   ├── services/
│   │   └── room_service.dart         # Room management
│   ├── providers/
│   │   └── room_provider.dart        # Room state
│   ├── utils/
│   └── widgets/
│       ├── room_card.dart            # Room display card
│       ├── room_tabs.dart            # Room category tabs
│       └── room_search.dart          # Room search widget
├── room_chat_screen/                 # Screen 64 folder ✅ ALREADY EXISTS (good example)
│   ├── room_chat_screen.dart         # ✅ MOVE from backup/screens/community/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/                      # ✅ EXISTS (well organized)
│       ├── room_chat_messages_list.dart
│       ├── room_chat_message_reactions.dart
│       └── [many more widgets]
├── context_selector_widget/           # Screen 10 folder
│   ├── context_selector_widget.dart  # CREATE new (quick switcher widget)
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── edit_personal_profile_screen/     # Screen 13 folder
│   ├── edit_personal_profile_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── public_profile_screen/            # Screen 14 folder
│   ├── public_profile_screen.dart    # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── my_bookings_list_screen/          # Screen 15 folder
│   ├── my_bookings_list_screen.dart  # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── booking_detail_screen/            # Screen 16 folder
│   ├── booking_detail_screen.dart    # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── select_datetime_screen/           # Screen 17 folder
│   ├── select_datetime_screen.dart   # SPLIT from booking_flow
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── choose_deal_screen/               # Screen 18 folder
│   ├── choose_deal_screen.dart       # SPLIT from booking_flow
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── add_requests_screen/              # Screen 19 folder
│   ├── add_requests_screen.dart      # SPLIT from booking_flow
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── review_details_screen/            # Screen 20 folder
│   ├── review_details_screen.dart    # SPLIT from booking_flow
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── payment_screen/                   # Screen 21 folder
│   ├── payment_screen.dart           # MOVE from backup/screens/payment/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/                      # ✅ EXISTS (well organized)
├── booking_confirmation_screen/      # Screen 22 folder
│   ├── booking_confirmation_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── deals_browse_screen/              # Screen 25 folder
│   ├── deals_browse_screen.dart      # MOVE from backup/screens/home/deals_screen.dart
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── deal_detail_screen/               # Screen 26 folder
│   ├── deal_detail_screen.dart       # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── search_results_screen/            # Screen 27 folder
│   ├── search_results_screen.dart    # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── favorites_screen/                 # Screen 28 folder
│   ├── favorites_screen.dart         # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── write_review_screen/              # Screen 29 folder
│   ├── write_review_screen.dart      # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── my_reviews_screen/                # Screen 30 folder
│   ├── my_reviews_screen.dart        # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── create_business_screen/           # Screen 31 folder
│   ├── create_business_screen.dart   # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── business_verification_screen/     # Screen 32 folder
│   ├── business_verification_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── business_setup_wizard_screen/     # Screen 33 folder
│   ├── business_setup_wizard_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── business_switcher_screen/         # Screen 34 folder
│   ├── business_switcher_screen.dart # CREATE new (multi-business)
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── business_profile_screen/          # Screen 36 folder
│   ├── business_profile_screen.dart  # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── edit_business_profile_screen/     # Screen 37 folder
│   ├── edit_business_profile_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── booking_management_screen/        # Screen 38 folder
│   ├── booking_management_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── business_booking_detail_screen/   # Screen 39 folder
│   ├── business_booking_detail_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── booking_calendar_screen/          # Screen 40 folder
│   ├── booking_calendar_screen.dart  # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── check_in_screen/                  # Screen 41 folder
│   ├── check_in_screen.dart          # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── deals_list_screen/                # Screen 42 folder
│   ├── deals_list_screen.dart        # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── edit_deal_screen/                 # Screen 44 folder
│   ├── edit_deal_screen.dart         # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── deal_analytics_screen/            # Screen 45 folder
│   ├── deal_analytics_screen.dart    # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── team_management_screen/           # Screen 46 folder
│   ├── team_management_screen.dart   # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── invite_team_member_screen/        # Screen 47 folder
│   ├── invite_team_member_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── team_permissions_screen/          # Screen 48 folder
│   ├── team_permissions_screen.dart  # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── analytics_dashboard_screen/       # Screen 49 folder
│   ├── analytics_dashboard_screen.dart # MOVE from backup/screens/business/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/                      # ✅ EXISTS (many widgets)
├── revenue_optimization_screen/      # Screen 50 folder
│   ├── revenue_optimization_screen.dart # MOVE from backup/screens/business/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── customer_insights_screen/         # Screen 51 folder
│   ├── customer_insights_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── payouts_screen/                   # Screen 52 folder
│   ├── payouts_screen.dart           # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── reviews_management_screen/        # Screen 53 folder
│   ├── reviews_management_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── reply_to_review_screen/           # Screen 54 folder
│   ├── reply_to_review_screen.dart   # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── become_guide_screen/              # Screen 55 folder
│   ├── become_guide_screen.dart      # RENAME from backup/screens/guide/guide_role_screen.dart
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── guide_dashboard_screen/           # Screen 56 folder
│   ├── guide_dashboard_screen.dart   # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── guide_profile_screen/             # Screen 57 folder
│   ├── guide_profile_screen.dart     # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── edit_guide_profile_screen/        # Screen 58 folder
│   ├── edit_guide_profile_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── guide_bookings_screen/            # Screen 59 folder
│   ├── guide_bookings_screen.dart    # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── create_experience_screen/         # Screen 60 folder
│   ├── create_experience_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── guide_payouts_screen/             # Screen 61 folder
│   ├── guide_payouts_screen.dart     # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── room_detail_screen/               # Screen 63 folder
│   ├── room_detail_screen.dart       # MOVE from backup/screens/community/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── social_discovery_screen/          # Screen 65 folder
│   ├── social_discovery_screen.dart  # MOVE from backup/screens/social/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── user_search_screen/               # Screen 66 folder
│   ├── user_search_screen.dart       # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── group_booking_screen/             # Screen 67 folder
│   ├── group_booking_screen.dart     # MOVE from backup/screens/social/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/                      # ✅ EXISTS (well organized)
├── direct_message_screen/            # Screen 68 folder
│   ├── direct_message_screen.dart    # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── conversations_list_screen/        # Screen 69 folder
│   ├── conversations_list_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── cultural_ambassador_application_screen/ # Screen 70 folder
│   ├── cultural_ambassador_application_screen.dart # MOVE from backup/screens/cultural/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/                      # ✅ EXISTS (well organized)
├── cultural_ambassador_dashboard_screen/ # Screen 71 folder
│   ├── cultural_ambassador_dashboard_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── settings_main_screen/             # Screen 72 folder
│   ├── settings_main_screen.dart     # MOVE from backup/screens/profile/settings_screen.dart
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── account_settings_screen/          # Screen 73 folder
│   ├── account_settings_screen.dart  # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── payment_methods_screen/           # Screen 74 folder
│   ├── payment_methods_screen.dart   # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── notification_settings_screen/     # Screen 75 folder
│   ├── notification_settings_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── privacy_settings_screen/          # Screen 76 folder
│   ├── privacy_settings_screen.dart  # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── notifications_center_screen/      # Screen 77 folder
│   ├── notifications_center_screen.dart # MOVE from backup/screens/notifications/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── premium_upgrade_screen/           # Screen 78 folder
│   ├── premium_upgrade_screen.dart   # MOVE from backup/screens/profile/premium_role_screen.dart
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/                      # ✅ EXISTS (well organized)
├── support_screen/                   # Screen 79 folder
│   ├── support_screen.dart           # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── error_screen/                     # Screen 80 folder
│   ├── error_screen.dart             # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── empty_state_screen/               # Screen 81 folder
│   ├── empty_state_screen.dart       # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── admin_login_screen/               # Screen 82 folder
│   ├── admin_login_screen.dart       # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── user_management_screen/           # Screen 83 folder
│   ├── user_management_screen.dart   # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── content_moderation_screen/        # Screen 84 folder
│   ├── content_moderation_screen.dart # CREATE new
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
├── platform_analytics_screen/       # Screen 85 folder
│   ├── platform_analytics_screen.dart # MOVE from backup/screens/admin/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── utils/
│   └── widgets/
└── dev_menu_screen/                  # Screen 86 folder
    ├── dev_menu_screen.dart          # CREATE new
    ├── models/
    ├── services/
    ├── providers/
    ├── utils/
    └── widgets/
```

## COMPLETE IMPLEMENTATION PLAN

**PHASE 1: REORGANIZE EXISTING (35 screens to move)**
1. Create folders for existing screens from backup/
2. Move screen files to main screen.dart in each folder
3. Organize existing widgets into screen-specific folders
4. Update all imports throughout codebase

**PHASE 2: CREATE MISSING SCREENS (51 new screens)**
1. Missing auth screens (3): verify_email, forgot_password, reset_password
2. Missing personal screens (15): bookings, reviews, favorites, profiles
3. Missing business screens (20): onboarding, team, analytics, reviews
4. Missing guide screens (6): dashboard, profile, bookings, experiences
5. Missing community screens (5): messaging, user search
6. Missing shared screens (2): support, error handling

**PHASE 3: ENHANCE ARCHITECTURE**
│   ├── onboarding/
│   │   ├── create_business_screen.dart # CREATE new
│   │   ├── business_verification_screen.dart # CREATE new
│   │   └── business_setup_wizard_screen.dart # CREATE new
│   ├── switcher/
│   │   └── business_switcher_screen.dart # CREATE new (multi-business)
│   └── [businessId]/                 # NEW: per-business structure
│       ├── dashboard/
│       │   └── business_dashboard_screen.dart # MOVE from backup/screens/business/
│       ├── profile/
│       │   ├── business_profile_screen.dart # CREATE new
│       │   └── edit_business_profile_screen.dart # CREATE new
│       ├── bookings/
│       │   ├── booking_management_screen.dart # CREATE new
│       │   ├── booking_detail_screen.dart # CREATE new
│       │   ├── booking_calendar_screen.dart # CREATE new
│       │   └── check_in_screen.dart   # CREATE new
│       ├── deals/
│       │   ├── deals_list_screen.dart # CREATE new
│       │   ├── create_deal_screen.dart # MOVE from backup/screens/business/
│       │   ├── edit_deal_screen.dart  # CREATE new
│       │   └── deal_analytics_screen.dart # CREATE new
│       ├── team/
│       │   ├── team_management_screen.dart # CREATE new
│       │   ├── invite_team_member_screen.dart # CREATE new
│       │   └── team_permissions_screen.dart # CREATE new
│       ├── analytics/
│       │   ├── analytics_dashboard_screen.dart # MOVE from backup/screens/business/
│       │   ├── revenue_screen.dart    # MOVE from backup/screens/business/revenue_optimization_screen.dart
│       │   └── customer_insights_screen.dart # CREATE new
│       ├── financials/
│       │   └── payouts_screen.dart    # CREATE new
│       └── reviews/
│           ├── reviews_management_screen.dart # CREATE new
│           └── reply_to_review_screen.dart # CREATE new
```

**Phase 3: Complete remaining modules**
```
├── guide/                            # EXPAND existing
│   ├── onboarding/
│   │   └── become_guide_screen.dart  # RENAME from backup/screens/guide/guide_role_screen.dart
│   ├── dashboard/
│   │   └── guide_dashboard_screen.dart # CREATE new
│   ├── profile/
│   │   ├── guide_profile_screen.dart # CREATE new
│   │   └── edit_guide_profile_screen.dart # CREATE new
│   ├── bookings/
│   │   └── guide_bookings_screen.dart # CREATE new
│   ├── experiences/
│   │   └── create_experience_screen.dart # CREATE new
│   └── financials/
│       └── guide_payouts_screen.dart # CREATE new
├── community/                        # REORGANIZE existing
│   ├── rooms/
│   │   ├── rooms_list_screen.dart    # MOVE from backup/screens/community/rooms_screen.dart
│   │   ├── room_detail_screen.dart   # MOVE from backup/screens/community/
│   │   └── room_chat_screen.dart     # MOVE from backup/screens/community/
│   ├── social/
│   │   ├── social_discovery_screen.dart # MOVE from backup/screens/social/
│   │   ├── user_search_screen.dart   # CREATE new
│   │   └── group_booking_screen.dart # MOVE from backup/screens/social/
│   └── messaging/
│       ├── direct_message_screen.dart # CREATE new
│       └── conversations_list_screen.dart # CREATE new
├── cultural/                         # EXPAND existing
│   ├── cultural_ambassador_application_screen.dart # MOVE from backup/screens/cultural/
│   └── cultural_ambassador_dashboard_screen.dart # CREATE new
├── shared/                           # REORGANIZE settings
│   ├── settings/
│   │   ├── settings_main_screen.dart # MOVE from backup/screens/profile/settings_screen.dart
│   │   ├── account_settings_screen.dart # CREATE new
│   │   ├── payment_methods_screen.dart # CREATE new
│   │   ├── notification_settings_screen.dart # CREATE new
│   │   └── privacy_settings_screen.dart # CREATE new
│   ├── notifications/
│   │   └── notifications_center_screen.dart # MOVE from backup/screens/notifications/
│   ├── premium/
│   │   └── premium_upgrade_screen.dart # MOVE from backup/screens/profile/premium_role_screen.dart
│   ├── support/
│   │   └── support_screen.dart       # CREATE new
│   └── errors/
│       ├── error_screen.dart         # CREATE new
│       └── empty_state_screen.dart   # CREATE new
├── admin/                            # EXPAND existing
│   ├── auth/
│   │   └── admin_login_screen.dart   # CREATE new
│   ├── users/
│   │   └── user_management_screen.dart # CREATE new
│   ├── moderation/
│   │   └── content_moderation_screen.dart # CREATE new
│   └── analytics/
│       └── platform_analytics_screen.dart # MOVE from backup/screens/admin/
└── dev/                              # CREATE new
    └── dev_menu_screen.dart          # CREATE new
```

## SUPPORTING ARCHITECTURE (Already Well Developed)

### KEEP & ENHANCE EXISTING
- **models/**: ✅ Solid foundation, add context models
- **services/**: ✅ Extensive, well-developed 
- **providers/**: ✅ Good state management, enhance for contexts
- **utils/**: ✅ Rich utilities, Morocco features
- **widgets/**: ✅ Excellent widget library

### MISSING CORE FILES TO CREATE
- **routes/**: Context-aware navigation system
- **Context models**: ActiveContext, ContextType enums
- **Multi-business support**: Business switcher logic
- **Team management**: Business team member permissions

## IMPLEMENTATION PLAN

**Phase 1: Reorganize Existing (PRIORITY 1)**
1. Create proper lib/screens/ structure
2. Move existing screens to correct locations
3. Update imports throughout codebase
4. Test existing functionality still works

**Phase 2: Complete Core Missing (PRIORITY 2)**  
1. Add missing auth screens (verify email, forgot password, reset)
2. Complete personal context screens (bookings, reviews, favorites)
3. Add business onboarding and profile management
4. Implement context switching system

**Phase 3: Scale Features (PRIORITY 3)**
1. Complete business module (team, analytics, reviews)
2. Build guide context fully
3. Add community messaging features
4. Implement admin tools

## PROGRESS TRACKING

### EXISTING SCREENS: ~35/86 (41% complete)
- Auth: 5/7 screens ✅
- Business: 4/24 screens ⚠️
- Community: 3/8 screens ⚠️
- Personal: 6/20 screens ⚠️
- Profile: 4/6 screens ✅
- Tourism: 2/7 screens ⚠️
- Admin: 2/4 screens ⚠️
- Others: Various scattered implementations

### ARCHITECTURE STRENGTH: 85% complete
- Services: Excellent ✅
- Models: Good foundation ✅
- Widgets: Rich library ✅
- Utils: Morocco-ready ✅
- Providers: Solid state management ✅
- Navigation: Needs context-aware upgrade ⚠️

**The codebase has excellent foundations but needs structural reorganization and completion of missing screens to match the 86-screen architecture.**