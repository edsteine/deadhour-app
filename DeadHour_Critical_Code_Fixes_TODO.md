# DeadHour Critical Code Fixes - Implementation TODO

**Date**: July 25, 2025  
**Based on**: DeadHour_Lib_Code_Review_Report.md  
**Priority**: CRITICAL - Fix before market validation  
**Reference**: Always follow claude.md (or gemini.md) for development rules  

---

## 🚨 CRITICAL PRIORITY 1: ADDON → Role Terminology Refactoring

### Task 1.1: Model Layer Refactoring
**Files to modify:**
- `/lib/models/user.dart`

**Actions:**
- [ ] Rename `UserAddon` enum to `UserRole`
- [ ] Rename `activeAddons` property to `activeRoles`
- [ ] Update all enum values (if needed) to match Role terminology
- [ ] Update constructor and fromJson/toJson methods accordingly
- [ ] Run `dart fix --apply` and `dart analyze` after changes

### Task 1.2: Constants Layer Refactoring  
**Files to modify:**
- `/lib/utils/constants.dart`

**Actions:**
- [ ] Rename `availableAddons` to `availableRoles`
- [ ] Rename `futureAddons` to `futureRoles`
- [ ] Rename `addonPricing` to `rolePricing`
- [ ] Rename `addonPricingYearly` to `rolePricingYearly`
- [ ] Update all references throughout the file
- [ ] Run `dart fix --apply` and `dart analyze` after changes

### Task 1.3: Provider/State Management Refactoring
**Files to modify:**
- `/lib/utils/guest_mode.dart`
- `/lib/widgets/common/addon_toggle.dart`

**Actions:**
- [ ] Rename `AddonToggleProvider` class to `RoleToggleProvider`
- [ ] Rename `toggleAddons` method to `toggleRoles`
- [ ] Rename `showAddons` property to `showRoles`
- [ ] Update all method names and variable references
- [ ] Run `dart fix --apply` and `dart analyze` after changes

### Task 1.4: Screen Layer Refactoring
**Files to modify:**
- `/lib/screens/auth/user_type_selection_screen.dart`
- `/lib/screens/home/main_navigation_screen.dart`
- `/lib/screens/tourism/tourism_screen.dart`
- `/lib/screens/tourism/local_expert_screen.dart`
- `/lib/screens/profile/profile_screen.dart`

**Actions for each file:**
- [ ] Update class names from `AddonMarketplaceScreen` to `RoleMarketplaceScreen`
- [ ] Replace all "ADDON" text in UI with "Role"
- [ ] Update all references to `AppConstants.addonPricing` → `AppConstants.rolePricing`
- [ ] Update provider references from `AddonToggleProvider` → `RoleToggleProvider`
- [ ] Update navigation routes if needed (AppRoutes.addonMarketplace → AppRoutes.roleMarketplace)
- [ ] Run `dart fix --apply` and `dart analyze` after each file

### Task 1.5: Mock Data Refactoring
**Files to modify:**
- `/lib/utils/mock_data.dart`

**Actions:**
- [ ] Update `DeadHourUser` model usage to use `activeRoles` instead of `activeAddons`
- [ ] Update all `UserAddon.business` references to `UserRole.business`
- [ ] Update mock data descriptions and comments to use "Role" terminology
- [ ] Run `dart fix --apply` and `dart analyze` after changes

---

## 🎯 PRIORITY 2: Missing UI Implementation

### Task 2.1: Add RoleSwitcher to Home Screen
**Files to modify:**
- `/lib/screens/home/home_screen.dart`

**Actions:**
- [ ] Import the RoleSwitcher widget (check if it exists in widgets folder)
- [ ] If RoleSwitcher doesn't exist, create it following the MVP development guide specifications
- [ ] Add RoleSwitcher widget to home screen layout as specified in documentation
- [ ] Ensure it displays all active user roles
- [ ] Test role switching functionality
- [ ] Run `dart fix --apply` and `dart analyze` after changes

### Task 2.2: Display Cultural Features in UI
**Files to modify:**
- `/lib/screens/community/rooms_screen.dart`
- `/lib/screens/community/room_detail_screen.dart`
- `/lib/widgets/common/room_card.dart`

**Actions:**
- [ ] Display `isPrayerTimeAware` status with prayer icon in room cards
- [ ] Display `isHalalOnly` status with halal badge in room cards
- [ ] Add filtering options for prayer-time aware and halal-only rooms
- [ ] Update room detail screen to show these cultural features prominently
- [ ] Run `dart fix --apply` and `dart analyze` after changes

### Task 2.3: Enhance Deal Creation with Cultural Options
**Files to modify:**
- `/lib/screens/business/create_deal_screen.dart`

**Actions:**
- [ ] Add checkbox/toggle for "Halal Certified"
- [ ] Add checkbox/toggle for "Prayer Time Aware"
- [ ] Add cultural considerations section to deal creation form
- [ ] Update deal model if needed to support these fields
- [ ] Run `dart fix --apply` and `dart analyze` after changes

---

## 🔧 PRIORITY 3: Code Quality & Architecture

### Task 3.1: Fix Duplicate Code Issues
**Files to check:**
- `/lib/main.dart`
- `/lib/app.dart`

