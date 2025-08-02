# DeadHour App - Complete Development TODO

## 🎯 CURRENT PRIORITIES

### 1. FILES REQUIRING IMMEDIATE REFACTORING (Multiple Classes/Enums/500+ Lines)

Based on comprehensive analysis of the entire `/lib` directory, the following files violate single responsibility principle and need immediate refactoring:

#### 🚨 CRITICAL - Extreme SRP Violations (5+ Classes or 1000+ Lines)

**`/Users/edsteine/Desktop/deadhour-app/lib/screens/home/main_navigation_screen.dart`** - **1,763 lines, 4 classes**
- **Classes Found**: MainNavigationScreen, _MainNavigationScreenState, NavigationController, CustomBottomNavigation
- **What to Split**: Main navigation logic, custom bottom navigation, navigation controller, page management
- **Target**: 4 separate files under 500 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/screens/venues/venue_detail_screen.dart`** - **1,518 lines, 2 classes**
- **Classes Found**: VenueDetailScreen, _VenueDetailScreenState  
- **What to Split**: Venue header, booking flow, amenities display, deals section, reviews section, venue info
- **Target**: 6 separate widget files under 300 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/screens/business/analytics_dashboard_screen.dart`** - **1,028 lines, 2 classes**
- **Classes Found**: AnalyticsDashboardScreen, _AnalyticsDashboardScreenState
- **What to Split**: Analytics tabs, chart widgets, KPI cards, performance metrics, revenue tracking
- **Target**: 8 separate files under 200 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/screens/home/venue_discovery_screen.dart`** - **1,016 lines, 2 classes** 
- **Classes Found**: VenueDiscoveryScreen, _VenueDiscoveryScreenState
- **What to Split**: Map view, filters, list view, venue cards, discovery service, nearby venues
- **Target**: 6 separate files under 200 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/screens/payment/payment_screen.dart`** - **994 lines, 4 classes**
- **Classes Found**: PaymentScreen, _PaymentScreenState, PaymentState, PaymentMethodType
- **What to Split**: Payment forms, method selector, booking summary, success dialog, payment state management
- **Target**: 8 separate files under 150 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/screens/profile/profile_screen.dart`** - **968 lines, 2 classes**
- **Classes Found**: ProfileScreen, _ProfileScreenState
- **What to Split**: Profile header, auth widget, settings, role management, activity, app features, support
- **Target**: 7 separate files under 150 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/screens/home/tourist_home_screen.dart`** - **945 lines, 2 classes**
- **Classes Found**: TouristHomeScreen, _TouristHomeScreenState
- **What to Split**: Welcome section, cultural insights, deals display, experiences, local experts, quick actions
- **Target**: 8 separate files under 150 lines each

#### ⚠️ HIGH PRIORITY - Significant SRP Violations (3-5 Classes or 800+ Lines)

**`/Users/edsteine/Desktop/deadhour-app/lib/services/deal_validation_service.dart`** - **455 lines, 7 classes, 2 enums**
- **Classes**: DealValidationService, DealValidation, DealRating, UserRating, DealPhoto, ValidationSummary, TopValidator
- **Enums**: ValidationType, CommunityStatus
- **What to Split**: Service logic, validation models, rating models, photo models, summary models
- **Target**: 7 separate files under 100 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/services/auth_service.dart`** - **625 lines, 6 classes, 1 enum**
- **Classes**: AuthService, AuthException, InvalidCredentialsException, InvalidInputException, UnauthenticatedException, NetworkException  
- **Enums**: SocialProvider
- **What to Split**: Auth service, exception classes, social auth, validation logic
- **Target**: 5 separate files under 150 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/services/analytics_service.dart`** - **549 lines, 3 classes**
- **Classes**: AnalyticsService, AnalyticsData, AnalyticsEvent
- **What to Split**: Service logic, data models, event tracking
- **Target**: 3 separate files under 200 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/services/morocco_cultural_service.dart`** - **509 lines, 4 classes, 2 enums**
- **Classes**: MoroccoCulturalService, NextPrayerInfo, RamadanSchedule, CulturalHoliday
- **Enums**: HalalStatus, HolidayType  
- **What to Split**: Cultural service, prayer models, Ramadan logic, holiday models
- **Target**: 5 separate files under 120 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/services/accessibility_service.dart`** - **515 lines, 4 classes**
- **Classes**: AccessibilityService, AccessibilitySettings, VoiceOverHelper, ScreenReaderSupport
- **What to Split**: Main service, settings management, voice support, screen reader integration
- **Target**: 4 separate files under 150 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/widgets/maps/map_view_widget.dart`** - **757 lines, 5 classes, 1 enum**
- **Classes**: MapViewWidget, _MapViewWidgetState, MapLocation, MapGridPainter, StreetsOverlayPainter
- **Enums**: MapLocationType
- **What to Split**: Main widget, location model, grid painter, streets painter, map controls
- **Target**: 6 separate files under 150 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/widgets/performance/performance_monitor_widget.dart`** - **474 lines, 6 classes**
- **Classes**: PerformanceMonitorWidget, _PerformanceMonitorWidgetState, PerformanceMetrics, LoadTimeTracker, MemoryUsageTracker, NetworkLatencyTracker
- **What to Split**: Main widget, metrics collection, individual trackers
- **Target**: 5 separate files under 120 lines each

