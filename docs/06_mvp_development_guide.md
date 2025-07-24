# DeadHour Dual-Problem MVP - Complete Development Guide

## Overview - Build Dual-Problem Platform in 4 Weeks

This guide provides step-by-step instructions to build a dual-problem platform solving both business revenue optimization AND social discovery using Flutter + Firebase. The MVP demonstrates network effects by making each problem easier to solve through addressing the other.

**Target Timeline**: 4 weeks (dual-problem features integrated from Day 1)  
**Tech Stack**: Flutter + Firebase (Firestore, Auth, Storage, Real-time messaging)  
**Core Innovation**: Every feature serves both business optimization AND social discovery  
**Deployment**: Android Play Store with dual-problem demonstration  

---

## Pre-Development Setup

### Development Environment
```bash
# Required installations
flutter doctor  # Ensure Flutter is properly installed
firebase --version  # Install Firebase CLI if needed
```

### Dual-Problem Firebase Project Setup
1. **Create Firebase Project**: Go to [console.firebase.google.com](https://console.firebase.google.com)
2. **Enable Services for Dual-Problem Platform**:
   - Authentication (Email/Password, Phone, Google for tourists)
   - Firestore Database (real-time for social features)
   - Storage (user photos, venue images, social content)
   - Cloud Messaging (deal notifications + social activity)
   - Firebase Functions (network effects analytics)
3. **Dual-Problem Collections Structure (Morocco-Localized)**:
   ```
   cities/casablanca/
     rooms/
       food-morning-deals/ {deals: [], messages: [], members: [], culturalContext: "post-prayer-breakfast"}
       coffee-afternoon-chat/ {social content + business deals, timeContext: "14:00-16:00_avoiding_asr_prayer"}
       iftar-ramadan-specials/ {seasonalDeals: [], fastingSchedule: true}
     users/ {
       userType: "local"|"tourist", 
       interests: [], 
       crossProblemActivity: [],
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
   ```

---

## Week 1: Dual-Problem Foundation & User Types

**Goal**: Establish dual-problem architecture with local/tourist user types and room-based structure

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

**Main App Setup** (`lib/main.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'DeadHour',
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

### Day 3-5: User Authentication

**Auth Provider** (`lib/providers/auth_provider.dart`)
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
      
      // Create user profile in Firestore
      await _firestore.collection('users').doc(result.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
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

**Login Screen** (`lib/screens/login_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.access_time, size: 50, color: Colors.white),
                ),
                SizedBox(height: 32),
                
                Text('DeadHour', 
                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                Text('Find deals during off-peak hours',
                     style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                SizedBox(height: 48),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter email';
                    if (!value.contains('@')) return 'Please enter valid email';
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter password';
                    if (value.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                SizedBox(height: 24),

                // Login Button
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: auth.isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: auth.isLoading 
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),

                // Register Link
                TextButton(
                  onPressed: () => Navigator.push(context, 
                    MaterialPageRoute(builder: (_) => RegisterScreen())),
                  child: Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      bool success = await auth.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      
      if (success) {
        Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }
}
```

### Day 6-7: Basic Venue Listing

**Venue Model** (`lib/models/venue.dart`)
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

  Venue({
    required this.id,
    required this.name,
    required this.category,
    required this.phone,
    required this.description,
    required this.location,
    this.imageUrl,
    required this.isActive,
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
    );
  }
}
```

**Home Screen with Venue List** (`lib/screens/home_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../models/venue.dart';
import '../widgets/venue_card.dart';
import 'venue_detail_screen.dart';

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
        title: Text('DeadHour'),
        backgroundColor: Colors.green[600],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to profile
            },
          ),
        ],
      ),
      body: Column(
        children: [
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

          // Deal Highlights
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(16),
              children: [
                _buildDealCard('Up to 50% OFF', 'Afternoon deals', Colors.orange),
                _buildDealCard('30% OFF', 'Late night dining', Colors.blue),
                _buildDealCard('25% OFF', 'Weekend mornings', Colors.purple),
              ],
            ),
          ),

          // Nearby Venues
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
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Venue venue = Venue.fromFirestore(snapshot.data!.docs[index]);
                    return VenueCard(
                      venue: venue,
                      onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => VenueDetailScreen(venue: venue))),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard(String title, String subtitle, Color color) {
    return Container(
      width: 150,
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
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
```

---

## Week 2: Core Booking Flow

### Day 1-3: Venue Detail Screen

**Time Slot Model** (`lib/models/time_slot.dart`)
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSlot {
  final String id;
  final String venueId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int capacity;
  final int discount;
  final bool available;
  final double originalPrice;

  TimeSlot({
    required this.id,
    required this.venueId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.capacity,
    required this.discount,
    required this.available,
    required this.originalPrice,
  });

  double get discountedPrice => originalPrice * (1 - discount / 100);
  double get savings => originalPrice - discountedPrice;

  factory TimeSlot.fromFirestore(DocumentSnapshot doc, String venueId) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TimeSlot(
      id: doc.id,
      venueId: venueId,
      date: (data['date'] as Timestamp).toDate(),
      startTime: data['start_time'] ?? '',
      endTime: data['end_time'] ?? '',
      capacity: data['capacity'] ?? 0,
      discount: data['discount'] ?? 0,
      available: data['available'] ?? false,
      originalPrice: (data['original_price'] ?? 0).toDouble(),
    );
  }
}
```

**Venue Detail Screen** (`lib/screens/venue_detail_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/venue.dart';
import '../models/time_slot.dart';
import '../widgets/time_slot_card.dart';
import 'booking_screen.dart';

class VenueDetailScreen extends StatefulWidget {
  final Venue venue;

  VenueDetailScreen({required this.venue});

  @override
  _VenueDetailScreenState createState() => _VenueDetailScreenState();
}

class _VenueDetailScreenState extends State<VenueDetailScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: widget.venue.imageUrl != null
                  ? Image.network(widget.venue.imageUrl!, fit: BoxFit.cover)
                  : Container(
                      color: Colors.green[600],
                      child: Icon(Icons.restaurant, size: 64, color: Colors.white),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.venue.name,
                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(widget.venue.category,
                       style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(widget.venue.phone,
                           style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(widget.venue.description,
                       style: TextStyle(fontSize: 16)),
                  SizedBox(height: 24),

                  // Date Selector
                  Text('Available Times',
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Container(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        DateTime date = DateTime.now().add(Duration(days: index));
                        bool isSelected = DateFormat('yyyy-MM-dd').format(date) ==
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                        
                        return GestureDetector(
                          onTap: () => setState(() => selectedDate = date),
                          child: Container(
                            width: 60,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.green[600] : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat('E').format(date),
                                     style: TextStyle(
                                       color: isSelected ? Colors.white : Colors.black,
                                       fontWeight: FontWeight.bold,
                                     )),
                                Text(DateFormat('d').format(date),
                                     style: TextStyle(
                                       color: isSelected ? Colors.white : Colors.black,
                                       fontSize: 18,
                                     )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Time Slots
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('venues')
                .doc(widget.venue.id)
                .collection('time_slots')
                .where('date', isEqualTo: Timestamp.fromDate(selectedDate))
                .where('available', isEqualTo: true)
                .orderBy('start_time')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text('No available slots for this date',
                                   style: TextStyle(color: Colors.grey[600])),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    TimeSlot slot = TimeSlot.fromFirestore(
                        snapshot.data!.docs[index], widget.venue.id);
                    return TimeSlotCard(
                      slot: slot,
                      onBook: () => _navigateToBooking(slot),
                    );
                  },
                  childCount: snapshot.data!.docs.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _navigateToBooking(TimeSlot slot) {
    Navigator.push(context,
      MaterialPageRoute(builder: (_) => BookingScreen(venue: widget.venue, slot: slot)));
  }
}
```

### Day 4-5: Booking Creation Flow

**Booking Screen** (`lib/screens/booking_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../models/venue.dart';
import '../models/time_slot.dart';
import 'booking_confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final Venue venue;
  final TimeSlot slot;

  BookingScreen({required this.venue, required this.slot});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int partySize = 2;
  String paymentMethod = 'cash';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Slot'),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Venue Info
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.venue.name,
                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('${DateFormat('EEEE, MMM d').format(widget.slot.date)}'),
                    Text('${widget.slot.startTime} - ${widget.slot.endTime}'),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('${widget.slot.discount}% OFF',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.bold,
                               color: Colors.green[600],
                             )),
                        SizedBox(width: 8),
                        Text('${widget.slot.originalPrice.toStringAsFixed(0)} MAD',
                             style: TextStyle(
                               decoration: TextDecoration.lineThrough,
                               color: Colors.grey[600],
                             )),
                        SizedBox(width: 4),
                        Text('${widget.slot.discountedPrice.toStringAsFixed(0)} MAD',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.bold,
                             )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Party Size
            Text('Party Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: partySize > 1 ? () => setState(() => partySize--) : null,
                  icon: Icon(Icons.remove_circle_outline),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('$partySize people', style: TextStyle(fontSize: 16)),
                ),
                IconButton(
                  onPressed: partySize < widget.slot.capacity 
                      ? () => setState(() => partySize++) 
                      : null,
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Payment Method
            Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            RadioListTile<String>(
              title: Text('Cash on Arrival'),
              subtitle: Text('Pay when you arrive at the venue'),
              value: 'cash',
              groupValue: paymentMethod,
              onChanged: (value) => setState(() => paymentMethod = value!),
            ),
            RadioListTile<String>(
              title: Text('Credit Card'),
              subtitle: Text('Pay now with credit card'),
              value: 'card',
              groupValue: paymentMethod,
              onChanged: (value) => setState(() => paymentMethod = value!),
            ),

            Spacer(),

            // Total & Book Button
            Card(
              color: Colors.green[50],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total for $partySize people'),
                        Text('${(widget.slot.discountedPrice * partySize).toStringAsFixed(0)} MAD',
                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('You save', style: TextStyle(color: Colors.green[600])),
                        Text('${(widget.slot.savings * partySize).toStringAsFixed(0)} MAD',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.bold,
                               color: Colors.green[600],
                             )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Confirm Booking',
                           style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBooking() async {
    setState(() => isLoading = true);
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Create booking
      DocumentReference bookingRef = await FirebaseFirestore.instance
          .collection('bookings')
          .add({
        'user_id': user.uid,
        'venue_id': widget.venue.id,
        'slot_id': widget.slot.id,
        'venue_name': widget.venue.name,
        'date': Timestamp.fromDate(widget.slot.date),
        'start_time': widget.slot.startTime,
        'end_time': widget.slot.endTime,
        'party_size': partySize,
        'original_price': widget.slot.originalPrice,
        'discounted_price': widget.slot.discountedPrice,
        'total_amount': widget.slot.discountedPrice * partySize,
        'savings': widget.slot.savings * partySize,
        'discount_percentage': widget.slot.discount,
        'payment_method': paymentMethod,
        'status': 'confirmed',
        'created_at': FieldValue.serverTimestamp(),
      });

      // Navigate to confirmation
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => BookingConfirmationScreen(bookingId: bookingRef.id)));

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed. Please try again.')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }
}
```

### Day 6-7: Booking Confirmation

**Booking Confirmation Screen** (`lib/screens/booking_confirmation_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String bookingId;

  BookingConfirmationScreen({required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmed'),
        backgroundColor: Colors.green[600],
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('bookings').doc(bookingId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> booking = snapshot.data!.data() as Map<String, dynamic>;
          DateTime date = (booking['date'] as Timestamp).toDate();

          return Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green[600], size: 100),
                SizedBox(height: 24),
                
                Text('Booking Confirmed!',
                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Your table is reserved',
                     style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                SizedBox(height: 32),
                
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildDetailRow('Venue', booking['venue_name']),
                        _buildDetailRow('Date', DateFormat('EEEE, MMM d, yyyy').format(date)),
                        _buildDetailRow('Time', '${booking['start_time']} - ${booking['end_time']}'),
                        _buildDetailRow('Party Size', '${booking['party_size']} people'),
                        _buildDetailRow('Discount', '${booking['discount_percentage']}% OFF'),
                        Divider(),
                        _buildDetailRow('Total Amount', '${booking['total_amount'].toStringAsFixed(0)} MAD',
                                       isTotal: true),
                        _buildDetailRow('You Saved', '${booking['savings'].toStringAsFixed(0)} MAD',
                                       isGreen: true),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[600]),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Payment: ${booking['payment_method'] == 'cash' ? 'Cash on Arrival' : 'Paid'}',
                                 style: TextStyle(fontWeight: FontWeight.w600)),
                            if (booking['payment_method'] == 'cash')
                              Text('Please pay when you arrive at the venue',
                                   style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                      (route) => false,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Back to Home',
                                 style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false, bool isGreen = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          )),
          Text(value, style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal || isGreen ? FontWeight.bold : FontWeight.normal,
            color: isGreen ? Colors.green[600] : Colors.black,
          )),
        ],
      ),
    );
  }
}
```

---

## Week 3: Essential Features

### Day 1-2: User Booking History

**Booking History Screen** (`lib/screens/booking_history_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BookingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        backgroundColor: Colors.green[600],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('user_id', isEqualTo: user?.uid)
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No bookings yet',
                       style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                  SizedBox(height: 8),
                  Text('Start exploring venues and make your first booking!',
                       textAlign: TextAlign.center,
                       style: TextStyle(color: Colors.grey[500])),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> booking = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              DateTime date = (booking['date'] as Timestamp).toDate();
              
              return Card(
                margin: EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(booking['venue_name'],
                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          _buildStatusChip(booking['status']),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('${DateFormat('EEEE, MMM d').format(date)} • ${booking['start_time']} - ${booking['end_time']}'),
                      Text('${booking['party_size']} people'),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total: ${booking['total_amount'].toStringAsFixed(0)} MAD',
                               style: TextStyle(fontWeight: FontWeight.w600)),
                          Text('Saved: ${booking['savings'].toStringAsFixed(0)} MAD',
                               style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'confirmed':
        color = Colors.green;
        break;
      case 'completed':
        color = Colors.blue;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(status.toUpperCase(),
                   style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
```

### Day 3-4: Basic Venue Management

**Venue Owner Dashboard** (`lib/screens/venue_owner_screen.dart`)
```dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class VenueOwnerScreen extends StatefulWidget {
  @override
  _VenueOwnerScreenState createState() => _VenueOwnerScreenState();
}

class _VenueOwnerScreenState extends State<VenueOwnerScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venue Dashboard'),
        backgroundColor: Colors.green[600],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Bookings'),
            Tab(text: 'Time Slots'),
            Tab(text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsTab(),
          _buildTimeSlotsTab(),
          _buildAnalyticsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTimeSlotDialog,
        backgroundColor: Colors.green[600],
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBookingsTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('venue_id', isEqualTo: 'your_venue_id') // Replace with actual venue ID
          .orderBy('created_at', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> booking = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            DateTime date = (booking['date'] as Timestamp).toDate();
            
            return Card(
              child: ListTile(
                title: Text('${booking['party_size']} people'),
                subtitle: Text('${DateFormat('MMM d, HH:mm').format(date)} • ${booking['start_time']}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${booking['total_amount'].toStringAsFixed(0)} MAD',
                         style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(booking['status'], style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimeSlotsTab() {
    return Center(child: Text('Time Slots Management'));
  }

  Widget _buildAnalyticsTab() {
    return Center(child: Text('Analytics Dashboard'));
  }

  void _showAddTimeSlotDialog() {
    // Implementation for adding time slots
  }
}
```

### Day 5-7: Push Notifications

**Notification Setup** (`lib/services/notification_service.dart`)
```dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request permissions
    NotificationSettings settings = await _messaging.requestPermission();
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    
    await _localNotifications.initialize(initializationSettings);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });
  }

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'deadhour_channel',
      'DeadHour Notifications',
      channelDescription: 'Notifications for booking confirmations and deals',
      importance: Importance.max,
      priority: Priority.high,
    );
    
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    await _localNotifications.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: \${message.messageId}");
}
```

---

## Week 4: Polish & Launch

### Day 1-3: UI Polish & Bug Fixes

**Key UI Components**

**Venue Card Widget** (`lib/widgets/venue_card.dart`)
```dart
import 'package:flutter/material.dart';
import '../models/venue.dart';

class VenueCard extends StatelessWidget {
  final Venue venue;
  final VoidCallback? onTap;

  VenueCard({required this.venue, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Venue Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: venue.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(venue.imageUrl!, fit: BoxFit.cover),
                      )
                    : Icon(Icons.restaurant, color: Colors.green[600], size: 30),
              ),
              SizedBox(width: 16),
              
              // Venue Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(venue.name,
                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(venue.category,
                         style: TextStyle(color: Colors.grey[600])),
                    SizedBox(height: 4),
                    Text(venue.description,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  ],
                ),
              ),
              
              // Action Indicator
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Time Slot Card Widget** (`lib/widgets/time_slot_card.dart`)
```dart
import 'package:flutter/material.dart';
import '../models/time_slot.dart';

class TimeSlotCard extends StatelessWidget {
  final TimeSlot slot;
  final VoidCallback? onBook;

  TimeSlotCard({required this.slot, this.onBook});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Time Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${slot.startTime} - ${slot.endTime}',
                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('${slot.capacity} seats available'),
                ],
              ),
            ),
            
            // Discount Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('${slot.discount}% OFF',
                                 style: TextStyle(
                                   color: Colors.green[700],
                                   fontWeight: FontWeight.bold,
                                 )),
                  ),
                  SizedBox(height: 4),
                  Text('${slot.discountedPrice.toStringAsFixed(0)} MAD',
                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('was ${slot.originalPrice.toStringAsFixed(0)}',
                       style: TextStyle(
                         fontSize: 12,
                         decoration: TextDecoration.lineThrough,
                         color: Colors.grey[600],
                       )),
                ],
              ),
            ),
            
            // Book Button
            ElevatedButton(
              onPressed: onBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Book', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Day 4-5: Add Sample Venues & Test Data

**Sample Data Generator** (`lib/utils/sample_data.dart`)
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class SampleDataGenerator {
  static Future<void> generateSampleVenues() async {
    final venues = [
      {
        'name': 'Café Central',
        'category': 'café',
        'phone': '+212522123456',
        'description': 'Cozy café in the heart of Casablanca',
        'location': GeoPoint(33.5731, -7.5898),
        'is_active': true,
        'created_at': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Restaurant Atlas',
        'category': 'restaurant',
        'phone': '+212522654321',
        'description': 'Authentic Moroccan cuisine with modern twist',
        'location': GeoPoint(33.5892, -7.6036),
        'is_active': true,
        'created_at': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Café Maure Hassan II',
        'category': 'café',
        'phone': '+212522789012',
        'description': 'Traditional mint tea overlooking the mosque',
        'location': GeoPoint(33.5952, -7.6162),
        'is_active': true,
        'created_at': FieldValue.serverTimestamp(),
      },
      // Add 20+ more venues here
    ];

    for (var venue in venues) {
      DocumentReference venueRef = await FirebaseFirestore.instance
          .collection('venues')
          .add(venue);
      
      // Add sample time slots for each venue
      await _generateTimeSlots(venueRef.id);
    }
  }

  static Future<void> _generateTimeSlots(String venueId) async {
    final timeSlots = [
      {
        'date': Timestamp.fromDate(DateTime.now().add(Duration(days: 0))),
        'start_time': '14:30',
        'end_time': '16:00',
        'capacity': 20,
        'discount': 40,
        'available': true,
        'original_price': 80.0,
      },
      {
        'date': Timestamp.fromDate(DateTime.now().add(Duration(days: 0))),
        'start_time': '21:00',
        'end_time': '22:30',
        'capacity': 15,
        'discount': 25,
        'available': true,
        'original_price': 120.0,
      },
      // Add more slots for next 7 days
    ];

    for (var slot in timeSlots) {
      await FirebaseFirestore.instance
          .collection('venues')
          .doc(venueId)
          .collection('time_slots')
          .add(slot);
    }
  }
}
```

### Day 6-7: Deploy to App Stores

**Android Build & Deploy**
```bash
# Build release APK
flutter build apk --release

# Build App Bundle for Play Store
flutter build appbundle --release

# Upload to Google Play Console
# Follow Google Play Console upload process
```

**App Store Listing Preparation**
- App screenshots (home, venue detail, booking flow)
- App description focusing on savings and convenience
- Keywords: restaurant deals, café discounts, off-peak dining, Morocco
- Privacy policy and terms of service

---

## Testing & Quality Assurance

### Testing Checklist

**Functional Testing**
- [ ] User registration and login
- [ ] Venue listing and search
- [ ] Booking flow end-to-end
- [ ] Payment method selection
- [ ] Booking confirmation and history
- [ ] Push notifications

**UI/UX Testing**
- [ ] App works on different screen sizes
- [ ] Loading states and error handling
- [ ] Offline behavior
- [ ] Arabic text support (if applicable)

**Performance Testing**
- [ ] App launch time < 3 seconds
- [ ] Venue listing loads < 2 seconds
- [ ] Booking creation < 5 seconds
- [ ] Memory usage optimized

### Bug Tracking & Resolution

**Common Issues & Solutions**
1. **Firebase connection issues**: Check network permissions
2. **Location not working**: Verify location permissions
3. **Booking not saving**: Check Firebase security rules
4. **Images not loading**: Implement placeholder images

---

## Launch Strategy

### Soft Launch (Week 4)
1. **Internal Testing**: Team and friends testing
2. **5-10 Partner Venues**: Manual onboarding
3. **50+ Test Users**: Gather initial feedback
4. **Bug Fixes**: Address critical issues

### Public Launch (Week 5+)
1. **App Store Release**: Android first, iOS follow
2. **Marketing Campaign**: Social media announcement
3. **Venue Onboarding**: Scale to 50+ venues
4. **User Acquisition**: Referral programs, local PR

### Success Metrics
- **Week 1**: 100+ app downloads
- **Week 2**: 50+ successful bookings
- **Week 4**: 500+ registered users
- **Month 2**: 1,000+ monthly bookings

---

## Post-Launch Iteration

### Analytics Setup
```dart
// Track key events
FirebaseAnalytics.instance.logEvent(
  name: 'booking_completed',
  parameters: {
    'venue_id': venueId,
    'booking_value': totalAmount,
    'discount_percentage': discount,
  },
);
```

### Feature Prioritization (Post-MVP)
1. **Push notifications** for deal alerts
2. **Review system** for venues
3. **Advanced search** and filtering
4. **Payment integration** beyond cash
5. **Loyalty program** for frequent users

### Scaling Preparation
- Monitor Firebase usage and costs
- Plan migration to production backend if needed
- Prepare for venue onboarding scaling
- Build customer support processes

---

## Conclusion

This guide provides everything needed to build and launch DeadHour MVP in 4 weeks. Focus on core functionality first, gather user feedback, then iterate based on real usage data.

**Key Success Factors:**
✅ **Start simple** - Core booking flow only  
✅ **Use fake data** initially - Prove concept fast  
✅ **Focus on UX** - Smooth, intuitive experience  
✅ **Test thoroughly** - Quality over features  
✅ **Launch quickly** - Get to market, then improve  

The MVP will demonstrate market demand and provide foundation for investor funding and team scaling.