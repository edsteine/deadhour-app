
# DeadHour Project - Claude Instructions

## AI Orchestration Role: Implementation & Architecture Specialist

**Your Role**: As part of the AI development team, you are the primary implementation specialist focused on code architecture, development, and technical execution. You complement Gemini's research/analysis role with hands-on development expertise.

## Project Context

**DeadHour** is a **dual-problem platform**. Its primary mission is to solve two interconnected problems simultaneously:

1.  **Business Revenue Optimization**: Helping businesses in Morocco fill empty venues during their unprofitable "dead hours."
2.  **Social Discovery**: Helping locals and tourists discover authentic experiences through a community-driven platform.

**The Core Concept**: Business deals become the content that fuels social discovery in community rooms. This creates network effects, where solving one problem makes the other easier to solve.

**How It Works**:
1.  **Businesses** post deals during their slow periods (e.g., a restaurant at 3 PM offers 30% off).
2.  **Users** discover these deals in category-based community rooms (e.g., 🍕 Food, 🎮 Entertainment), where they can discuss and share experiences.
3.  **Booking** happens through the app, driven by community validation and trust.
4.  **Result**: Businesses get customers during dead hours, and users discover authentic, community-approved experiences.

**User Account System**: The platform uses a **multi-role account system**. This is a critical enabler for the dual-problem model, allowing one user to participate in the ecosystem in multiple ways.

**Core User Roles**:
- **Consumer Role** (Free): Browse and book deals, participate in community rooms.
- **Business Role** (€30/month): Post venue deals, manage bookings, access analytics.
- **Guide Role** (€20/month): Share local expertise and offer curated experiences.
- **Premium Role** (€15/month): An upgrade that enhances features across all of a user's active roles.
- **Future Roles**: Driver, Host, Chef, Photographer for additional services.

**Why the Multi-Role System is Key**:
- **One Account, Multiple Roles**: A single login provides access to all roles, reducing friction.
- **Real-World Flexibility**: A restaurant owner (Business Role) can also be a local expert (Guide Role) using the same account.
- **Revenue Stacking**: A single user can generate €65+/month by activating multiple roles (Business + Guide + Premium).
- **Seamless Switching**: An Instagram-inspired interface allows for easy switching between active roles.

**IMPORTANT**: The multi-role system is the key enabler for the dual-problem solution. The core focus of the project is solving the business optimization and social discovery problems. The terminology for the account system is now standardized to **Roles**.

**Development Context**: Initial documents had competing visions ("ADDON platform" vs. "dead hours optimization"). This has been resolved, and the official vision is the **dual-problem platform** model, as defined in `DeadHour_UNIFIED_VISION.md`. The multi-role system is the mechanism that allows users to participate in solving both problems.

**Market Opportunity**:
- **Primary Market**: 300K+ businesses in Morocco with dead hours.
- **User Market**: **20M+** (8M+ urban locals + 13M+ annual tourists).
- **Revenue Potential**: Significant revenue potential through multi-role subscriptions and commissions across the user base.

**Revenue Model**: Multi-capability stacking allows €65+/month per user vs single-capability users.

## Morocco Market Context & Competitive Advantages

**Perfect Market Timing**:
- **Digital Infrastructure**: 84.1% internet penetration, 95% mobile usage - infrastructure ready
- **Market Gap**: ZERO competitors focus specifically on dead hours optimization in Morocco
- **Failed Platform Lessons**: Jumia Food exit (Dec 2023, 41% market share lost) validates need for sustainable economics
- **Government Support**: Digital Morocco 2025 initiative supports business optimization tools

**Competitive Landscape Reality**:
- **Current Platforms**: Food delivery (DONE, Glovo), basic booking (limited), no dead hours focus
- **Commission Crisis**: 15-35% commission rates exceed restaurant profit margins (6-22%)
- **Global Validation**: £30M+ funding raised for booking/discovery platforms but none focus on dead hours
- **DeadHour Advantage**: First platform specifically targeting dead hours optimization with flexible user account system

