# DeadHour Screen Folder Reorganization Plan

## Current Situation
- User renamed `lib/screens/` to `lib/screens_backup/`
- Need to analyze ALL files in `screens_backup/` and organize them properly
- Target: ONE FOLDER PER SCREEN (30-40 individual screen folders)

## Target Structure: ONE FOLDER PER SCREEN

**Principle**: Each screen gets its own dedicated folder with all related files

```
lib/screens/
├── splash_screen/
│   └── splash_screen.dart
├── onboarding_screen/
│   ├── onboarding_screen.dart
│   └── onboarding_page.dart
├── login_screen/
│   └── login_screen.dart
├── register_screen/
│   └── register_screen.dart
├── home_screen/
│   └── home_screen.dart
├── deals_screen/
│   ├── deals_screen.dart
│   └── [related widgets/services for deals]
├── venues_screen/
│   ├── venues_screen.dart
│   └── [related widgets/services for venues]
├── venue_detail_screen/
│   ├── venue_detail_screen.dart
│   └── [related widgets/services for venue details]
├── tourism_screen/
│   ├── tourism_screen.dart
│   └── [related widgets/services for tourism]
├── local_expert_screen/
│   ├── local_expert_screen.dart
│   └── [related widgets/services for local expert]
├── rooms_screen/
│   ├── rooms_screen.dart
│   └── [related widgets/services for rooms]
├── room_chat_screen/
│   ├── room_chat_screen.dart
│   └── [related widgets/services for room chat]
├── room_detail_screen/
│   ├── room_detail_screen.dart
│   └── [related widgets/services for room detail]
├── booking_flow_screen/
│   ├── booking_flow_screen.dart
│   └── [all booking related widgets]
├── payment_screen/
│   ├── payment_screen.dart
│   ├── payment_state.dart
│   └── [all payment related widgets/services]
├── business_dashboard_screen/
│   ├── business_dashboard_screen.dart
│   └── [business dashboard widgets/services]
├── create_deal_screen/
│   ├── create_deal_screen.dart
│   └── [create deal widgets/services]
├── analytics_dashboard_screen/
│   ├── analytics_dashboard_screen.dart
│   └── [analytics widgets/services]
├── revenue_optimization_screen/
│   ├── revenue_optimization_screen.dart
│   └── [revenue optimization widgets/services]
├── profile_screen/
│   ├── profile_screen.dart
│   └── [profile related widgets]
├── role_switching_screen/
│   ├── role_switching_screen.dart
│   └── [role switching widgets/services]
├── role_marketplace_screen/
│   ├── role_marketplace_screen.dart
│   └── [role marketplace widgets/services]
├── premium_role_screen/
│   ├── premium_role_screen.dart
│   └── [premium role widgets/services]
├── community_health_dashboard_screen/
│   ├── community_health_dashboard_screen.dart
│   └── [community health widgets/services]
├── network_effects_dashboard_screen/
│   ├── network_effects_dashboard_screen.dart
│   └── [network effects widgets/services]
├── settings_screen/
│   ├── settings_screen.dart
│   └── [settings widgets]
├── accessibility_settings_screen/
│   ├── accessibility_settings_screen.dart
│   └── [accessibility widgets/services]
├── offline_settings_screen/
│   ├── offline_settings_screen.dart
│   └── [offline settings widgets/services]
├── social_discovery_screen/
│   ├── social_discovery_screen.dart
│   └── [social discovery widgets/services]
├── group_booking_screen/
│   ├── group_booking_screen.dart
│   └── [group booking widgets/services]
├── notifications_screen/
│   ├── notifications_screen.dart
│   └── [notification widgets/services]
├── cultural_ambassador_application_screen/
│   ├── cultural_ambassador_application_screen.dart
│   └── [cultural application widgets/services]
├── dev_menu_screen/
│   ├── dev_menu_screen.dart
│   └── [dev menu related files]
├── main_navigation_screen/
│   ├── main_navigation_screen.dart
│   └── [navigation related files]
├── guide_role_screen/
│   ├── guide_role_screen.dart
│   └── [guide role widgets/services]
├── web_companion_screen/
│   ├── web_companion_screen.dart
│   └── [web companion widgets/services]
└── shared/                  # ✅ DONE - Only truly shared widgets/components
    ├── widgets/
    │   ├── compact_offline_indicator.dart
    │   ├── data_freshness_indicator.dart
    │   ├── google_map_widget.dart
    │   ├── offline_status_widget.dart
    │   ├── optimized_image.dart
    │   ├── optimized_list_view.dart
    │   ├── performance_monitor_widget.dart
    │   ├── prayer_time_indicator.dart
    │   ├── ramadan_banner_widget.dart
    │   └── sync_floating_action_button.dart
    └── components/
```