**`/Users/edsteine/Desktop/deadhour-app/lib/widgets/common/loading_widgets.dart`** - **508 lines, 5 classes**
- **Classes**: LoadingWidget, ShimmerLoading, PulseLoading, SkeletonLoading, ProgressIndicatorWidget
- **What to Split**: Individual loading widget types
- **Target**: 5 separate files under 120 lines each

#### 📋 MEDIUM PRIORITY - Multiple Classes/Enums (2-4 Classes or 500+ Lines)

**`/Users/edsteine/Desktop/deadhour-app/lib/utils/error_utils.dart`** - **593 lines, 5 classes, 1 enum**
- **Classes**: AppErrorHandler, AppError, TimeoutException, RetryMechanism, GlobalErrorWidget
- **Enums**: ErrorType
- **Split Into**: Error handler, error models, exceptions, retry logic, error widgets

**`/Users/edsteine/Desktop/deadhour-app/lib/utils/mock_data.dart`** - **651 lines, 1 class**
- **Classes**: MockData (extremely large single class)
- **Split Into**: Separate mock data providers for deals, venues, users, rooms, analytics

**`/Users/edsteine/Desktop/deadhour-app/lib/utils/constants.dart`** - **311 lines, 3 classes**
- **Classes**: AppConstants, ColorConstants, SizeConstants  
- **Split Into**: App config, color scheme, sizing system

**`/Users/edsteine/Desktop/deadhour-app/lib/utils/theme.dart`** - **265 lines, 4 classes**
- **Classes**: AppTheme, LightTheme, DarkTheme, ThemeExtension
- **Split Into**: Theme manager, light theme, dark theme, extensions

**`/Users/edsteine/Desktop/deadhour-app/lib/utils/performance_utils.dart`** - **205 lines, 3 classes, 1 enum**
- **Classes**: PerformanceUtils, PerformanceTracker, CacheManager
- **Enums**: PerformanceLevel
- **Split Into**: Performance utilities, tracking logic, cache management

**`/Users/edsteine/Desktop/deadhour-app/lib/widgets/common/enhanced_app_bar.dart`** - **426 lines, 5 classes**
- **Classes**: EnhancedAppBar, _EnhancedAppBarState, AppBarAction, NotificationBadge, LocationSelector
- **Split Into**: Main app bar, action widgets, notification system, location selector

**`/Users/edsteine/Desktop/deadhour-app/lib/widgets/common/professional_card.dart`** - **277 lines, 4 classes**
- **Classes**: ProfessionalCard, ProfessionalStats, ProfessionalActions, ProfessionalGradient
- **Split Into**: Card widget, stats display, action buttons, gradient effects

**`/Users/edsteine/Desktop/deadhour-app/lib/widgets/common/offline_status_widget.dart`** - **372 lines, 4 classes**
- **Classes**: OfflineStatusWidget, ConnectivityIndicator, SyncStatusWidget, DataFreshnessIndicator
- **Split Into**: Main widget, connectivity display, sync status, freshness indicator

### 2. SCREEN FOLDER REORGANIZATION

#### Current Structure Issues:
- Mixed organizational patterns across different screen types
- Some screens have dedicated folders, others don't
- Inconsistent placement of related widgets/services
- Need unified "ONE FOLDER PER SCREEN" approach

#### Target Structure: ONE FOLDER PER SCREEN

**Required Screen Folders** (remaining screens that need folder organization):

```
lib/screens/
├── splash_screen/
├── onboarding_screen/
├── login_screen/
├── register_screen/
├── home_screen/
├── deals_screen/
├── venues_screen/
├── venue_detail_screen/
├── tourism_screen/
├── local_expert_screen/
├── rooms_screen/
├── room_detail_screen/
├── booking_flow_screen/
├── payment_screen/
├── business_dashboard_screen/
├── create_deal_screen/
├── analytics_dashboard_screen/
├── revenue_optimization_screen/
├── profile_screen/
├── role_switching_screen/
├── role_marketplace_screen/
├── premium_role_screen/
├── community_health_dashboard_screen/
├── network_effects_dashboard_screen/
├── settings_screen/
├── accessibility_settings_screen/
├── offline_settings_screen/
├── social_discovery_screen/
├── group_booking_screen/ ✅
├── notifications_screen/
├── cultural_ambassador_application_screen/
├── dev_menu_screen/
├── main_navigation_screen/
├── guide_role_screen/
├── web_companion_screen/
└── shared/
    ├── widgets/
    ├── components/
    └── utils/
```

