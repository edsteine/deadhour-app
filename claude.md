
# DeadHour Project - Claude Instructions

## Project Context

**DeadHour** is a **dual-problem platform** that simultaneously solves:
1. **Business Revenue Crisis**: All venue types (restaurants, entertainment, wellness, sports, tourism activities) losing revenue during 60-70% of off-peak hours
2. **Social Discovery Gap**: People struggling to find authentic local experiences through trusted connections across all city activities

**Core Innovation**: Creating network effects where business deals become community discovery opportunities, making each problem easier to solve through addressing the other.

**Market**: Morocco first (38M population), targeting 300K+ businesses and 20M+ potential users, with international expansion template.

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
- `flutter run` - Run app in debug mode
- `flutter build apk --release` - Build release APK for Android
- `flutter build appbundle --release` - Build App Bundle for Play Store
- `firebase --version` - Check Firebase CLI version
- `flutterfire configure` - Configure Firebase for Flutter project

## Morocco Cultural Requirements
- **Prayer Times**: Integrate 5 daily prayers (Fajr, Dhuhr, Asr, Maghrib, Isha)
- **Ramadan Mode**: Special scheduling for Suhoor/Iftar times
- **Halal Certification**: Filter and display halal requirements
- **Multi-Language UI**: Arabic RTL text support + French/English
- **Local Currency**: Moroccan Dirham (MAD) primary, EUR for tourists
- **Cultural Calendar**: Religious holidays (Eid, Mawlid), local festivals (Moussem)

## Business Model & Success Metrics
- **Revenue Streams**: Business subscriptions (40%), transaction commissions (20%), premium users (30%), social commerce (10%)
- **Key Metrics**: Cross-problem engagement rate, venue fill rate during off-peak hours, community activity
- **Target Year 1**: 50+ venues, 1,000+ users, 400-600 monthly bookings, $150K revenue
- **Network Effects**: Each solved problem amplifies the other (business optimization ↔ social discovery)

## Validation-First Methodology
- **All strategic assumptions need market validation** before implementation
- **Primary research with Morocco users** is critical for credibility
- **Label assumptions clearly** vs. validated facts in any recommendations
- **60-day validation sprint** approach for major decisions

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
- **Dual-Problem Focus**: Every feature should demonstrate value for both business optimization AND social discovery