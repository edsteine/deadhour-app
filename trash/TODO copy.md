# DeadHour Code Refactoring TODO

## 🎯 Target: Keep files under 500 lines (max 800 lines)
**Current Status**: 33 files exceed 500 lines (20% of codebase)

**Strategy**: Start with worst files first, one at a time, divide and conquer approach

## 📋 FILE SPLITTING RULES (MANDATORY)

**SAFER BACKUP APPROACH - When refactoring ANY file, follow this exact process:**

1. **Create backup first** - Rename original file to `filename.dart.bak` (e.g., `main_navigation_screen.dart.bak`)
2. **Read entire backup** - Read the whole `.bak` file to understand the complete code
3. **Create new smaller files** - Split the code into multiple smaller files (under 500 lines each)
4. **Import/export properly** - Ensure all imports and exports work between new files
5. **Run linter** - Run `flutter analyze` and fix all errors/warnings
6. **Test thoroughly** - Test all functionality works with the new split files
7. **Keep backup** - Never delete the `.bak` file until confirmed everything works

**CRITICAL RULE: Work on ONE file at a time**
- Complete the entire splitting process for ONE file
- Wait for user approval before moving to the next file
- Never work on multiple files simultaneously
- Always ask "Ready for next file?" before proceeding

**This prevents code loss and ensures safe refactoring with full backup.**

---

## FILES TO REFACTOR

### 🚨 CRITICAL (1000+ lines) - Immediate Refactoring Required

**`lib/screens/home/main_navigation_screen.dart` - ✅ COMPLETED** ~~1,687 lines~~ → **109 lines**
- **Status**: REFACTORED SUCCESSFULLY 
- **What was done**: Split into 7 smaller files (navigation controller, custom bottom nav, app bars, filters, dialogs, widgets)
- **Files created**: navigation/, filters/, dialogs/, widgets/ directories with modular components
- **Result**: 15x smaller main file, all under 500 lines, no linter errors, fully functional
- **Backup**: Saved as `.bak` file

**`lib/screens/home/deals_screen.dart` - ✅ COMPLETED** ~~1,441 lines~~ → **299 lines**
- **Status**: REFACTORED SUCCESSFULLY (82% reduction)
- **What was done**: Split into 6 modular components (filters, list/map views, header, banner, interaction service)
- **Files created**: filters/, widgets/, services/ directories with specialized components
- **Result**: 5x smaller main file, all under 500 lines, no linter errors, fully functional
- **Backup**: Saved as `.bak` file

**`lib/screens/venues/venue_detail_screen.dart` - ✅ COMPLETED** ~~1,420 lines~~ → **165 lines**
- **Status**: REFACTORED SUCCESSFULLY (88% reduction)
- **What was done**: Split into 6 modular components (header, booking flow, amenities, deals, reviews, info)
- **Files created**: widgets/ directory with specialized venue components
- **Result**: 9x smaller main file, all under 500 lines, no linter errors, fully functional
- **Backup**: Saved as `.bak` file

**`lib/screens/home/venue_discovery_screen.dart` - ✅ COMPLETED** ~~1,357 lines~~ → **210 lines**
- **Status**: REFACTORED SUCCESSFULLY (85% reduction)
- **What was done**: Split into 6 modular components (map view, filters, list view, nearby view, venue cards, discovery service)
- **Files created**: widgets/ and services/ directories with specialized discovery components
- **Result**: 6x smaller main file, all under 500 lines, no linter errors, fully functional
- **Backup**: Saved as `.bak` file

