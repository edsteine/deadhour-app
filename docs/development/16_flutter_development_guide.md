# DeadHour Flutter Development Guide

This guide provides detailed information for developers working on the DeadHour Flutter application, designed to support the dual-problem platform's complexity and the multi-role account system. It includes setup instructions, coding standards, architectural patterns, and deployment procedures.

## 🛠️ Development Environment Setup

### Prerequisites
- **Flutter SDK**: 3.16.0 or higher
- **Dart SDK**: 3.2.0 or higher
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA
- **Platform Tools**: Android SDK, Xcode (for iOS)

### Initial Setup
1. **Install Flutter**
   ```bash
   # Download Flutter SDK
   git clone https://github.com/flutter/flutter.git -b stable
   export PATH="$PATH:`pwd`/flutter/bin"
   
   # Verify installation
   flutter doctor
   ```

2. **Configure IDE**
   ```bash
   # VS Code extensions
   code --install-extension Dart-Code.flutter
   code --install-extension Dart-Code.dart-code
   
   # Android Studio plugins
   # Install Flutter and Dart plugins through Plugin Manager
   ```

3. **Project Setup**
   ```bash
   cd deadhour_flutter
   flutter pub get
   flutter pub deps
   ```

## 📁 Project Architecture

### Directory Structure
```
lib/
├── main.dart                    # Application entry point
├── app.dart                     # App configuration and theme
├── routes/
│   └── app_routes.dart          # Navigation configuration
├── screens/                     # UI screens organized by feature
│   ├── auth/                    # Authentication screens
│   │   ├── splash_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── user_type_selection_screen.dart
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/                    # Main application screens
│   │   ├── main_navigation_screen.dart
│   │   ├── home_screen.dart
│   │   └── deals_screen.dart
│   ├── community/               # Social features
│   │   ├── rooms_screen.dart
│   │   └── room_chat_screen.dart
│   ├── business/                # Business dashboard
│   │   └── business_dashboard_screen.dart
│   └── profile/                 # User profile
│       └── profile_screen.dart
├── widgets/                     # Reusable UI components
│   └── common/
│       ├── deal_card.dart
│       ├── venue_card.dart
│       ├── room_card.dart
│       ├── loading_widget.dart
│       ├── enhanced_app_bar.dart
│       └── animated_bottom_nav.dart
├── models/                      # Data models
│   ├── user.dart
│   ├── venue.dart
│   ├── deal.dart
│   └── room.dart
└── utils/                       # Utilities and constants
    ├── theme.dart
    ├── constants.dart
    └── mock_data.dart
```

### Architecture Patterns

#### State Management
The app uses **Provider** pattern for state management:
```dart
// Example provider implementation
class DealsProvider extends ChangeNotifier {
  List<Deal> _deals = [];
  bool _isLoading = false;
  
  List<Deal> get deals => _deals;
  bool get isLoading => _isLoading;
  
  Future<void> fetchDeals() async {
    _isLoading = true;
    notifyListeners();
    
    // Fetch deals logic
    _deals = await DealsService.fetchDeals();
    
    _isLoading = false;
    notifyListeners();
  }
}
```

#### Navigation
Uses **GoRouter** for declarative navigation:
```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainNavigationScreen(),
    ),
    // Additional routes...
  ],
);
```

## 🎨 Design System Implementation

### Theme Configuration
The app uses a comprehensive theming system defined in `lib/utils/theme.dart`:

```dart
class AppTheme {
  static const Color moroccoGreen = Color(0xFF00A859);
  static const Color moroccoGold = Color(0xFFFFD700);
  static const Color moroccoRed = Color(0xFFE74C3C);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: moroccoGreen,
        brightness: Brightness.light,
      ),
      // Additional theme configuration...
    );
  }
}
```

### Custom Components
All reusable components follow consistent design patterns:

```dart
class DealCard extends StatelessWidget {
  final Deal deal;
  final VoidCallback? onTap;
  
  const DealCard({
    super.key,
    required this.deal,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: _buildCardContent(),
      ),
    );
  }
}
```

## 📊 Data Management

### Model Classes
All data models implement proper serialization:

```dart
class Deal {
  final String id;
  final String title;
  final String description;
  final double originalPrice;
  final double discountedPrice;
  final DateTime validUntil;
  
  Deal({
    required this.id,
    required this.title,
    required this.description,
    required this.originalPrice,
    required this.discountedPrice,
    required this.validUntil,
  });
  
  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      originalPrice: json['originalPrice'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
      validUntil: DateTime.parse(json['validUntil']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'validUntil': validUntil.toIso8601String(),
    };
  }
}
```

