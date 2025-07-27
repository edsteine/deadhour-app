# DeadHour Dual-Problem MVP - Complete Development Guide

## Overview - Build Dual-Problem Platform with Multi-Role Account System in 4 Weeks
**Status:** MVP development approach validated by independent AI analyses (Claude + Gemini).
**Consensus:** The rapid iteration and dual-problem focus of the MVP are key strengths.

This guide provides step-by-step instructions to build a dual-problem platform solving both business revenue optimization AND social discovery using Flutter + Firebase. The MVP demonstrates network effects by making each problem easier to solve through addressing the other, enhanced by a multi-role account system.

**Target Timeline**: 4 weeks (dual-problem features + multi-role system integrated from Day 1)
**Tech Stack**: Flutter + Firebase (Firestore, Auth, Storage, Real-time messaging)
**Note on Technical Evolution**: This stack is chosen for the MVP to ensure rapid development and validation. As outlined in the production architecture, the platform is designed to migrate to a more scalable Django/PostgreSQL backend post-investment.
**Core Innovation**: Every feature serves both business optimization AND social discovery, enabled by flexible user roles.
**Multi-Role System**: Instagram-inspired interface for seamless role switching (Consumer/Business/Guide/Premium).
**Deployment**: Android Play Store with a demonstration of the dual-problem concept and multi-role system.  

---

## Pre-Development Setup

### Development Environment
```bash
# Required installations
flutter doctor  # Ensure Flutter is properly installed
firebase --version  # Install Firebase CLI if needed
```