**`lib/widgets/common/dead_hour_app_bar.dart` - ✅ COMPLETED** ~~1,187 lines~~ → **232 lines**
- **Status**: REFACTORED SUCCESSFULLY (80% reduction)
- **What was done**: Split into 6 modular components (notification badge, role switcher, actions, location selector, cultural timing, theming)
- **Files created**: widgets/ and themes/ directories with specialized app bar components
- **Result**: 5x smaller main file, all under 500 lines, no linter errors, full functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/profile/profile_screen.dart` - ✅ COMPLETED** ~~1,015 lines~~ → **197 lines**
- **Status**: REFACTORED SUCCESSFULLY (81% reduction)
- **What was done**: Split into 6 modular components (header, auth, settings, role management, activity, app features, support)
- **Files created**: widgets/ directory with specialized profile components
- **Result**: 5x smaller main file, all under 500 lines, no linter errors, full functionality preserved
- **Backup**: Saved as `.bak` file

### ⚠️ HIGH PRIORITY (800-1000 lines)

**`lib/screens/business/analytics_dashboard_screen.dart` - ✅ COMPLETED** ~~964 lines~~ → **178 lines**
- **Status**: REFACTORED SUCCESSFULLY (82% reduction)
- **What was done**: Split into 4 modular tab widgets + 8 specialized chart/component widgets + 1 period selector
- **Files created**: widgets/ directory with analytics tab components and chart widgets
- **Result**: 5x smaller main file, all under 500 lines, no linter errors, full functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/cultural/cultural_ambassador_application_screen.dart` - ✅ COMPLETED** ~~923 lines~~ → **91 lines**
- **Status**: REFACTORED SUCCESSFULLY (90% reduction)
- **What was done**: Split into 4 step widgets + state management + success dialog + review components
- **Files created**: application_state.dart + 8 specialized step and component widgets
- **Result**: 10x smaller main file, all under 500 lines, no linter errors, full functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/payment/payment_screen.dart` - ✅ COMPLETED** ~~923 lines~~ → **107 lines**
- **Status**: REFACTORED SUCCESSFULLY (88% reduction)
- **What was done**: Split into payment state management + 10 specialized payment widgets + utilities
- **Files created**: payment_state.dart + widgets/ directory with payment forms and success dialog + utils/ for formatters
- **Result**: 9x smaller main file, all under 500 lines, no linter errors, full functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/home/tourist_home_screen.dart` - ✅ COMPLETED** ~~914 lines~~ → **107 lines**
- **Status**: REFACTORED SUCCESSFULLY (88% reduction)
- **What was done**: Split into 8 specialized tourist widgets with Morocco-specific features
- **Files created**: widgets/ directory with tourist-focused components for welcome, cultural insights, deals, and experiences
- **Result**: 9x smaller main file, all under 500 lines, no linter errors, full tourist functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/profile/premium_role_screen.dart` - ✅ COMPLETED** ~~825 lines~~ → **242 lines**
- **Status**: REFACTORED SUCCESSFULLY (71% reduction)
- **What was done**: Split into 7 specialized premium widgets (hero, pricing, features, comparison, testimonials, CTA, management)
- **Files created**: widgets/ directory with modular premium components
- **Result**: 3x smaller main file, all under 500 lines, no linter errors, full premium functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/admin/community_health_dashboard_screen.dart` - ✅ COMPLETED** ~~815 lines~~ → **92 lines**
- **Status**: REFACTORED SUCCESSFULLY (89% reduction)
- **What was done**: Split into 6 specialized health dashboard components (controls, metrics overview, 4 tab widgets)
- **Files created**: widgets/ directory with modular health analytics components
- **Result**: 9x smaller main file, all under 500 lines, no linter errors, full community health functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/profile/role_switching_screen.dart` - ✅ COMPLETED** ~~797 lines~~ → **183 lines**
- **Status**: REFACTORED SUCCESSFULLY (77% reduction)
- **What was done**: Split into 5 specialized role management widgets + shared role data utility
- **Files created**: widgets/ directory with role components + utils/role_data.dart for centralized configuration
- **Result**: 4x smaller main file, all under 500 lines, no linter errors, full role switching functionality preserved
- **Backup**: Saved as `.bak` file

### 📋 MEDIUM PRIORITY (500-800 lines)

**`lib/screens/tourism/widgets/real_time_booking_widget.dart` - ✅ COMPLETED** ~~783 lines~~ → **242 lines**
- **Status**: REFACTORED SUCCESSFULLY (69% reduction)
- **What was done**: Split into 9 specialized booking flow widgets (header, availability, date/time selection, participants, contact, pricing, action button, dialogs)
- **Files created**: booking/ directory with modular booking step components
- **Result**: 3x smaller main file, all under 500 lines, no linter errors, full real-time booking functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/business/create_deal_screen.dart` - ✅ COMPLETED** ~~737 lines~~ → **164 lines**
- **Status**: REFACTORED SUCCESSFULLY (78% reduction)  
- **What was done**: Split into 8 specialized deal form widgets (header, suggestions, information, type selection, schedule, capacity, community, actions)
- **Files created**: widgets/ directory with modular deal form components
- **Result**: 4x smaller main file, all under 500 lines, no linter errors, full deal creation functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/community/room_chat_screen.dart` - ✅ COMPLETED** ~~713 lines~~ → **229 lines**
- **Status**: REFACTORED SUCCESSFULLY (68% reduction)
- **What was done**: Split into 5 specialized chat widgets + 2 service classes (filters, messages list, typing indicator, reactions, action buttons, real-time service, message service)
- **Files created**: widgets/ and services/ directories with modular chat components
- **Result**: 3x smaller main file, all under 500 lines, no linter errors, full chat functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/social/group_booking_screen.dart` - ✅ COMPLETED** ~~700 lines~~ → **80 lines**
- **Status**: REFACTORED SUCCESSFULLY (89% reduction)
- **What was done**: Split into 10 specialized group booking widgets (stats header, tab bar, 4 tab contents, booking card, deal opportunity card, empty state, dialogs)
- **Files created**: widgets/ directory with modular group booking components
- **Result**: 9x smaller main file, all under 500 lines, no linter errors, full group booking functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/widgets/maps/map_view_widget.dart` - ✅ COMPLETED** ~~674 lines~~ → **110 lines**
- **Status**: REFACTORED SUCCESSFULLY (84% reduction)
- **What was done**: Split into 6 specialized map widgets + 1 model + 1 service (background, markers, controls, filter chips, style selector, location details, map location model, map data service)
- **Files created**: widgets/, models/, and services/ directories with modular map components
- **Result**: 6x smaller main file, all under 500 lines, no linter errors, full map functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/notifications/notifications_screen.dart` - ✅ COMPLETED** ~~671 lines~~ → **80 lines**
- **Status**: REFACTORED SUCCESSFULLY (88% reduction)
- **What was done**: Split into 5 specialized notification widgets + 2 list handlers + 1 helper utility (smart header, stats header, notifications list, grouped list, relevant list, notification card, empty state, helpers)
- **Files created**: widgets/ and utils/ directories with modular notification components
- **Result**: 8x smaller main file, all under 500 lines, no linter errors, full notification functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/utils/mock_data.dart` - ✅ COMPLETED** ~~655 lines~~ → **23 lines**
- **Status**: REFACTORED SUCCESSFULLY (96% reduction)
- **What was done**: Split into 5 specialized data category files (venues, deals, users, rooms, analytics)
- **Files created**: data/ directory with categorized mock data providers
- **Result**: 28x smaller main file, all under 500 lines, no linter errors, full mock data functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/admin/network_effects_dashboard_screen.dart` - ✅ COMPLETED** ~~646 lines~~ → **94 lines**
- **Status**: REFACTORED SUCCESSFULLY (85% reduction)
- **What was done**: Split into 8 specialized network analytics widgets (KPIs, monthly effects, multipliers, health metrics, optimization, Ramadan optimization, dialogs, actions)
- **Files created**: widgets/ directory with modular network analytics components
- **Result**: 7x smaller main file, all under 500 lines, no linter errors, full network effects functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/widgets/deals/deal_validation_widget.dart` - ✅ COMPLETED** ~~637 lines~~ → **92 lines**
- **Status**: REFACTORED SUCCESSFULLY (86% reduction)
- **What was done**: Split validation rules and UI into 10 specialized validation components (compact view, header, rating details, validations list, cards, actions, dialogs, utils)
- **Files created**: validation/ directory with modular validation components
- **Result**: 7x smaller main file, all under 500 lines, no linter errors, full validation functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/home/booking_flow_screen.dart` - ✅ COMPLETED** ~~635 lines~~ → **171 lines**
- **Status**: REFACTORED SUCCESSFULLY (73% reduction)
- **What was done**: Extract booking steps into 10 specialized booking flow components (deal summary, options, time selection, social booking, cultural timing, special requests, payment, total, confirmation)
- **Files created**: booking/ directory with modular booking step components
- **Result**: 4x smaller main file, all under 500 lines, no linter errors, full booking flow functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/widgets/biometric/biometric_auth_widget.dart` - ✅ REMOVED** ~~612 lines~~ → **TRASHED**
- **Status**: MOVED TO TRASH (violates NO BIOMETRIC FEATURES rule)
- **What was done**: Moved to trash folder as biometric authentication is not allowed per project security guidelines
- **Reason**: Project uses standard email/password and Firebase Auth only - no biometric features permitted
- **Location**: `/trash/biometric_auth_widget_[timestamp].dart`

**`lib/screens/community/widgets/rich_media_widget.dart` - ✅ COMPLETED** ~~585 lines~~ → **147 lines**
- **Status**: REFACTORED SUCCESSFULLY (75% reduction)
- **What was done**: Extract media types into 6 specialized media components (header, type filter, grid, card, empty state, details dialog)
- **Files created**: media/ directory with modular community media components
- **Result**: 4x smaller main file, all under 500 lines, no linter errors, full rich media functionality preserved
- **Backup**: Saved as `.bak` file

**`lib/screens/settings/offline_settings_screen.dart` - 565 lines**
- **What to do**: Split settings categories

**`lib/screens/auth/register_screen.dart` - 555 lines**
- **What to do**: Extract registration steps

**`lib/utils/error_utils.dart` - 543 lines**
- **What to do**: Split by error types and handlers

**`lib/screens/auth/login_screen.dart` - 541 lines**
- **What to do**: Extract login methods and forms

**`lib/screens/web_companion/web_companion_screen.dart` - 540 lines**
- **What to do**: Split web features

**`lib/services/smart_notification_service.dart` - 539 lines**
- **What to do**: Split notification types and logic

**`lib/services/web_companion_service.dart` - 510 lines**
- **What to do**: Split web sync features

**`lib/screens/tourism/local_expert_screen.dart` - 502 lines**
- **What to do**: Extract expert profile components

---

## 🚨 CRITICAL BUG - Navigation Issues

**Navigation Back Button Problem**
- **Issue**: Users can navigate to screens but cannot go back
- **What to do**: 
  - Check all screen navigations use proper Flutter navigation (Navigator.push/pop)
  - Ensure AppBar back buttons are working
  - Verify route definitions in `lib/routes/app_routes.dart`
  - Test navigation flow between all screens
  - Add proper route handling for deep links
- **Priority**: Fix immediately - blocks user experience

---

## 📊 SUMMARY

- **Total files**: 165 Dart files (54,318 lines)
- **Files to refactor**: 33 files
- **Timeline**: 6-8 weeks (Critical → High → Medium priority)
- **Success metric**: All files under 500 lines