## Implementation Strategy

### Phase 1: Analysis & Discovery ⏳ IN PROGRESS
**Goal**: Loop through ALL files in `screens_backup/` and categorize them

**Process**:
1. **Find all .dart files** in `screens_backup/` recursively
2. **Analyze each file** by:
   - Reading file name (e.g., `login_screen.dart` → belongs to `login_screen/`)
   - Reading file content/imports to determine screen association
   - Checking if it's a widget, service, or model related to specific screen
3. **Categorize files**:
   - **Screen files**: Main screen dart files (e.g., `*_screen.dart`)
   - **Screen-specific widgets**: Widgets only used by one screen
   - **Screen-specific services**: Services only used by one screen  
   - **Shared components**: Used by multiple screens → goes to `shared/`
4. **Create mapping list** of file → target folder

### Phase 2: Create Screen Folders 📁 PENDING
**Goal**: Create individual folder for each discovered screen

**Process**:
1. **Identify all unique screens** from Phase 1 analysis
2. **Create folder for each screen** (e.g., `lib/screens/login_screen/`)
3. **Verify folder structure** matches discovered screens

### Phase 3: Smart File Migration 🚀 PENDING  
**Goal**: Move each file to its correct destination

**Migration Logic**:
```
For each file in screens_backup/:
  ├── IF file is screen-specific
  │   ├── Check if target screen folder exists
  │   ├── Move file to screen folder
  │   └── Log successful move
  ├── IF file is shared component
  │   ├── Move to shared/widgets/ or shared/components/
  │   └── Log successful move  
  └── IF uncertain
      ├── Analyze file content deeper
      └── Ask for manual decision
```

**Examples**:
- `login_screen.dart` → `lib/screens/login_screen/login_screen.dart`
- `booking_flow_screen.dart` → `lib/screens/booking_flow_screen/booking_flow_screen.dart`
- `deal_card.dart` (only used in deals) → `lib/screens/deals_screen/deal_card.dart`
- `prayer_time_widget.dart` (used everywhere) → `lib/screens/shared/widgets/prayer_time_widget.dart`

### Phase 4: Import Statement Updates 🔗 PENDING
**Goal**: Fix all broken imports after file moves

**Process**:
1. **Scan all moved files** for import statements
2. **Update relative imports** to match new folder structure
3. **Update absolute imports** if needed
4. **Run flutter analyze** to catch missed imports
5. **Fix any remaining import errors**

### Phase 5: Cleanup & Verification ✅ PENDING
**Goal**: Ensure everything works and clean up

**Process**:
1. **Remove empty folders** from old structure
2. **Run flutter analyze** to check for errors
3. **Test app compilation** 
4. **Verify all screens accessible**
5. **Update route definitions** if needed
6. **Remove `screens_backup/`** once verified working

## File Analysis Criteria

### Screen Identification Patterns:
- **File name ending with** `_screen.dart`
- **Class name ending with** `Screen`
- **Contains** `StatelessWidget` or `StatefulWidget` as main screen
- **Has** `Scaffold` as main widget

### Screen-Specific File Patterns:
- **Widgets**: Files in `widgets/` subfolder of specific screen area
- **Services**: Files in `services/` subfolder of specific screen area  
- **Models**: Files in `models/` subfolder of specific screen area
- **Utils**: Files in `utils/` subfolder of specific screen area

### Shared File Patterns:
- **Used by multiple screens**: Import analysis shows multiple screen dependencies
- **Generic names**: `app_*`, `common_*`, `global_*`, `shared_*`
- **Utility functions**: General purpose utilities
- **Theme/styling**: App-wide styling components

## Benefits of This Approach

1. **Automated Analysis** - Smart file categorization based on content
2. **Safe Migration** - Each file analyzed before moving
3. **Clear Organization** - Each screen has dedicated folder
4. **Easy Maintenance** - Find any screen's files instantly
5. **Scalable Structure** - Easy to add new screens
6. **Import Clarity** - Clear import paths for each component

## Current Status
- ✅ shared/ folder created and populated with existing widgets
- 🔄 Ready to analyze all files in screens_backup/
- 📋 Will create 30-40 individual screen folders based on analysis
- 🎯 Goal: Complete reorganization with working imports