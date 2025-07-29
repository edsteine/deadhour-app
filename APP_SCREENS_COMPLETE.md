# DeadHour App - Complete Screen Directory
**All 34 Implemented Screens with Descriptions**

**Status**: ✅ **COMPLETE** - All screens functional and accessible  
**Implementation**: 155% of original MVP (34 vs 22 planned)  
**Last Updated**: July 28, 2025  

---

## 🔐 Authentication Flow (5 Screens)

### 1. **Splash Screen** (`/splash`)
- **File**: `splash_screen.dart`
- **Description**: App loading screen with DeadHour branding and Morocco cultural elements
- **Features**: Loading animation, brand recognition, smooth transition to onboarding

### 2. **Onboarding Screen** (`/onboarding`)
- **File**: `onboarding_screen.dart`
- **Description**: Welcome carousel explaining dual-problem platform (business optimization + social discovery)
- **Features**: Swipeable screens, network effects explanation, Morocco cultural integration

### 3. **Role Selection Screen** (`/user-type`)
- **File**: `role_marketplace_screen.dart`
- **Description**: Context-driven role addition when users need specific permissions (NOT part of onboarding)
- **Features**: Context-aware role selection, permission-based access, integration with role switching system
- **Usage**: Accessed when user tries action requiring specific role (create deal → Business role needed)

### 4. **Login Screen** (`/login`)
- **File**: `login_screen.dart`
- **Description**: User authentication with email/password
- **Features**: Form validation, secure login, password recovery, social login options

### 5. **Register Screen** (`/register`)
- **File**: `register_screen.dart` 
- **Description**: New user account creation (starts as Consumer by default)
- **Features**: Form validation, Consumer role auto-assignment, terms acceptance, email verification

---

## 🏠 Main Navigation & Discovery (6 Tab Views + 2 Screens)

### 6. **Main Navigation Screen** (`/deals`, `/venues`, `/community`, `/tourism`, `/notifications`, `/profile`)
- **File**: `main_navigation_screen.dart`
- **Description**: Unified 6-tab bottom navigation with dynamic app bar functionality
- **Architecture**: Single scaffold with TabBarView, not separate screens
- **Features**: Context-aware app bar buttons, unified navigation, mobile-optimized UX

#### **Tab View 1: Deals** (`/deals`) - **PRIMARY TAB**
- **Tab File**: `deals_screen.dart` (TabBarView content)
- **Description**: Primary tab for browsing all available dead hour deals with vertical scroll
- **App Bar Actions**: Map view toggle, Advanced filters
- **Features**: Deal filtering, category sorting, community validation, booking integration

#### **Tab View 2: Venues** (`/venues`) - **DEDICATED TAB**
- **Tab File**: `venue_discovery_screen.dart` (TabBarView content)
- **Description**: Dedicated tab for exploring nearby venues with dead hour opportunities
- **App Bar Actions**: Map view toggle, Venue filters
- **Features**: Map view, venue categories, search filters, social validation, location-based discovery

#### **Tab View 3: Community** (`/community`)
- **Tab File**: `rooms_screen.dart` (TabBarView content)
- **Description**: Browse category-based community rooms (Food, Entertainment, Tourism, etc.)
- **App Bar Actions**: Create room button
- **Features**: 6 room categories, active user counts, room previews

#### **Tab View 4: Tourism** (`/tourism`)
- **Tab File**: `tourism_screen.dart` (TabBarView content)
- **Description**: Cultural discovery experiences through local experts
- **App Bar Actions**: Tourism-specific actions (existing)
- **Features**: Authentic experiences, local guide connections, cultural calendar

#### **Tab View 5: Notifications** (`/notifications`)
- **Tab File**: `notifications_screen.dart` (TabBarView content)
- **Description**: Comprehensive notification center with community and booking updates
- **App Bar Actions**: Mark all as read button
- **Features**: Deal alerts, community activity, booking confirmations, categorized notifications

#### **Tab View 6: Profile** (`/profile`)
- **Tab File**: `profile_screen.dart` (TabBarView content)
- **Description**: User profile with network effects tracking and role management
- **App Bar Actions**: Settings button
- **Features**: Activity history, role switching, achievements, social connections

### 7. **Tourist Home Screen** (`/tourist-home`)
- **File**: `tourist_home_screen.dart`
- **Description**: Premium standalone home experience for tourists with cultural experiences (accessed outside main navigation)
- **Features**: Local expert recommendations, cultural discovery, premium tourism content

### 8. **Venue Details Screen** (`/venue-detail/1`)
- **File**: `venue_detail_screen.dart`
- **Description**: Detailed venue information with community reviews and current deals
- **Features**: Venue photos, community reviews, real-time deals, booking button

### 9. **Booking Flow Screen** (`/booking`)
- **File**: `booking_flow_screen.dart`
- **Description**: Complete booking process with group formation options
- **Features**: Time selection, group booking, payment integration, community sharing