**Actions:**
- [ ] Remove duplicate `DeadHourApp` class from `/lib/main.dart`
- [ ] Ensure only the `DeadHourApp` in `/lib/app.dart` is used
- [ ] Update main.dart imports and runApp call accordingly
- [ ] Run `dart fix --apply` and `dart analyze` after changes

### Task 3.2: Remove Unused Files
**Files to evaluate and potentially remove:**
- `/lib/widgets/common/animated_bottom_nav.dart`
- `/lib/widgets/common/loading_states.dart`  
- `/lib/widgets/common/loading_widget.dart`
- `/lib/widgets/common/error_boundary.dart`
- `/lib/utils/animations.dart`

**Actions:**
- [ ] Check if each file is imported/used anywhere in the codebase
- [ ] If unused, remove the file
- [ ] If partially used, consolidate or refactor as needed
- [ ] Run `dart fix --apply` and `dart analyze` after cleanup

### Task 3.3: Modularize Large Files
**Files to break down (1000+ lines):**
- `/lib/screens/business/business_dashboard_screen.dart` (1217 lines)
- `/lib/screens/social/social_discovery_screen.dart` (1172 lines)
- `/lib/screens/business/revenue_optimization_screen.dart` (1128 lines)
- `/lib/screens/tourism/tourism_screen.dart` (1116 lines)
- `/lib/screens/community/rooms_screen.dart` (1068 lines)
- `/lib/screens/community/room_chat_screen.dart` (1034 lines)

**Actions for each large file:**
- [ ] Create `widgets/` subdirectory for the screen
- [ ] Extract large widgets into separate files
- [ ] Break down into logical components (headers, cards, sections)
- [ ] Maintain functionality while improving readability
- [ ] Run `dart fix --apply` and `dart analyze` after each modularization

---

## 🚀 PRIORITY 4: State Management Migration

### Task 4.1: Transition to Riverpod
**Current usage:** Provider pattern  
**Target:** flutter_riverpod

**Actions:**
- [ ] Add ProviderScope to main app widget
- [ ] Convert ChangeNotifierProvider to StateNotifierProvider/Provider
- [ ] Convert Consumer widgets to ConsumerWidget/ConsumerStatefulWidget
- [ ] Update all Provider.of and context.read calls to ref.read/ref.watch
- [ ] Remove provider dependency from pubspec.yaml once migration complete
- [ ] Run `dart fix --apply` and `dart analyze` after migration

### Task 4.2: Integrate Easy Localization
**Files to set up:**
- `/assets/translations/` directory structure

**Actions:**
- [ ] Set up translation files (ar.json, fr.json, en.json)
- [ ] Initialize EasyLocalization in main.dart
- [ ] Replace hardcoded strings with tr() calls
- [ ] Test language switching functionality
- [ ] Ensure proper RTL support for Arabic
- [ ] Run `dart fix --apply` and `dart analyze` after integration

---

## 📋 DEVELOPMENT RULES & COMPLIANCE

### Always Follow These Rules (from claude.md):

**Linting Requirements:**
- [ ] Run `dart analyze` after EVERY change
- [ ] Run `dart fix --apply` to auto-fix issues
- [ ] Fix ALL linting errors and warnings before proceeding
- [ ] Never leave linting issues unresolved

**Deprecated API Compliance:**
- [ ] Replace ALL `.withOpacity()` calls with `.withValues(alpha:)`
- [ ] Check for any other deprecated Flutter APIs
- [ ] Use modern Flutter patterns throughout

**Code Style:**
- [ ] Use `camelCase` for variables/functions
- [ ] Use `PascalCase` for classes
- [ ] Use `snake_case` for file names
- [ ] Prefer `StatelessWidget` over `StatefulWidget` when possible
- [ ] Add minimal comments, focus on self-documenting code

**Dual-Problem Focus:**
- [ ] Every feature must support both business optimization AND social discovery
- [ ] All features must support multi-role account system
- [ ] Community integration must feel social through category-based rooms
- [ ] Cross-role features should enhance each other

**Cultural Integration:**
- [ ] All features must respect Morocco cultural requirements
- [ ] Support prayer times, Ramadan mode, halal verification
- [ ] Support Arabic RTL, French, English languages
- [ ] Use Moroccan Dirham (MAD) as primary currency

---

## ✅ COMPLETION CHECKLIST

### Phase 1: Critical Fixes
- [ ] All ADDON → Role terminology fixed
- [ ] RoleSwitcher added to home screen
- [ ] Cultural features displayed in UI
- [ ] All linting errors resolved
- [ ] All deprecated APIs updated

### Phase 2: Quality Improvements  
- [ ] Duplicate code removed
- [ ] Unused files cleaned up
- [ ] Large files modularized
- [ ] Code follows style guidelines

### Phase 3: Architecture Upgrade
- [ ] Riverpod state management integrated
- [ ] Easy localization implemented
- [ ] Multi-language support working
- [ ] All tests passing (if any exist)

### Final Validation
- [ ] App runs without errors
- [ ] All screens navigate correctly
- [ ] Role switching works smoothly
- [ ] Cultural features display properly
- [ ] Ready for market validation demos

---

**Note**: After each major task completion, run full app testing to ensure no regressions. The goal is a polished mockup that accurately demonstrates the dual-problem platform concept with proper multi-role functionality and cultural integration.

**Success Criteria**: App should be investor-demo ready with consistent terminology, working role system, and visible cultural integration features.