### Dual-Problem + Multi-Role Firebase Project Setup
1. **Create Firebase Project**: Go to [console.firebase.google.com](https://console.firebase.google.com)
2. **Enable Services for Enhanced Platform**:
   - Authentication (Email/Password, Phone, Google for tourists + multi-role users)
   - Firestore Database (real-time for social features + role management)
   - Storage (user photos, venue images, social content, role-specific media)
   - Cloud Messaging (deal notifications + social activity + role switching alerts)
   - Firebase Functions (network effects analytics + multi-role interaction tracking)
3. **Enhanced Collections Structure (Morocco-Localized + Multi-Role)**:
   ```
   cities/casablanca/
     rooms/
       food-morning-deals/ {
         deals: [], 
         messages: [], 
         members: [], 
         culturalContext: "post-prayer-breakfast",
         multiRoleMembers: {userId: {roles: ["consumer", "business"], lastActive: timestamp}}
       }
       coffee-afternoon-chat/ {
         social_content: true, 
         business_deals: true, 
         timeContext: "14:00-16:00_avoiding_asr_prayer",
         roleBasedAccess: {guide: true, premium: true}
       }
       iftar-ramadan-specials/ {
         seasonalDeals: [], 
         fastingSchedule: true,
         guideRecommendations: [],
         businessPromotions: []
       }
     users/ {
       userType: "local"|"tourist", 
       interests: [], 
       crossProblemActivity: [],
       activeRoles: ["consumer", "business", "guide", "premium"],
       roleCapabilities: {
         business: {venueId: string, analyticsAccess: boolean, subscriptionActive: boolean},
         guide: {expertiseAreas: [], commissionRate: number, verificationStatus: string},
         premium: {enhancedFeatures: true, crossRoleAnalytics: true, adFree: boolean}
       },
       roleSwitchingHistory: [],
       crossRoleNetworkEffects: {multiplier: number, lastCalculated: timestamp},
       culturalPreferences: {
         language: "arabic"|"french"|"english",
         prayerTimeAware: boolean,
         halalRequirements: boolean,
         ramadanModeEnabled: boolean
       }
     }
     culturalCalendar/ {
       prayerTimes: {fajr, dhuhr, asr, maghrib, isha},
       ramadanSchedule: {suhoor, iftar},
       religiousHolidays: [eid, mawlid],
       localEvents: [moussem, festivals]
     }
     multiRoleSystem/ {
       availableRoles: {
         consumer: {price: 0, features: ["deal_discovery", "community_rooms", "basic_social"]},
         business: {price: 30, features: ["venue_management", "analytics", "deal_creation", "priority_placement"]},
         guide: {price: 20, features: ["expertise_sharing", "commission_earning", "tourist_services", "verified_badge"]},
         premium: {price: 15, features: ["enhanced_all_roles", "early_access", "ad_free", "cross_role_analytics"]}
       },
       roleStacking: true,
       instagramInspiredInterface: true
     }
   ```

---

## Week 1: Dual-Problem Foundation + Multi-Role System Architecture

**Goal**: Establish dual-problem architecture with local/tourist user types, room-based structure, and multi-role account flexibility

### Day 1-2: Project Setup & Firebase Integration

**Flutter Project Creation**
```bash
flutter create deadhour_mvp
cd deadhour_mvp
```

**Add Dependencies** (`pubspec.yaml`)
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.15.0
  firebase_auth: ^4.7.0
  cloud_firestore: ^4.8.0
  firebase_storage: ^11.2.0
  firebase_messaging: ^14.6.0
  google_maps_flutter: ^2.3.0
  geolocator: ^9.0.2
  provider: ^6.0.5
  intl: ^0.18.1
  image_picker: ^1.0.2
```

**Main App Setup with Multi-Role Support** (`lib/main.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/role_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RoleProvider()),
      ],
      child: MaterialApp(
        title: 'DeadHour - Dual Problem Platform',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Roboto',
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
```

### Day 3-5: Enhanced User Authentication + Multi-Role System

**Multi-Role Provider** (`lib/providers/role_provider.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserRole { consumer, business, guide, premium }

class RoleProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserRole> _activeRoles = [UserRole.consumer];
  UserRole _currentRole = UserRole.consumer;
  bool _isLoading = false;

  List<UserRole> get activeRoles => _activeRoles;
  UserRole get currentRole => _currentRole;
  bool get isLoading => _isLoading;
  
  bool hasRole(UserRole role) => _activeRoles.contains(role);
  bool get isMultiRole => _activeRoles.length > 1;
  
  Future<void> loadUserRoles() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    
    try {
      _isLoading = true;
      notifyListeners();
      
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        final roleStrings = List<String>.from(data['activeRoles'] ?? ['consumer']);
        _activeRoles = roleStrings.map((r) => _stringToRole(r)).toList();
        
        final currentRoleString = data['currentRole'] ?? 'consumer';
        _currentRole = _stringToRole(currentRoleString);
      }
    } catch (e) {
      print('Error loading roles: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<bool> switchRole(UserRole newRole) async {
    if (!hasRole(newRole)) return false;
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;
      
      _currentRole = newRole;
      notifyListeners();
      
      // Update in Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'currentRole': _roleToString(newRole),
        'lastRoleSwitch': FieldValue.serverTimestamp(),
      });
      
      return true;
    } catch (e) {
      print('Error switching role: $e');
      return false;
    }
  }
  
  Future<bool> addRole(UserRole role) async {
    if (hasRole(role)) return true;
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;
      
      _activeRoles.add(role);
      notifyListeners();
      
      // Update in Firestore with role capabilities
      final roleCapabilities = await _getRoleCapabilities(role);
      await _firestore.collection('users').doc(user.uid).update({
        'activeRoles': _activeRoles.map(_roleToString).toList(),
        'roleCapabilities.${_roleToString(role)}': roleCapabilities,
        'roleAdded': FieldValue.serverTimestamp(),
      });
      
      return true;
    } catch (e) {
      print('Error adding role: $e');
      return false;
    }
  }
  
  UserRole _stringToRole(String roleString) {
    switch (roleString) {
      case 'business': return UserRole.business;
      case 'guide': return UserRole.guide;
      case 'premium': return UserRole.premium;
      default: return UserRole.consumer;
    }
  }
  
  String _roleToString(UserRole role) {
    return role.toString().split('.').last;
  }
  
  Future<Map<String, dynamic>> _getRoleCapabilities(UserRole role) async {
    switch (role) {
      case UserRole.business:
        return {
          'venueManagement': true,
          'analytics': true,
          'dealCreation': true,
          'priorityPlacement': true,
          'subscriptionActive': true,
        };
      case UserRole.guide:
        return {
          'expertiseSharing': true,
          'commissionEarning': true,
          'touristServices': true,
          'verifiedBadge': false,
          'expertiseAreas': [],
          'commissionRate': 0.15,
        };
      case UserRole.premium:
        return {
          'enhancedFeatures': true,
          'earlyAccess': true,
          'adFree': true,
          'crossRoleAnalytics': true,
          'prioritySupport': true,
        };
      default:
        return {
          'dealDiscovery': true,
          'communityRooms': true,
          'basicSocial': true,
        };
    }
  }
}
```

**Enhanced Auth Provider** (`lib/providers/auth_provider.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = result.user;
      return true;
    } catch (e) {
      print('Sign in error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registerWithEmail(String email, String password, String name, String phone) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Create user profile with dual-problem + multi-role structure
      await _firestore.collection('users').doc(result.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'userType': 'local', // local or tourist
        'interests': [],
        'crossProblemActivity': [],
        'activeRoles': ['consumer'], // Start with consumer role
        'currentRole': 'consumer',
        'roleCapabilities': {
          'consumer': {
            'dealDiscovery': true,
            'communityRooms': true,
            'basicSocial': true,
          }
        },
        'roleSwitchingHistory': [],
        'crossRoleNetworkEffects': {'multiplier': 1.0},
        'culturalPreferences': {
          'language': 'french', // Default for Morocco
          'prayerTimeAware': false,
          'halalRequirements': false,
          'ramadanModeEnabled': false,
        },
        'created_at': FieldValue.serverTimestamp(),
      });
      
      _user = result.user;
      return true;
    } catch (e) {
      print('Register error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
```

### Day 6-7: Enhanced Home Screen with Updated Navigation Structure

**Role Switcher Widget** (`lib/widgets/role_switcher.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/role_provider.dart';

class RoleSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RoleProvider>(
      builder: (context, roleProvider, child) {
        if (!roleProvider.isMultiRole) return SizedBox.shrink();
        
        return Container(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: roleProvider.activeRoles.length,
            itemBuilder: (context, index) {
              final role = roleProvider.activeRoles[index];
              final isActive = role == roleProvider.currentRole;
              
              return GestureDetector(
                onTap: () => roleProvider.switchRole(role),
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green[600] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive ? Colors.green[800]! : Colors.grey[400]!,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getRoleIcon(role),
                        size: 16,
                        color: isActive ? Colors.white : Colors.grey[600],
                      ),
                      SizedBox(width: 4),
                      Text(
                        _getRoleName(role),
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.grey[600],
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
  
  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.business:
        return Icons.business;
      case UserRole.guide:
        return Icons.explore;
      case UserRole.premium:
        return Icons.star;
      default:
        return Icons.person;
    }
  }
  
  String _getRoleName(UserRole role) {
    switch (role) {
      case UserRole.business:
        return 'Business';
      case UserRole.guide:
        return 'Guide';
      case UserRole.premium:
        return 'Premium';
      default:
        return 'Consumer';
    }
  }
}
```

**Enhanced Home Screen with Updated Navigation** (`lib/screens/home_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../models/venue.dart';
import '../widgets/venue_card.dart';
import '../widgets/role_switcher.dart';
import '../providers/role_provider.dart';
import 'venue_detail_screen.dart';
import 'community_rooms_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadUserRoles();
  }

  Future<void> _loadUserRoles() async {
    final roleProvider = Provider.of<RoleProvider>(context, listen: false);
    await roleProvider.loadUserRoles();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<RoleProvider>(
          builder: (context, roleProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DeadHour', style: TextStyle(fontSize: 20)),
                if (roleProvider.isMultiRole)
                  Text(
                    'Active: ${_getRoleName(roleProvider.currentRole)}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
              ],
            );
          },
        ),
        backgroundColor: Colors.green[600],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => CommunityRoomsScreen())),
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to profile with role management
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Multi-Role Switcher (Instagram-inspired)
          RoleSwitcher(),
          
          // Search Bar
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.green[600],
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search cafés, restaurants...',
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Dual-Problem Deal Highlights
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(16),
              children: [
                _buildDualProblemCard('Business Optimization', '50% revenue increase', 'Off-peak deals', Colors.orange),
                _buildDualProblemCard('Social Discovery', '72% want local recommendations', 'Community rooms', Colors.blue),
                _buildDualProblemCard('Network Effects', 'Both problems solved together', 'Exponential value', Colors.purple),
              ],
            ),
          ),

          // Nearby Venues with Role-Based Features
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('venues')
                  .where('is_active', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restaurant, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No venues available yet',
                             style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                        SizedBox(height: 8),
                        Text('Business owners can add their venues through Profile > Role Switching',
                             style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Venue venue = Venue.fromFirestore(snapshot.data!.docs[index]);
                    return Consumer<RoleProvider>(
                      builder: (context, roleProvider, child) {
                        return VenueCard(
                          venue: venue,
                          currentRole: roleProvider.currentRole,
                          onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => VenueDetailScreen(venue: venue))),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildUpdatedBottomNav(),
    );
  }

  Widget _buildDualProblemCard(String title, String metric, String solution, Color color) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 4),
          Text(metric, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 4),
          Text(solution, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
    );
  }
  
  Widget _buildUpdatedBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Discover'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Community'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (index) {
        _handleUpdatedBottomNavTap(index);
      },
    );
  }
  
  void _handleUpdatedBottomNavTap(int index) {
    // Updated navigation logic - Business features moved to Profile
    switch (index) {
      case 0: // Discover - main content discovery
        break;
      case 1: // Community - room-based social features
        Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityRoomsScreen()));
        break;
      case 2: // Explore - tourism and local experiences
        // Navigate to tourism/explore screen
        break;
      case 3: // Profile - role management + all business features
        // Navigate to enhanced profile with role switching
        break;
    }
  }
  
  String _getRoleName(UserRole role) {
    switch (role) {
      case UserRole.business: return 'Business';
      case UserRole.guide: return 'Guide';
      case UserRole.premium: return 'Premium';
      default: return 'Consumer';
    }
  }
}
```

---

## Week 2: Core Booking Flow + Room-Based Social Discovery

### Day 1-3: Enhanced Venue Detail with Role-Based Features

**Enhanced Venue Model** (`lib/models/venue.dart`)
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Venue {
  final String id;
  final String name;
  final String category;
  final String phone;
  final String description;
  final GeoPoint location;
  final String? imageUrl;
  final bool isActive;
  final Map<String, dynamic>? businessRoleFeatures;
  final List<String> communityRooms;

  Venue({
    required this.id,
    required this.name,
    required this.category,
    required this.phone,
    required this.description,
    required this.location,
    this.imageUrl,
    required this.isActive,
    this.businessRoleFeatures,
    this.communityRooms = const [],
  });

  factory Venue.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Venue(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      phone: data['phone'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? GeoPoint(33.5731, -7.5898),
      imageUrl: data['image_url'],
      isActive: data['is_active'] ?? true,
      businessRoleFeatures: data['business_role_features'],
      communityRooms: List<String>.from(data['community_rooms'] ?? []),
    );
  }
}
```