### 10. **Payment Screen** (`/payment`)
- **File**: `payment_screen.dart`
- **Description**: Secure payment processing for bookings
- **Features**: Multiple payment methods, MAD/EUR currency, receipt generation

---

## 💬 Community Features (2 Screens)

### 11. **Room Detail Screen** (`/room/1`)
- **File**: `room_detail_screen.dart`
- **Description**: Individual room overview with member activity and recent deals
- **Features**: Room statistics, member list, recent activity, join/leave functionality

### 12. **Room Chat Screen** (`/room/1/chat`)
- **File**: `room_chat_screen.dart`
- **Description**: Real-time chat with deal integration and community validation
- **Features**: Live messaging, deal sharing, community endorsements, emoji reactions

---

## 💼 Business Features (4 Screens)

### 17. **Business Dashboard** (`/business`)
- **File**: `business_dashboard_screen.dart`
- **Description**: Business owner analytics showing network effects and dead hour performance
- **Features**: Revenue analytics, community engagement metrics, deal performance

### 18. **Revenue Optimization Screen** (`/business/optimization`)
- **File**: `revenue_optimization_screen.dart`
- **Description**: Dead hours analysis with community-driven optimization strategies
- **Features**: Peak vs dead hour comparison, community impact analysis, ROI projections

### 19. **Create Deal Screen** (`/business/create-deal`)
- **File**: `create_deal_screen.dart`
- **Description**: Business owners create and manage dead hour deals
- **Features**: Deal creation form, time scheduling, community targeting, pricing tools

### 20. **Business Analytics Screen** (`/business/analytics`)
- **File**: `analytics_dashboard_screen.dart`
- **Description**: Comprehensive business performance analytics with community correlation
- **Features**: Revenue tracking, customer acquisition, community engagement impact

---

## 🌍 Tourism & Cultural Features (2 Screens)

### 21. **Local Expert Screen** (`/local-expert`)
- **File**: `local_expert_screen.dart`
- **Description**: Cultural guide profiles and expertise monetization
- **Features**: Expert profiles, service offerings, community endorsements, booking system

### 22. **Social Discovery Screen** (`/social-discovery`)
- **File**: `social_discovery_screen.dart`
- **Description**: Enhanced social networking features for experience discovery
- **Features**: User connections, experience sharing, social validation, recommendation engine

---

## 👥 Social & Group Features (1 Screen)

### 23. **Group Booking Screen** (`/group-booking`)
- **File**: `group_booking_screen.dart`
- **Description**: Coordinate group bookings for social experiences
- **Features**: Group formation, split payments, social coordination, event planning

---

## 🧑‍💼 Profile & Account Management (4 Screens)

### 24. **User Profile Screen** (`/profile`)
- **File**: `profile_screen.dart`
- **Description**: User profile with network effects tracking and role management
- **Features**: Activity history, role switching, achievements, social connections

### 25. **Settings Screen** (`/settings`)
- **File**: `settings_screen.dart`
- **Description**: App configuration with Morocco cultural integration
- **Features**: Language selection (Arabic RTL, French, English), privacy settings, notifications

### 26. **Role Switching Screen** (`/roles/switching`)
- **File**: `role_switching_screen.dart`
- **Description**: Instagram-inspired interface for switching between active roles
- **Features**: Role toggle, active role management, role-specific features access

### 27. **Premium Role Screen** (`/roles/premium`)
- **File**: `premium_role_screen.dart`
- **Description**: Premium subscription tier with enhanced features across all roles
- **Features**: Premium benefits, ROI calculator, subscription management, feature unlocks

---

## ⚙️ Enhanced Settings (2 Screens)

### 28. **Accessibility Settings Screen** (`/settings/accessibility`)
- **File**: `accessibility_settings_screen.dart`
- **Description**: Inclusive design features with Morocco cultural accessibility
- **Features**: Screen reader compatibility, Arabic RTL support, Islamic calendar integration

### 29. **Offline Settings Screen** (`/settings/offline`)
- **File**: `offline_settings_screen.dart`
- **Description**: Offline functionality for Morocco's connectivity landscape
- **Features**: Data caching, offline mode settings, sync management, storage optimization

---

## 🔔 Engagement Features (1 Screen)

### 30. **Notifications Screen** (`/notifications`)
- **File**: `notifications_screen.dart`
- **Description**: Comprehensive notification center with community and booking updates
- **Features**: Deal alerts, community activity, booking confirmations, bottom navigation tab

---

## 🛠️ Administrative Features (3 Screens)

### 31. **Network Effects Dashboard** (`/admin`)
- **File**: `network_effects_dashboard_screen.dart`
- **Description**: Central admin view of platform performance and dual-problem network effects
- **Features**: Cross-problem metrics, real-time activity, platform health monitoring

