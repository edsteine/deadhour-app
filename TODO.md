# TODO: Guest-First User Experience Implementation

## Project Overview
Implement guest-first user experience where all users start as consumers without forced authentication. Authentication only required when performing actions that require specific permissions.

## Current Problem
- App forces role selection during onboarding (`/user-type` after onboarding)
- Users must authenticate before using any app features
- Contradicts guest-first browsing experience concept

## Solution: Context-Driven Authentication
All users are consumers by default. Authentication only triggered when specific actions require it.

---

## 1. User Flow Changes

### Current Flow (Incorrect)
```
App Start ’ Splash ’ Onboarding ’ Role Selection ’ Register/Login ’ Home
```

### New Flow (Correct)
```
App Start ’ Splash ’ Onboarding ’ Home (Guest Mode)
    “ (only when user tries action requiring authentication)
Login/Register ’ Role Management ’ Action Completion
```

### Context-Driven Authentication Triggers
User authentication required when trying to:
- **Book a deal** ’ Login ’ Consumer role (default)
- **Join community room** ’ Login ’ Consumer role (default)  
- **Post in community** ’ Login ’ Consumer role (default)
- **Create business deal** ’ Login ’ Business role required
- **Offer guide services** ’ Login ’ Guide role required
- **Access premium features** ’ Login ’ Premium role required

---

## 2. Code Changes Required

### A. Remove Forced Role Selection from Onboarding

**Files to modify:**
- `lib/routes/app_routes.dart` - Remove `/user-type` from onboarding flow
- `lib/screens/auth/onboarding_screen.dart` - Direct to home instead of user-type
- `lib/widgets/common/dev_menu_drawer.dart` - Update navigation logic

**Changes:**
- **Remove**: Onboarding ’ `/user-type` navigation
- **Add**: Onboarding ’ `/home` (guest mode) navigation
- **Update**: Guest mode handling in home screen

### B. Implement Context-Driven Authentication

**Files to create/modify:**
- `lib/services/auth_service.dart` - Add context-driven auth methods
- `lib/services/guest_mode.dart` - Enhanced guest mode functionality
- `lib/middleware/auth_middleware.dart` - NEW: Check auth requirements per action

**Methods to implement:**
```dart
// AuthService methods
Future<bool> requiresAuthentication(String action);
Future<UserRole> getRequiredRole(String action);
Future<void> authenticateForAction(String action, BuildContext context);

// GuestMode methods  
static bool canPerformAction(String action);
static void promptAuthForAction(String action, BuildContext context);
```

### C. Update Role Management System

**Files to modify:**
- `lib/screens/profile/role_switching_screen.dart` - Handle new user role addition
- `lib/screens/auth/role_marketplace_screen.dart` - Context-aware role selection
- `lib/models/user.dart` - Default consumer role logic

**Changes:**
- **Default Role**: All new users get Consumer role automatically
- **Role Addition**: Business/Guide/Premium roles added through profile management
- **Context Awareness**: Role selection shows only relevant roles for current action

### D. Update Home Screen for Guest Mode

**Files to modify:**
- `lib/screens/home/home_screen.dart` - Enhanced guest experience
- `lib/screens/home/main_navigation_screen.dart` - Guest mode navigation
- `lib/widgets/common/dead_hour_app_bar.dart` - Guest vs authenticated UI

**Changes:**
- **Guest Browsing**: Full access to deals, venues, community rooms (read-only)
- **Action Buttons**: "Login to book" instead of direct booking
- **Navigation**: Profile tab shows "Sign In" for guests

---

## 3. UI/UX Changes

### A. Authentication Prompts
**Create contextual login prompts:**
- "Sign in to book this deal" (with deal context)
- "Join the community - Sign up to post" (with community context)
- "Start selling - Add Business role" (with business context)

### B. Guest Experience Indicators
**Add guest mode indicators:**
- "Browsing as Guest" in app bar
- "Sign up for free" call-to-action buttons
- Preview of authenticated features with upgrade prompts

### C. Role Addition Flow
**Streamline role addition:**
- Profile ’ "Add Business Role" ’ Role benefits ’ Subscription ’ Activation
- Context-aware: Show Business role when user tries to create deal
- Upgrade prompts: "Unlock Guide features" when viewing tourism content

---