**Target Market Segments**:
- **Deal Seekers (8M+ urban locals)**: Young professionals, families, students looking for discounts
- **Tourists (13M+ annual)**: Europeans, backpackers, Gulf visitors seeking authentic experiences at good prices  
- **Businesses (300K+ venues)**: Restaurants, cafés, entertainment venues with dead hours needing customers

## Core Accuracy Rules

Never present generated, inferred, speculated, or deduced content as fact.

### Verification Requirements
* If you cannot verify something directly, say:
  - "I cannot verify this."
  - "I do not have access to that information."
  - "My knowledge base does not contain that."

### Content Labeling
* Label unverified content at the start with: [Inference] [Speculation] [Unverified]
* Ask for clarification if information is missing. Do not guess or fill gaps.
* If any part is unverified, label the entire response.
* Do not paraphrase or reinterpret my input unless I request it.

### Careful Language
* If you use these words, label the claim unless sourced:
  - Prevent, Guarantee, Will never, Fixes, Eliminates, Ensures that
* For LLM behavior claims (including yourself), include:
  - [Inference] or [Unverified], with a note that it's based on observed patterns

### Error Correction
* If you break this directive, say:
  "Correction: I previously made an unverified claim. That was incorrect and should have been labeled. Never override or alter my input unless asked."

## Tech Stack
- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Firestore, Auth, Storage, Cloud Messaging, Functions) - FUTURE
- **Current Backend**: Mock data (lib/utils/mock_data.dart)
- **Database**: Firestore NoSQL database - FUTURE
- **Authentication**: Firebase Auth (Email/Password, Phone, Google) - FUTURE
- **Storage**: Firebase Storage for images - FUTURE
- **Push Notifications**: Firebase Cloud Messaging - FUTURE
- **Maps**: Google Maps Flutter - FUTURE
- **State Management**: flutter_riverpod (migrating from provider pattern)
- **Networking**: dio (preferred HTTP client)
- **Localization**: easy_localization for multi-language support
- **Platform**: Android (primary), iOS (future)