### Mock Data
Development uses comprehensive mock data in `lib/utils/mock_data.dart`:

```dart
class MockData {
  static final List<Deal> deals = [
    Deal(
      id: '1',
      title: 'Afternoon Coffee Special',
      description: 'Premium coffee with pastry',
      originalPrice: 45.0,
      discountedPrice: 27.0,
      validUntil: DateTime.now().add(Duration(hours: 4)),
    ),
    // Additional mock deals...
  ];
  
  static final List<Venue> venues = [
    Venue(
      id: '1',
      name: 'Café Atlas',
      description: 'Traditional Moroccan café',
      location: 'Gueliz, Marrakech',
      category: 'food',
      rating: 4.5,
    ),
    // Additional mock venues...
  ];
}
```

## 🔧 Development Workflow

### Code Standards

#### Dart Style Guide
Follow the official Dart style guide:
- Use `lowerCamelCase` for variables and functions
- Use `UpperCamelCase` for classes and enums
- Use `snake_case` for file names
- Prefer `final` over `var` when possible

#### Widget Organization
```dart
class ExampleScreen extends StatefulWidget {
  // 1. Constructor and required parameters
  const ExampleScreen({super.key, required this.parameter});
  
  final String parameter;
  
  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  // 2. State variables
  bool _isLoading = false;
  
  // 3. Lifecycle methods
  @override
  void initState() {
    super.initState();
    _initializeData();
  }
  
  // 4. Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
  
  // 5. Private helper methods
  Widget _buildAppBar() {
    return AppBar(title: Text(widget.parameter));
  }
  
  Widget _buildBody() {
    return _isLoading ? LoadingWidget() : _buildContent();
  }
  
  Widget _buildContent() {
    // Content implementation
    return Container();
  }
  
  // 6. Event handlers
  void _initializeData() {
    // Initialization logic
  }
}
```

### Testing Strategy

#### Unit Tests
Create tests for all business logic:
```dart
// test/models/deal_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:deadhour_flutter/models/deal.dart';

void main() {
  group('Deal Model Tests', () {
    test('should create deal from JSON', () {
      final json = {
        'id': '1',
        'title': 'Test Deal',
        'originalPrice': 100.0,
        'discountedPrice': 80.0,
      };
      
      final deal = Deal.fromJson(json);
      
      expect(deal.id, '1');
      expect(deal.title, 'Test Deal');
      expect(deal.discountPercentage, 20);
    });
  });
}
```

#### Widget Tests
Test UI components:
```dart
// test/widgets/deal_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deadhour_flutter/widgets/common/deal_card.dart';

void main() {
  testWidgets('DealCard displays deal information', (tester) async {
    final deal = Deal(/* test deal data */);
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DealCard(deal: deal),
        ),
      ),
    );
    
    expect(find.text(deal.title), findsOneWidget);
    expect(find.text('${deal.discountedPrice} MAD'), findsOneWidget);
  });
}
```

### Performance Optimization

#### Image Handling
```dart
// Optimized image loading
CachedNetworkImage(
  imageUrl: venue.imageUrl,
  placeholder: (context, url) => SkeletonLoader(
    width: double.infinity,
    height: 200,
  ),
  errorWidget: (context, url, error) => Icon(Icons.error),
  memCacheWidth: 600, // Resize for memory efficiency
)
```

#### List Performance
```dart
// Efficient list rendering
ListView.builder(
  itemCount: deals.length,
  itemBuilder: (context, index) {
    return DealCard(
      key: ValueKey(deals[index].id), // Stable keys
      deal: deals[index],
    );
  },
)
```

## 🌐 API Integration

### Service Layer Architecture
```dart
// lib/services/deals_service.dart
class DealsService {
  static const String baseUrl = 'https://api.deadhour.ma/v1';
  
  static Future<List<Deal>> fetchDeals({
    String? category,
    String? location,
  }) async {
    final queryParams = <String, String>{};
    if (category != null) queryParams['category'] = category;
    if (location != null) queryParams['location'] = location;
    
    final uri = Uri.parse('$baseUrl/deals').replace(
      queryParameters: queryParams,
    );
    
    final response = await http.get(uri);
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Deal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch deals');
    }
  }
}
```

