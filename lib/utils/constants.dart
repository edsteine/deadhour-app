class AppConstants {
  // App Information
  static const String appName = 'DeadHour Morocco';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Morocco\'s first social venue discovery platform';
  
  // Morocco Cities
  static const List<String> moroccoCities = [
    'Casablanca',
    'Rabat',
    'Marrakech',
    'Fez',
    'Tangier',
    'Agadir',
    'Meknes',
    'Oujda',
    'Kenitra',
    'Tetouan',
  ];
  
  // Languages
  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'ar', 'name': 'العربية', 'englishName': 'Arabic'},
    {'code': 'fr', 'name': 'Français', 'englishName': 'French'},
    {'code': 'en', 'name': 'English', 'englishName': 'English'},
  ];
  
  // Prayer Times (Sample for Casablanca)
  static const List<Map<String, String>> prayerTimes = [
    {'name': 'Fajr', 'time': '06:18', 'arabic': 'الفجر'},
    {'name': 'Dhuhr', 'time': '13:42', 'arabic': 'الظهر'},
    {'name': 'Asr', 'time': '16:55', 'arabic': 'العصر'},
    {'name': 'Maghrib', 'time': '18:28', 'arabic': 'المغرب'},
    {'name': 'Isha', 'time': '19:54', 'arabic': 'العشاء'},
  ];
  
  // Business Categories
  static const List<Map<String, dynamic>> businessCategories = [
    {
      'id': 'food',
      'name': 'Food & Dining',
      'icon': '🍕',
      'color': 0xFFE67E22,
      'arabic': 'المطاعم والمقاهي',
      'french': 'Restaurants & Cafés'
    },
    {
      'id': 'entertainment',
      'name': 'Entertainment',
      'icon': '🎮',
      'color': 0xFF3498DB,
      'arabic': 'الترفيه',
      'french': 'Divertissement'
    },
    {
      'id': 'wellness',
      'name': 'Wellness & Spa',
      'icon': '💆',
      'color': 0xFF1ABC9C,
      'arabic': 'العافية والسبا',
      'french': 'Bien-être & Spa'
    },
    {
      'id': 'sports',
      'name': 'Sports & Fitness',
      'icon': '⚽',
      'color': 0xFF2ECC71,
      'arabic': 'الرياضة واللياقة',
      'french': 'Sports & Fitness'
    },
    {
      'id': 'tourism',
      'name': 'Tourism',
      'icon': '🌍',
      'color': 0xFFE91E63,
      'arabic': 'السياحة',
      'french': 'Tourisme'
    },
    {
      'id': 'family',
      'name': 'Family',
      'icon': '👨‍👩‍👧‍👦',
      'color': 0xFF9C27B0,
      'arabic': 'العائلة',
      'french': 'Famille'
    },
  ];
  
  // User Types
  static const List<Map<String, String>> userTypes = [
    {
      'id': 'local',
      'name': 'Local Resident',
      'icon': '🏠',
      'description': 'Find deals, join community rooms',
      'arabic': 'مقيم محلي',
      'french': 'Résident Local'
    },
    {
      'id': 'tourist',
      'name': 'Tourist/Visitor',
      'icon': '✈️',
      'description': 'Premium features, local expert connections',
      'arabic': 'سائح/زائر',
      'french': 'Touriste/Visiteur'
    },
    {
      'id': 'business',
      'name': 'Business Owner',
      'icon': '🏢',
      'description': 'Create deals, manage dead hours, track revenue',
      'arabic': 'صاحب عمل',
      'french': 'Propriétaire d\'entreprise'
    },
  ];
  
  // Deal Types
  static const List<Map<String, String>> dealTypes = [
    {
      'id': 'percentage',
      'name': 'Percentage Discount',
      'icon': '📉',
      'example': '35% OFF',
    },
    {
      'id': 'fixed_price',
      'name': 'Fixed Price',
      'icon': '💰',
      'example': 'Coffee + Pastry = 25 MAD',
    },
    {
      'id': 'bogo',
      'name': 'Buy One Get One',
      'icon': '🎁',
      'example': 'Buy 1 Get 1 Free',
    },
    {
      'id': 'combo',
      'name': 'Combo Deal',
      'icon': '🍽️',
      'example': 'Special menu combo',
    },
  ];
  
  // Currency
  static const String currency = 'MAD';
  static const String currencySymbol = 'MAD';
  
  // Commission Rate
  static const double commissionRate = 0.08; // 8%
  
  // Premium Pricing
  static const Map<String, double> premiumPricing = {
    'local_monthly': 75.0, // MAD
    'tourist_monthly': 450.0, // MAD (15 EUR)
    'local_yearly': 750.0, // MAD (save 17%)
    'tourist_yearly': 4500.0, // MAD (save 17%)
  };
  
  // API Endpoints (Mock)
  static const String baseUrl = 'https://api.deadhour.ma';
  static const String venuesEndpoint = '/venues';
  static const String dealsEndpoint = '/deals';
  static const String roomsEndpoint = '/rooms';
  static const String usersEndpoint = '/users';
  
  // Default Values
  static const int defaultPageSize = 20;
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxMessageLength = 500;
  static const int maxReviewLength = 1000;
  
  // Time Formats
  static const String timeFormat24 = 'HH:mm';
  static const String timeFormat12 = 'h:mm a';
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  
  // Morocco Phone Number Format
  static const String phonePrefix = '+212';
  static const String phonePattern = r'^(\+212|0)[5-7][0-9]{8}$';
  
  // Social Media Links
  static const Map<String, String> socialLinks = {
    'facebook': 'https://facebook.com/deadhour.ma',
    'instagram': 'https://instagram.com/deadhour.ma',
    'twitter': 'https://twitter.com/deadhour_ma',
    'linkedin': 'https://linkedin.com/company/deadhour',
  };
  
  // Support Information
  static const Map<String, String> supportInfo = {
    'email': 'hello@deadhour.ma',
    'phone': '+212 5XX-XXX-XXX',
    'website': 'www.deadhour.ma',
    'address': 'Casablanca, Morocco',
  };
}

// Design System Constants
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Specific spacing
  static const double cardPadding = 16.0;
  static const double screenPadding = 20.0;
  static const double sectionSpacing = 24.0;
  static const double itemSpacing = 12.0;
}

class AppBorderRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double circular = 50.0;
  
  // Specific radii
  static const double card = 12.0;
  static const double button = 8.0;
  static const double dialog = 16.0;
}