**Community Rooms Screen** (`lib/screens/community_rooms_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/role_provider.dart';

class CommunityRoomsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> roomCategories = [
    {'name': '🍕 Food & Dining', 'id': 'food-dining', 'description': 'Restaurant deals & dining discussions'},
    {'name': '🎮 Entertainment', 'id': 'entertainment', 'description': 'Games, events & fun activities'},
    {'name': '💆 Wellness', 'id': 'wellness', 'description': 'Spas, fitness & health deals'},
    {'name': '🌍 Tourism', 'id': 'tourism', 'description': 'Local guides & tourist experiences'},
    {'name': '⚽ Sports', 'id': 'sports', 'description': 'Sports facilities & activities'},
    {'name': '👨‍👩‍👧‍👦 Family', 'id': 'family', 'description': 'Family-friendly activities & deals'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Rooms'),
        subtitle: Text('Social Discovery + Business Deals'),
        backgroundColor: Colors.green[600],
      ),
      body: Consumer<RoleProvider>(
        builder: (context, roleProvider, child) {
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: roomCategories.length,
            itemBuilder: (context, index) {
              final room = roomCategories[index];
              return Card(
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[100],
                    child: Text(room['name'][0], style: TextStyle(fontSize: 20)),
                  ),
                  title: Text(room['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(room['description']),
                      SizedBox(height: 4),
                      _buildRoleIndicators(roleProvider, room['id']),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => _openRoom(context, room, roleProvider),
                ),
              );
            },
          );
        },
      ),
    );
  }
  
  Widget _buildRoleIndicators(RoleProvider roleProvider, String roomId) {
    List<Widget> indicators = [];
    
    if (roleProvider.hasRole(UserRole.business)) {
      indicators.add(Chip(
        label: Text('Post Deals', style: TextStyle(fontSize: 10)),
        backgroundColor: Colors.orange[100],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ));
    }
    
    if (roleProvider.hasRole(UserRole.guide)) {
      indicators.add(Chip(
        label: Text('Share Expertise', style: TextStyle(fontSize: 10)),
        backgroundColor: Colors.blue[100],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ));
    }
    
    if (roleProvider.hasRole(UserRole.premium)) {
      indicators.add(Chip(
        label: Text('Early Access', style: TextStyle(fontSize: 10)),
        backgroundColor: Colors.purple[100],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ));
    }
    
    return Wrap(spacing: 4, children: indicators);
  }
  
  void _openRoom(BuildContext context, Map<String, dynamic> room, RoleProvider roleProvider) {
    // Navigate to specific room with role-based features
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => RoomDetailScreen(
        roomId: room['id'],
        roomName: room['name'],
        currentRole: roleProvider.currentRole,
      ),
    ));
  }
}

class RoomDetailScreen extends StatelessWidget {
  final String roomId;
  final String roomName;
  final UserRole currentRole;
  
  RoomDetailScreen({
    required this.roomId,
    required this.roomName,
    required this.currentRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
        backgroundColor: Colors.green[600],
        actions: [
          if (currentRole == UserRole.business || currentRole == UserRole.guide)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _showAddContentDialog(context),
            ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('community_rooms')
            .doc(roomId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          
          return ListView.builder(
            reverse: true,
            padding: EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final message = snapshot.data!.docs[index];
              return _buildMessageCard(message);
            },
          );
        },
      ),
      bottomSheet: _buildMessageInput(),
    );
  }
  
  Widget _buildMessageCard(QueryDocumentSnapshot message) {
    final data = message.data() as Map<String, dynamic>;
    final isBusinessPost = data['type'] == 'business_deal';
    final isGuidePost = data['type'] == 'guide_recommendation';
    
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      color: isBusinessPost ? Colors.orange[50] : 
             isGuidePost ? Colors.blue[50] : null,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.green[200],
                  child: Text(data['userName'][0]),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['userName'], style: TextStyle(fontWeight: FontWeight.bold)),
                      if (data['userRole'] != null)
                        Text(data['userRole'], style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                    ],
                  ),
                ),
                if (isBusinessPost) Icon(Icons.business, color: Colors.orange[600], size: 16),
                if (isGuidePost) Icon(Icons.explore, color: Colors.blue[600], size: 16),
              ],
            ),
            SizedBox(height: 8),
            Text(data['content']),
            if (data['dealInfo'] != null) _buildDealInfo(data['dealInfo']),
            SizedBox(height: 4),
            Text(
              _formatTimestamp(data['timestamp']),
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDealInfo(Map<String, dynamic> dealInfo) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${dealInfo['discount']}% OFF', 
               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[700])),
          Text(dealInfo['description']),
          Text('Valid: ${dealInfo['timeSlot']}', 
               style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
  
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 4, offset: Offset(0, -2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Share your thoughts...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton.small(
            onPressed: () {}, // Send message
            backgroundColor: Colors.green[600],
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
  
  void _showAddContentDialog(BuildContext context) {
    // Show dialog for Business role users to add deals
    // or Guide role users to share recommendations
  }
  
  String _formatTimestamp(dynamic timestamp) {
    // Format timestamp for display
    return '2 hours ago'; // Placeholder
  }
}
```

### Day 4-7: Enhanced Booking Flow with Social Validation

The booking flow now includes social validation from community rooms, showing which deals were discovered through social discovery vs direct search, and enabling cross-problem network effects where business optimization and social discovery amplify each other.

**Key Implementation Updates:**
- Business tab removed from bottom navigation
- Business features accessible through Profile role switching
- Enhanced profile with guest mode, authentication, and comprehensive features
- Development menu drawer for testing all screens
- "Really free" strategy with hidden premium elements

*[Continue with enhanced booking screens that show social proof, community recommendations, and role-based features...]*

---

## Week 3: Advanced Multi-Role Features

### Day 1-3: Business Role Dashboard
*[Business owners can manage venues, view analytics, and see how community engagement drives bookings...]*

### Day 4-5: Guide Role Features  
*[Local experts can share knowledge, earn commissions, and connect tourists with authentic experiences...]*

### Day 6-7: Premium Role Enhancements
*[Premium users get early access, enhanced analytics, and cross-role insights...]*

---

## Week 4: Integration & Launch

### Day 1-3: Cross-Role Network Effects
*[Implement analytics showing how multiple roles amplify each other...]*

### Day 4-5: Cultural Integration & Testing
*[Morocco-specific features, prayer times, Ramadan mode, multi-language support...]*

### Day 6-7: Launch Preparation
*[Final testing, app store preparation, multi-role system documentation...]*

---

## Success Metrics & KPIs

### Dual-Problem Success Metrics
- **Cross-Problem Engagement**: % of users active in both discovery AND booking
- **Network Effects**: How social discovery increases booking conversion rates
- **Community-Driven Deals**: % of bookings originating from room recommendations

### Multi-Role System Metrics
- **Role Adoption**: % of users with multiple roles
- **Role Switching Frequency**: How often users switch between roles
- **Multi-Role Revenue**: €65+/month potential through role stacking
- **Cross-Role Value**: How multi-role users drive platform growth

### Business Optimization Metrics
- **Venue Fill Rate**: % capacity utilization during off-peak hours
- **Revenue Optimization**: Average revenue increase for participating venues
- **Community Audience Value**: How social features drive venue bookings

---

## Conclusion

This development guide creates a comprehensive dual-problem platform that solves business dead hours AND social discovery gap simultaneously, enhanced by industry-validated multi-role account flexibility. The MVP demonstrates network effects where each problem solved amplifies the other, with Morocco as the proof-of-concept for global expansion.

**Key Success Factors:**
✅ **Dual-Problem Core** - Business optimization + social discovery from Day 1  
✅ **Multi-Role Enhancement** - Instagram-inspired interface for account flexibility  
✅ **Network Effects** - Each solved problem strengthens the other  
✅ **Cultural Integration** - Morocco-specific features and cultural sensitivity  
✅ **Room-Based Community** - Category-specific social discovery architecture  
✅ **Proven Patterns** - Following successful multi-role systems (Airbnb, Instagram)  

The MVP validates both the dual-problem concept and multi-role account system, providing foundation for €65+/month user potential and international expansion template.