### 32. **Community Health Dashboard** (`/admin/community-health`)
- **File**: `community_health_dashboard_screen.dart`
- **Description**: Advanced community management analytics and health metrics
- **Features**: Community engagement tracking, moderation tools, growth analytics

### 33. **Guide Role Screen** (`/guide`)
- **File**: `guide_role_screen.dart`
- **Description**: Cultural guide dashboard for local experts sharing Morocco expertise
- **Features**: Guide services management, cultural content creation, earnings tracking

---

## 🔮 Future Features (1 Screen)

### 34. **Cultural Ambassador Application** (`/cultural-ambassador-application`)
- **File**: `cultural_ambassador_application_screen.dart`
- **Description**: Full application system for becoming a certified cultural ambassador
- **Features**: Application form, certification process, cultural expertise validation

---

## 📊 Implementation Statistics

- **Total Screens**: 34 (155% of original 22-screen specification)
- **Core MVP**: 22 screens (100% complete)
- **Enhanced MVP**: 12 additional screens (bonus features)
- **File Coverage**: All screens have dedicated Dart files in `lib/screens/`
- **Routing**: 100% functional with GoRouter navigation
- **Dev Menu Access**: All screens accessible for testing

## 🎯 Screen Categories Summary

| Category | Count | Purpose |
|----------|-------|---------|
| Authentication | 5 | User onboarding and access |
| Home & Discovery | 8 | Core user experience and deal discovery |
| Community | 3 | Social features and room-based interactions |
| Business | 4 | Business owner tools and analytics |
| Tourism & Cultural | 2 | Premium cultural experiences |
| Social & Groups | 1 | Group coordination features |
| Profile & Account | 4 | User management and role switching |
| Enhanced Settings | 2 | Accessibility and offline features |
| Engagement | 1 | Notifications and user retention |
| Administrative | 3 | Platform management and analytics |
| Future Features | 1 | Prepared for full app expansion |

## 🚀 Network Effects Integration

Each screen demonstrates the dual-problem platform concept:
- **Business Problem**: Dead hour optimization through community-driven bookings
- **Social Discovery**: Authentic experiences through community validation
- **Network Effects**: Each problem solved amplifies the other, creating exponential value

## 📱 Mobile-First Navigation Architecture

**Main Navigation: Single Screen with 6 Tab Views**
- **Screen**: `MainNavigationScreen` - Unified scaffold with TabBarView
- **Architecture**: Not separate screens - tab views within single navigation container
- **App Bar**: Dynamic buttons that change based on active tab

**6-Tab Bottom Navigation (Mobile-Optimized):**
```
[Deals] [Venues] [Community] [Explore] [Notifications] [Profile]
   ↑        ↑         ↑          ↑            ↑           ↑
Primary  Locations  Social    Tourism    Engagement   Account
```

**Tab View Architecture:**
- **Tab 1: Deals** - `DealsScreen` (TabBarView content, not standalone screen)
- **Tab 2: Venues** - `VenueDiscoveryScreen` (TabBarView content, not standalone screen)  
- **Tab 3: Community** - `RoomsScreen` (TabBarView content, not standalone screen)
- **Tab 4: Tourism** - `TourismScreen` (TabBarView content, not standalone screen)
- **Tab 5: Notifications** - `NotificationsScreen` (TabBarView content, not standalone screen)
- **Tab 6: Profile** - `ProfileScreen` (TabBarView content, not standalone screen)

**Dynamic App Bar Actions by Tab:**
- **Deals**: Map view toggle + Advanced filters
- **Venues**: Map view toggle + Venue filters
- **Community**: Create room button
- **Tourism**: Tourism-specific menu (existing)
- **Notifications**: Mark all as read
- **Profile**: Settings navigation 

**Mobile UX Benefits:**
- **Unified Experience**: Single app bar with dynamic actions vs multiple app bars
- **Separated Concerns**: Deals and Venues have dedicated tabs (no combined "Discovery")
- **Context-Aware Actions**: App bar buttons adapt to current tab functionality
- **Reduced Cognitive Load**: Clear single-purpose tabs
- **Performance**: TabBarView architecture vs separate route navigation

## 👤 Guest-First User Experience

**Current Flow (Updated):**
```
App Start → Splash → Onboarding → Deals Tab (Guest Mode)
    ↓ (only when user tries action requiring authentication)
Login/Register → Deals Tab (Consumer by default)
    ↓ (only when user needs specific role permissions)
Context-Driven Role Addition → Action Completion
```

**Key Benefits:**
- **No Forced Login**: Users can browse deals, venues, and community rooms without authentication
- **Consumer Default**: All authenticated users start with Consumer role (free)
- **Progressive Unlocking**: Additional roles (Business, Guide, Premium) added only when needed
- **Reduced Friction**: Authentication triggered only by specific actions that require permissions
- **Mobile-Optimized**: Single-purpose tabs reduce cognitive load

---

**This document serves as the definitive reference for all implemented screens in the DeadHour app.**