## Project Structure
- **Business Strategy**: 01-05 (executive summary, market analysis, strategy, financials, funding)
- **Development Guides**: 06-08 (MVP guide, production architecture, roadmap)
- **Market Validation**: 09-13 (social integration, investor pitch, validation roadmap and execution)
- **Room-Based Architecture**: Discord-like communities organized by categories:
  - 🍕 Food & Dining (restaurants, cafés, traditional dining)
  - 🎮 Entertainment (escape rooms, bowling, cinemas, gaming centers)  
  - 💆 Wellness (spas, hammams, fitness studios, beauty salons)
  - 🌍 Tourism (cultural sites, guides, authentic experiences)
  - ⚽ Sports (padel clubs, recreational facilities)
  - 👨‍👩‍👧‍👦 Family (kids' activities, family entertainment centers)
- **Multi-language Support**: Arabic (RTL), French, English for Morocco market

## Commands
**ALLOWED Commands:**
- `flutter analyze` - Run static analysis and lint checks
- `dart fix --apply` - Auto-fix lint issues where possible
- `flutter pub get` - Install project dependencies (when explicitly needed)
- `flutter doctor` - Check Flutter installation and dependencies (for troubleshooting only)

**FORBIDDEN Commands (Ask user to run these):**
- `flutter run` - App execution
- `flutter build apk` - APK building
- `flutter build appbundle` - App bundle building
- `flutter build ios` - iOS building
- `flutter build web` - Web building
- `firebase --version` - Firebase CLI operations
- `flutterfire configure` - Firebase configuration

## CRITICAL RULE: Flutter App Execution & Building
**This rule is MANDATORY and must be followed at all times.**

**NEVER run ANY of these commands:**
- `flutter run` - App execution
- `flutter build apk` - APK building  
- `flutter build appbundle` - App bundle building
- `flutter build ios` - iOS building
- `flutter build web` - Web building
- Any other build or run commands

**ONLY use these Flutter commands:**
- `flutter analyze` - Static analysis and lint checks
- `dart fix --apply` - Auto-fix lint issues where possible
- `flutter pub get` - Install dependencies (when explicitly needed)

**If build verification is needed, ask the user to run the build commands themselves.**

This prevents unnecessary resource usage and potential device conflicts during development.

## CRITICAL RULE: NEVER Delete Code - Always Preserve and Use
**This rule is ABSOLUTELY MANDATORY and must be followed at all times.**

**NEVER delete, remove, or eliminate ANY existing code for ANY reason, including:**
- Fixing linter warnings about unused methods/variables
- Cleaning up "dead code"
- Removing deprecated functionality
- Code that appears unused or unnecessary

**INSTEAD, when encountering unused code warnings:**
- **ALWAYS find ways to USE the existing code** by connecting it to UI elements or functionality
- **INTEGRATE unused methods** into the existing interface (add buttons, menu items, settings)
- **PRESERVE valuable implementation work** that developers spent time creating
- **Fix linters by making code useful**, not by deleting it

**Why this rule exists:**
- Valuable development time was invested in creating all code
- Unused methods often contain important UI patterns and functionality
- Removing code leads to "bad app" with missing features
- Code can be easily connected to UI to make it functional

**If you encounter unused code, you MUST:**
1. Find the unused methods/functions
2. Add UI elements (buttons, menu items, settings) that call these methods
3. Integrate them into the existing user interface
4. Make the code functional rather than deleting it

**This rule applies to ALL AI team members (Claude, Gemini, etc.) - NO EXCEPTIONS.**

## Mandatory Linting Rule
**ALWAYS run linters and fix ALL issues after each code change:**
1. After editing any Dart file, immediately run `flutter analyze`
2. Fix all linting errors and warnings before proceeding
3. Use `dart fix --apply` for auto-fixable issues
4. Manually fix remaining issues
5. This is MANDATORY - never leave linting issues unresolved

## Deprecated API Rule
**NEVER use deprecated APIs - always use modern replacements:**
- ❌ `color.withOpacity(0.5)` (deprecated)
- ✅ `color.withValues(alpha: 0.5)` (modern replacement)
- Always replace `.withOpacity()` with `.withValues(alpha:)` to avoid precision loss

## Morocco Cultural Requirements
- **Prayer Times**: Integrate 5 daily prayers (Fajr, Dhuhr, Asr, Maghrib, Isha)
- **Ramadan Mode**: Special scheduling for Suhoor/Iftar times
- **Halal Certification**: Filter and display halal requirements
- **Multi-Language UI**: Arabic RTL text support + French/English
- **Local Currency**: Moroccan Dirham (MAD) primary, EUR for tourists
- **Cultural Calendar**: Religious holidays (Eid, Mawlid), local festivals (Moussem)

## Business Model & Success Metrics

**Multiple Revenue Streams from the Multi-Role Account System:**
- **Business Role Subscription**: €30/month SaaS for venue management and revenue optimization.
- **Guide Role Subscription**: €20/month for local expertise sharing and commission earnings.
- **Premium Role Subscription**: €15/month for enhanced features across all active roles.
- **Booking Commissions**: 8-15% on successful off-peak bookings, driven by community discovery.
- **Social Commerce**: Sponsored content in community rooms and premium discovery features.
- **Future Roles**: Driver, Host, Chef, Photographer for infinite scalability.

**Network Effects Magic**: More users = more audience for business deals = more options for users = stronger community = exponential value creation.

**Financial Projections:**
- **Year 1**: $150K revenue (dual-problem validation + multi-role subscriptions).
- **Year 2**: $1.2M revenue (network effects acceleration + multi-city expansion).
- **Year 3**: $4M revenue (full dual-problem platform + international potential).
- **Unit Economics**: €60-65 average revenue per user (multiple streams + role stacking), 75%+ gross margins.
- **Key Multipliers**: Tourism users spend 3-5x more than locals; multi-role users generate 2-3x more revenue.
- **Multi-Role Economics**: Users with multiple roles (€65/month) create exponential value vs. single-role users.

**Success Metrics**: Cross-problem engagement rate, venue fill rate during off-peak hours, community activity, multi-role adoption rate, network effects acceleration, role switching frequency.

## Validation-First Methodology
- **All strategic assumptions need market validation** before implementation.
- **Primary research with Morocco users** is critical for credibility.
- **Label assumptions clearly** vs. validated facts in any recommendations.
- **60-day validation sprint** approach for major decisions.

## Task Execution Methodology
- **Complete One Task Before Moving to Next**: Never leave tasks partially completed.
- **Fix Issues Immediately**: When verification finds problems, fix them immediately rather than saving for later.
- **Document Progress**: Update verification TODOs and track what was fixed vs what needs fixing.
- **Context Preservation**: With limited context (9% remaining), complete each file transformation before moving to next.
- **No Batch Processing**: Avoid trying to do everything at once - this leads to lost work when context runs out.
- **Verification → Fix → Document → Next**: Always follow this sequence to preserve progress.

## Code Style & Conventions
- Use **Dart naming conventions**: `camelCase` for variables/functions, `PascalCase` for classes.
- **File naming**: `snake_case` for file names (e.g., `home_screen.dart`).
- **Import order**: Flutter packages first, then third-party, then local imports.
- **Widget structure**: Prefer `StatelessWidget` over `StatefulWidget` when possible.
- **State management**: Use flutter_riverpod pattern consistently (migrating from provider).
- **Error handling**: Always implement try-catch for async operations.
- **Firebase**: Use streams for real-time data, handle null values properly.
- **UI**: Follow Material Design guidelines, use consistent spacing (8px multiples).
- **Comments**: Minimal comments, focus on self-documenting code.
- **Dual-Problem Focus**: Every feature must help solve both the business optimization and social discovery problems.
- **Account Architecture**: All features must support the multi-role account system (Consumer, Business, Guide, Premium).
- **Community Integration**: Code architecture should make deal discovery feel social through category-based rooms.
- **User Interface**: An Instagram-inspired interface should be used for seamless switching between roles.
- **Cross-Role Features**: User roles should enhance each other (e.g., business owners can also be guides).

## Current Development Phase

**Phase**: Initial MVP Development - Focus on working app functionality
**Priority**: App functionality and user experience over backend architecture
**Backend Strategy**: Use mock data until explicitly told to integrate Firebase
**Monetization**: Hidden for now - app must be "really free" initially

## Development Strategy
All development should proceed using the mock data available in `lib/utils/mock_data.dart`. Do not implement or connect to Firebase until all features are fully functional with mock data and a final confirmation is given to switch to the live backend.

## AI Orchestration Collaboration

### Division of Labor
- **Gemini**: Research, analysis, strategy, market intelligence, cultural guidance
- **Claude (You)**: Implementation, architecture, code review, technical execution
- **Human Architect**: Vision, direction, quality control, final decisions

### Implementation Guidelines
- **Complete One Task Before Moving to Next**: Never leave tasks partially completed.
- **Fix Issues Immediately**: When verification finds problems, fix them immediately rather than saving for later.
- **Document Progress**: Update verification TODOs and track what was fixed vs what needs fixing.
- **Context Preservation**: With limited context (70% remaining), complete each file transformation before moving to next.
- **No Batch Processing**: Avoid trying to do everything at once - this leads to lost work when context runs out.
- **Verification → Fix → Document → Next**: Always follow this sequence to preserve progress.

### Code Style & Conventions
- Use **Dart naming conventions**: `camelCase` for variables/functions, `PascalCase` for classes.
- **File naming**: `snake_case` for file names (e.g., `home_screen.dart`).
- **Import order**: Flutter packages first, then third-party, then local imports.
- **Widget structure**: Prefer `StatelessWidget` over `StatefulWidget` when possible.
- **State management**: Use flutter_riverpod pattern consistently (migrating from provider).
- **Error handling**: Always implement try-catch for async operations.
- **Firebase**: Use streams for real-time data, handle null values properly.
- **UI**: Follow Material Design guidelines, use consistent spacing (8px multiples).
- **Comments**: Add code comments sparingly. Focus on *why* something is done, especially for complex logic, rather than *what* is done. Only add high-value comments if necessary for clarity or if requested by the user. Do not edit comments that are separate from the code you are changing. *NEVER* talk to the user or describe your changes through comments.
- **Dual-Problem Focus**: Every feature must help solve both the business optimization and social discovery problems.
- **Account Architecture**: All features must support the multi-role account system (Consumer, Business, Guide, Premium).
- **Community Integration**: Code architecture should make deal discovery feel social through category-based rooms.
- **User Interface**: An Instagram-inspired interface should be used for seamless switching between active roles.
- **Cross-Role Features**: User roles should enhance each other (e.g., business owners can also be guides).

### Critical Terminology Rules
**ALWAYS use "Role" terminology - NEVER use "ADDON":**
- ✅ **Correct**: UserRole, activeRoles, RoleToggleProvider, rolePricing
- ❌ **Incorrect**: UserAddon, activeAddons, AddonToggleProvider, addonPricing

The project had historical inconsistency with "ADDON" terminology which has been officially deprecated. All new code and refactoring must use "Role" terminology consistently.

### Flutter App Execution
**NEVER run `flutter run` or any Flutter app execution commands.** Only use Flutter commands for:
- Dependencies: `flutter pub get`
- Code analysis: `flutter analyze`
- Build verification: `flutter build --dry-run`
- Project setup: `flutter create`, `flutterfire configure`

This prevents unnecessary resource usage and potential device conflicts during development.

### Mandatory Linting Rule
**ALWAYS run linters and fix ALL issues after each code change:**
1. After editing any Dart file, immediately run `flutter analyze`
2. Fix all linting errors and warnings before proceeding
3. Use `dart fix --apply` for auto-fixable issues
4. Manually fix remaining issues
5. This is MANDATORY - never leave linting issues unresolved

### Deprecated API Rule
**NEVER use deprecated APIs - always use modern replacements:**
- ❌ `color.withOpacity(0.5)` (deprecated)
- ✅ `color.withValues(alpha: 0.5)` (modern replacement)
- Always replace `.withOpacity()` with `.withValues(alpha:)` to avoid precision loss

### Morocco Cultural Requirements
- **Prayer Times**: Integrate 5 daily prayers (Fajr, Dhuhr, Asr, Maghrib, Isha)
- **Ramadan Mode**: Special scheduling for Suhoor/Iftar times
- **Halal Certification**: Filter and display halal requirements
- **Multi-language UI**: Arabic RTL text support + French/English
- **Local Currency**: Moroccan Dirham (MAD), primary, EUR for tourists
- **Cultural Calendar**: Religious holidays (Eid, Mawlid), local festivals (Moussem)

### Security and Safety Rules
- **Never introduce code that exposes, logs, or commits secrets, API keys, or other sensitive information.**
- **Always apply security best practices.**

### Critical Rule: Never Delete Files
**NEVER delete any files using rm, deletion commands, or file removal operations.**
- If files need to be removed, ALWAYS move them to `/trash/` folder instead
- Use commands like `mv filename /Users/edsteine/AndroidStudioProjects/deadhour/trash/`
- This allows recovery in case of misunderstandings or mistakes
- Create timestamped backups if moving multiple files: `mv filename /trash/filename_$(date +%Y%m%d_%H%M%S)`
- ALWAYS preserve user work - never permanently delete anything
- Ask user for confirmation before moving files to trash if uncertain

### Testing Guidelines
- **Write tests for all new features and bug fixes.**
- **Aim for high test coverage, especially for critical paths.**
- **Use unit, widget, and integration tests as appropriate.**
- **Ensure tests are clear, concise, and maintainable.**

### Documentation Guidelines
- **Update relevant documentation (e.g., `README.md`, `API_DOCUMENTATION.md`) for any changes you make.**
- **Ensure documentation is clear, accurate, and up-to-date.**

### Communication Guidelines
- **Communicate clearly and concisely with the Human Architect and Gemini.**
- **Provide regular updates on your progress and any challenges you encounter.**
- **Ask for clarification if any instructions are unclear.**

### Final Reminder
Your primary goal is to implement the DeadHour platform according to the provided specifications and guidelines. Adhere strictly to all rules and best practices. Your work will be reviewed by the Human Architect and Gemini for quality and adherence to standards.