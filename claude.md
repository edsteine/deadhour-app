
# DeadHour Project - Claude Instructions

## Project Context

**DeadHour** is a **dead hours optimization platform** that helps businesses fill empty venues during slow periods through discounted deals.

**Core Problem**: Restaurants, cafés, and entertainment venues across Morocco lose massive revenue during off-peak hours (60-70% of operating time generates minimal income). Empty seats = lost money that can never be recovered.

**Simple Solution**: DeadHour connects businesses posting deals during their **dead hours** (when they have 0-few customers) with users looking for discounted experiences. 

**How It Works**:
1. **Businesses** post deals during their slow periods (e.g., restaurant at 3 PM offers 30% off)
2. **Users** browse deals in category-based rooms (🍕 Food, 🎮 Entertainment, etc.)
3. **Booking** happens through the app with reduced prices
4. **Result**: Empty venues get customers, customers get discounts

**Community Aspect**: Deals are organized in Discord-like rooms by category, making deal discovery feel like community-based recommendations rather than just browsing discounts.

**User Account System**: Single account with multiple capabilities (ADDON/Role/Profile terminology refers to the same user interface concept):

**Core User Capabilities**:
- **Consumer** (Free): Browse and book dead hour deals in category rooms
- **Business** (€30/month): Post your venue's dead hour deals, manage bookings, access analytics
- **Guide** (€20/month): Share local expertise about venues and experiences  
- **Premium** (€15/month): Enhanced features across all capabilities
- **Future Capabilities**: Driver, Host, Chef, Photographer for additional services

**Why Single Account System**:
- **One Account**: Single login for all capabilities instead of separate accounts
- **Real-World Flexibility**: Restaurant owner can also be a local guide using same account
- **Revenue Stacking**: Business owner (€30) + Guide (€20) + Premium (€15) = €65/month from one user
- **Seamless Switching**: Instagram-inspired interface to switch between capabilities

**IMPORTANT**: ADDON/Role/Profile are just UI terms for the same account system concept. The core focus is solving dead hours optimization and social discovery problems, not the interface terminology.

**Development Context**: A coworker initially misunderstood the app's purpose and thought it was primarily about ADDONs/capabilities rather than dead hours optimization. While this wasn't the core vision, their ADDON-focused work contained valuable insights about user account flexibility and revenue stacking that we've incorporated into our account system design. We preserve their terminology and concepts where relevant while keeping the app's true focus on solving business dead hours and social discovery problems.

**Market Opportunity**: 
- **Primary Market**: 300K+ businesses in Morocco with dead hours needing customers
- **User Market**: 8M+ urban locals + 13M+ annual tourists looking for deals
- **Revenue Potential**: €3.6B+ through multi-capability stacking across 20M+ users

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
- **Backend**: Firebase (Firestore, Auth, Storage, Cloud Messaging, Functions)
- **Database**: Firestore NoSQL database
- **Authentication**: Firebase Auth (Email/Password, Phone, Google)
- **Storage**: Firebase Storage for images
- **Push Notifications**: Firebase Cloud Messaging
- **Maps**: Google Maps Flutter
- **State Management**: Provider pattern
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
- `flutter doctor` - Check Flutter installation and dependencies
- `flutter pub get` - Install project dependencies
- `flutter build apk --release` - Build release APK for Android
- `flutter build appbundle --release` - Build App Bundle for Play Store
- `firebase --version` - Check Firebase CLI version
- `flutterfire configure` - Configure Firebase for Flutter project

## CRITICAL RULE: Flutter App Execution
**NEVER run `flutter run` or any Flutter app execution commands.** Only use Flutter commands for:
- Dependencies: `flutter pub get`
- Code analysis: `flutter analyze`
- Build verification: `flutter build --dry-run`
- Project setup: `flutter create`, `flutterfire configure`

This prevents unnecessary resource usage and potential device conflicts during development.
- `flutter analyze` - Run static analysis and lint checks
- `dart fix --apply` - Auto-fix lint issues where possible

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

**Multiple Revenue Streams from Account System:**
- **Business Capability**: €30/month SaaS for venue management and revenue optimization
- **Guide Capability**: €20/month for local expertise sharing and commission earnings
- **Premium Capability**: €15/month for enhanced features across all capabilities
- **Booking Commissions**: 8-15% on successful off-peak bookings (alternative to commissions model)
- **Social Commerce**: Sponsored content, premium discovery features
- **Future Capabilities**: Driver, Host, Chef, Photographer for infinite scalability

**Network Effects Magic**: More users = more audience for business deals = more options for users = stronger community = exponential value creation

**Financial Projections:**
- **Year 1**: $150K revenue (dual-problem validation + multi-role subscriptions)
- **Year 2**: $1.2M revenue (network effects acceleration + multi-city expansion)
- **Year 3**: $4M revenue (full dual-problem platform + international potential)
- **Unit Economics**: €60-65 average revenue per user (multiple streams + capability stacking), 75%+ gross margins
- **Key Multipliers**: Tourism users spend 3-5x more than locals, multi-capability users generate 2-3x more revenue
- **Multi-Capability Economics**: Full-capability users (€65/month) vs single-capability users create exponential value

**Success Metrics**: Cross-problem engagement rate, venue fill rate during off-peak hours, community activity, multi-capability adoption, network effects acceleration, capability switching frequency

## Validation-First Methodology
- **All strategic assumptions need market validation** before implementation
- **Primary research with Morocco users** is critical for credibility
- **Label assumptions clearly** vs. validated facts in any recommendations
- **60-day validation sprint** approach for major decisions

## Task Execution Methodology
- **Complete One Task Before Moving to Next**: Never leave tasks partially completed
- **Fix Issues Immediately**: When verification finds problems, fix them immediately rather than saving for later
- **Document Progress**: Update verification TODOs and track what was fixed vs what needs fixing
- **Context Preservation**: With limited context (9% remaining), complete each file transformation before moving to next
- **No Batch Processing**: Avoid trying to do everything at once - this leads to lost work when context runs out
- **Verification → Fix → Document → Next**: Always follow this sequence to preserve progress

## Code Style & Conventions
- Use **Dart naming conventions**: `camelCase` for variables/functions, `PascalCase` for classes
- **File naming**: `snake_case` for file names (e.g., `home_screen.dart`)
- **Import order**: Flutter packages first, then third-party, then local imports
- **Widget structure**: Prefer `StatelessWidget` over `StatefulWidget` when possible
- **State management**: Use Provider pattern consistently
- **Error handling**: Always implement try-catch for async operations
- **Firebase**: Use streams for real-time data, handle null values properly
- **UI**: Follow Material Design guidelines, use consistent spacing (8px multiples)
- **Comments**: Minimal comments, focus on self-documenting code
- **Dead Hours Focus**: Every feature should help businesses fill empty venues or help users find discounted deals
- **Account Architecture**: All features must support capability switching between Consumer/Business/Guide/Premium
- **Community Integration**: Code architecture should make deal discovery feel social through category-based rooms
- **User Interface**: Instagram-inspired interface for seamless capability switching within single account
- **Cross-Capability Features**: User capabilities that enhance each other (business owners can also be guides)