### Error Handling
```dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, [this.statusCode]);
  
  @override
  String toString() => 'ApiException: $message';
}

// Usage in services
try {
  final deals = await DealsService.fetchDeals();
  return deals;
} on ApiException catch (e) {
  // Handle API-specific errors
  print('API Error: ${e.message}');
  rethrow;
} catch (e) {
  // Handle general errors
  throw ApiException('Network error occurred');
}
```

## 📱 Platform-Specific Considerations

### Android Configuration
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<application
    android:name="io.flutter.app.FlutterApplication"
    android:label="DeadHour"
    android:icon="@mipmap/ic_launcher">
    
    <activity
        android:name=".MainActivity"
        android:exported="true"
        android:launchMode="singleTop"
        android:theme="@style/LaunchTheme">
        
        <intent-filter android:autoVerify="true">
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity>
</application>
```

### iOS Configuration
```xml
<!-- ios/Runner/Info.plist -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show nearby deals.</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs location access to show nearby deals.</string>

<key>CFBundleDisplayName</key>
<string>DeadHour</string>
```

## 🔍 Debugging and Troubleshooting

### Common Issues

#### State Management
```dart
// Problem: Widget not rebuilding
Consumer<DealsProvider>(
  builder: (context, provider, child) {
    return ListView.builder(
      itemCount: provider.deals.length,
      itemBuilder: (context, index) {
        return DealCard(deal: provider.deals[index]);
      },
    );
  },
)

// Solution: Ensure notifyListeners() is called
class DealsProvider extends ChangeNotifier {
  void updateDeals(List<Deal> newDeals) {
    _deals = newDeals;
    notifyListeners(); // Essential for UI updates
  }
}
```

#### Navigation Issues
```dart
// Problem: Context not available
void _navigateToDetails() {
  // Don't use context in async callbacks without checking
  context.push('/deal-details'); // May cause errors
}

// Solution: Check context validity
void _navigateToDetails() async {
  await someAsyncOperation();
  
  if (mounted) { // Check if widget is still in tree
    context.push('/deal-details');
  }
}
```

### Performance Profiling
```bash
# Run with performance overlay
flutter run --profile

# Generate performance report
flutter build apk --analyze-size
```

## 📋 Deployment Checklist

### Pre-deployment Steps
- [ ] Run `flutter analyze` and fix all issues
- [ ] Run all tests: `flutter test`
- [ ] Update version in `pubspec.yaml`
- [ ] Generate app icons for all platforms
- [ ] Update splash screens
- [ ] Configure release signing
- [ ] Test on physical devices
- [ ] Verify API endpoints
- [ ] Check permissions and privacy settings

### Build Commands
```bash
# Android Release
flutter build apk --release
flutter build appbundle --release

# iOS Release
flutter build ios --release
```

## 🤝 Contributing Guidelines

### Pull Request Process
1. **Create Feature Branch**
   ```bash
   git checkout -b feature/new-feature-name
   ```

2. **Follow Coding Standards**
   - Run `dart format .` before committing
   - Ensure all tests pass
   - Add tests for new features

3. **Commit Message Format**
   ```
   feat: add deal filtering functionality
   
   - Implement category-based filtering
   - Add location radius selection
   - Update UI with filter chips
   
   Closes #123
   ```

4. **Submit Pull Request**
   - Provide clear description
   - Include screenshots for UI changes
   - Reference related issues

### Code Review Checklist
- [ ] Code follows Dart style guide
- [ ] All tests pass
- [ ] No performance regressions
- [ ] UI matches design specifications
- [ ] Error handling implemented
- [ ] Documentation updated

---

## 7. 🔍 Technical Gaps & Roadmap

This section addresses the critical gaps identified in the `MISSING_ELEMENTS_COMPREHENSIVE_REPORT.md` and outlines the development priorities.

### Phase 1: Critical Blockers (Current Focus)
1.  **Implement Full Testing Framework**: Achieve >80% coverage.
2.  **Integrate Real Backend**: Replace all mock data from `lib/utils/mock_data.dart` with live API calls to the Firebase/Django backend.
3.  **Implement Security**: Integrate Firebase Auth, manage user sessions, and secure API endpoints.
4.  **Legal Compliance**: Ensure the app includes links to the Terms of Service and Privacy Policy.

### Phase 2: Core Features
1.  **Payment Systems**: Integrate a payment gateway to handle commissions and subscriptions.
2.  **Real-time Features**: Implement WebSocket or other real-time solutions for the community chat features.

This guide will be updated as the project evolves. Please refer to the main project `README.md` and the `DeadHour_UNIFIED_VISION.md` for the overall project strategy.