## 4. Authentication Flow Updates

### A. Simplified Registration
**New user registration:**
1. User triggers auth-required action
2. "Sign up to continue" prompt
3. Basic registration form (email, password, name)
4. Auto-assign Consumer role
5. Complete original action
6. Role addition available in profile later

### B. Role Context Selection
**Context-aware role selection:**
- **Booking action** ’ Consumer role (already have it)
- **Create deal action** ’ "Add Business role?" prompt
- **Guide services** ’ "Become a Guide?" prompt
- **Premium features** ’ "Upgrade to Premium?" prompt

### C. Guest to User Conversion
**Conversion triggers:**
- First booking attempt
- First community post attempt
- Favorite deals/venues (with save prompt)
- Location-based recommendations (with personalization prompt)

---

## 5. Documentation Updates

### A. User Journey Documentation
**Update files:**
- `docs/14_mvp_screen_specifications.md` - Remove forced role selection
- `docs/16_user_onboarding_and_ux_flow.md` - Add guest-first experience
- `APP_SCREENS_COMPLETE.md` - Update role selection screen description

**Changes:**
- Document guest mode capabilities
- Explain context-driven authentication
- Update user flow diagrams

### B. Technical Documentation
**Update files:**
- `README.md` - Update setup instructions for guest mode
- `lib/utils/constants.dart` - Add auth requirement constants
- API documentation - Guest mode endpoints

---

## 6. Implementation Priority

### Phase 1: Core Guest Experience (High Priority)
- [ ] Remove forced role selection from onboarding
- [ ] Implement guest mode home screen
- [ ] Add context-driven auth prompts
- [ ] Update navigation for guest users

### Phase 2: Enhanced Authentication (Medium Priority)  
- [ ] Context-aware role selection
- [ ] Simplified registration flow
- [ ] Role addition through profile
- [ ] Guest conversion tracking

### Phase 3: Optimization (Low Priority)
- [ ] Personalized guest recommendations
- [ ] Advanced guest mode features
- [ ] A/B testing for conversion flows
- [ ] Analytics for guest behavior

---

## 7. Testing Requirements

### A. User Flow Testing
- [ ] Guest browsing experience (no login required)
- [ ] Context-driven authentication triggers
- [ ] Role addition through profile management
- [ ] Guest to authenticated user conversion

### B. Edge Cases
- [ ] Guest tries premium action ’ upgrade prompt
- [ ] User has multiple roles ’ role switching works
- [ ] Network issues during auth ’ graceful fallback
- [ ] Guest mode data persistence ’ smooth transition

### C. Business Logic
- [ ] Default Consumer role assignment
- [ ] Role requirements per action
- [ ] Permission checking accuracy
- [ ] Guest mode limitations properly enforced

---

## 8. Success Metrics

### A. User Experience Metrics
- **Guest Engagement**: Time spent browsing before auth
- **Conversion Rate**: Guest ’ Registered user percentage
- **Drop-off Points**: Where users abandon registration
- **Role Adoption**: How many users add additional roles

### B. Technical Metrics  
- **Auth Triggers**: Which actions most commonly trigger login
- **Role Distribution**: Consumer vs Business vs Guide usage
- **Guest Limitations**: Which features guests try to access
- **Performance**: Guest mode vs authenticated mode speed

---

## 9. Implementation Notes

### A. Backward Compatibility
- Existing users keep current roles and preferences
- Migration script for role data structure changes
- Graceful handling of legacy authentication flow

### B. Security Considerations
- Guest mode data isolation
- Secure transition from guest to authenticated
- Role permission validation on backend
- Prevention of guest mode exploitation

### C. Data Persistence
- Guest browsing history (local storage)
- Seamless data transfer on registration
- Guest preferences preservation
- Analytics tracking for both modes

---

## Completion Checklist

- [ ] Remove `/user-type` from onboarding flow
- [ ] Implement guest mode home screen
- [ ] Add context-driven authentication system
- [ ] Update role management for existing users
- [ ] Create contextual authentication prompts
- [ ] Update all documentation
- [ ] Test complete user journey flows
- [ ] Deploy and monitor conversion metrics

**Target Completion**: 1-2 weeks
**Priority Level**: High (affects core user experience)
**Impact**: Significantly improves user onboarding and reduces friction