### 3. CRITICAL BUG FIXES

#### 🚨 Navigation Back Button Issues
- **Problem**: Users can navigate to screens but cannot go back
- **Fix Required**: 
  - Check all Navigator.push/pop implementations
  - Verify AppBar back button functionality  
  - Test route definitions in `/lib/routes/app_routes.dart`
  - Ensure proper GoRouter configuration
  - Add route handling for deep links

#### Import Statement Cleanup
- **Problem**: Many broken imports after previous refactoring
- **Fix Required**: Update all import paths to match new file locations

### 4. UNUSED/PROBLEMATIC FILES TO REMOVE

**Files marked for deletion/cleanup**:
```
/Users/edsteine/Desktop/deadhour-app/lib/utils/halal_filter_service.dart
/Users/edsteine/Desktop/deadhour-app/lib/utils/global_error_widget.dart  
/Users/edsteine/Desktop/deadhour-app/lib/utils/offline_data_info.dart
/Users/edsteine/Desktop/deadhour-app/lib/utils/performance_monitor.dart
/Users/edsteine/Desktop/deadhour-app/lib/utils/retry_mechanism.dart
/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/widgets/pull_to_refresh_wrapper.dart
/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/services/onboarding_step_extension.dart
/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/widgets/mock_auth_section.dart
/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/widgets/loading_state_wrapper.dart
/Users/edsteine/Desktop/deadhour-app/lib/screens/business_dashboard_screen/services/analytics_properties.dart
/Users/edsteine/Desktop/deadhour-app/lib/screens/business_dashboard_screen/services/analytics_events.dart
/Users/edsteine/Desktop/deadhour-app/lib/screens/role_switching_screen/enhanced_role_switcher_widget.dart
```

**Action**: Move to `/trash/` folder with timestamp (NEVER use rm command)

## 🚀 EXECUTION PLAN

### Phase 1: Critical SRP Violations (Week 1-2)
1. **main_navigation_screen.dart** - Split 4 classes into navigation components  
2. **venue_detail_screen.dart** - Split into 6 venue detail widgets
3. **analytics_dashboard_screen.dart** - Split into 8 analytics components
4. **venue_discovery_screen.dart** - Split into 6 discovery components
5. **payment_screen.dart** - Split into 8 payment components

### Phase 2: Service Layer Refactoring (Week 3-4)  
1. **deal_validation_service.dart** - Split 7 classes + 2 enums
2. **auth_service.dart** - Split 6 classes + 1 enum
3. **analytics_service.dart** - Split 3 classes
4. **morocco_cultural_service.dart** - Split 4 classes + 2 enums  
5. **accessibility_service.dart** - Split 4 classes

### Phase 3: Widget Library Cleanup (Week 5-6)
1. **map_view_widget.dart** - Split 5 classes + 1 enum
2. **performance_monitor_widget.dart** - Split 6 classes
3. **loading_widgets.dart** - Split 5 classes
4. **enhanced_app_bar.dart** - Split 5 classes
5. **professional_card.dart** - Split 4 classes

### Phase 4: Utilities & Constants (Week 7-8)
1. **error_utils.dart** - Split 5 classes + 1 enum
2. **mock_data.dart** - Split into data providers
3. **constants.dart** - Split 3 classes
4. **theme.dart** - Split 4 classes
5. **performance_utils.dart** - Split 3 classes + 1 enum

### Phase 5: Screen Folder Reorganization (Week 9-10)
1. Create 30+ individual screen folders
2. Move screen-specific files to dedicated folders
3. Update all import statements
4. Test navigation and functionality

### Phase 6: Bug Fixes & Cleanup (Week 11-12)
1. Fix navigation back button issues
2. Resolve import statement problems
3. Remove unused/problematic files
4. Run comprehensive testing
5. Performance optimization

## 📊 SUCCESS METRICS

- **File Count**: Reduce files >500 lines from 33 to 0
- **Max File Size**: No file should exceed 500 lines (target: 300 lines)
- **SRP Compliance**: Each file should contain only 1 class (except StatefulWidget screens)
- **Navigation**: All screens should have working back navigation
- **Import Errors**: Zero broken imports after reorganization
- **Test Coverage**: All refactored components should maintain functionality

## ⚠️ CRITICAL RULES

1. **NEVER use rm command** - Always move files to `/trash/` folder
2. **ONE FILE AT A TIME** - Complete each refactoring before moving to next
3. **Always create .bak files** - Never lose original code
4. **Run flutter analyze** - Fix all linting errors immediately  
5. **Test functionality** - Ensure features work after refactoring
6. **User approval required** - Wait for approval before next file

---

**Total Estimated Time**: 12 weeks
**Priority Order**: Critical → High → Medium → Reorganization → Cleanup
**Success Rate Target**: 90%+ reduction in file sizes while maintaining full functionality