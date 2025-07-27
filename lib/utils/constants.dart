class AppConstants {
  // App Information
  static const String appName = 'DeadHour Morocco';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'World\'s first dual-problem platform for Morocco';
  
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
      'id': 'guide',
      'name': 'Local Guide',
      'icon': '🌍',
      'color': 0xFFE91E63,
      'arabic': 'دليل محلي',
      'french': 'Guide Local'
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
  
  // User Types for registration
  static const List<Map<String, String>> userTypes = [
    {
      'id': 'consumer',
      'name': 'Consumer',
      'icon': '👤',
      'description': 'Discover deals and experiences',
      'arabic': 'مستهلك',
      'french': 'Consommateur'
    },
    {
      'id': 'business',
      'name': 'Business',
      'icon': '🏢',
      'description': 'Restaurant, café, or venue owner',
      'arabic': 'أعمال',
      'french': 'Entreprise'
    },
    {
      'id': 'guide',
      'name': 'Local Guide',
      'icon': '🌍',
      'description': 'Cultural and tourism expert',
      'arabic': 'دليل محلي',
      'french': 'Guide Local'
    },
  ];
  
  // Available Roles for Role Marketplace
  static const List<Map<String, String>> availableRoles = [
    {
      'id': 'business',
      'name': 'Business Role',
      'icon': '🏢',
      'price': '€30/month',
      'description': 'Venue management, deal creation, analytics dashboard',
      'arabic': 'دور الأعمال',
      'french': 'Rôle Entreprise'
    },
    {
      'id': 'guide',
      'name': 'Guide Role',
      'icon': '🌍',
      'price': '€20/month',
      'description': 'Local expertise, cultural guidance, tourism services',
      'arabic': 'دور الدليل',
      'french': 'Rôle Guide'
    },
    {
      'id': 'premium',
      'name': 'Premium Role',
      'icon': '⭐',
      'price': '€15/month',
      'description': 'Enhanced features, cross-Role analytics, priority support',
      'arabic': 'دور البريميوم',
      'french': 'Rôle Premium'
    },
  ];

  // Future Roles (infinite scalability)
  static const List<Map<String, String>> futureRoles = [
    {
      'id': 'driver',
      'name': 'Driver Role',
      'icon': '🚗',
      'price': '€25/month',
      'description': 'Transportation services, ride coordination',
      'arabic': 'دور السائق',
      'french': 'Rôle Chauffeur'
    },
    {
      'id': 'host',
      'name': 'Host Role',
      'icon': '🏠',
      'price': '€20/month',
      'description': 'Accommodation hosting, guest services',
      'arabic': 'دور المضيف',
      'french': 'Rôle Hôte'
    },
    {
      'id': 'chef',
      'name': 'Chef Role',
      'icon': '👨‍🍳',
      'price': '€30/month',
      'description': 'Private cooking, culinary experiences',
      'arabic': 'دور الطاهي',
      'french': 'Rôle Chef'
    },
    {
      'id': 'photographer',
      'name': 'Photographer Role',
      'icon': '📸',
      'price': '€15/month',
      'description': 'Photography services, visual content creation',
      'arabic': 'دور المصور',
      'french': 'Rôle Photographe'
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
  
  // Role Revenue Model (replacing commission-based model)
  static const double maxMonthlyRevenuePerUser = 65.0; // EUR (Business + Guide + Premium)
  static const double futureMaxMonthlyRevenue = 155.0; // EUR (all 7 Roles)
  
  // Role Pricing (Monthly)
  static const Map<String, double> rolePricing = {
    'business': 30.0, // EUR per month
    'guide': 20.0, // EUR per month
    'premium': 15.0, // EUR per month
    'driver': 25.0, // EUR per month (future)
    'host': 20.0, // EUR per month (future)
    'chef': 30.0, // EUR per month (future)
    'photographer': 15.0, // EUR per month (future)
  };

  // Role Yearly Pricing (save 17%)
  static const Map<String, double> rolePricingYearly = {
    'business': 300.0, // EUR per year
    'guide': 200.0, // EUR per year
    'premium': 150.0, // EUR per year
    'driver': 250.0, // EUR per year (future)
    'host': 200.0, // EUR per year (future)
    'chef': 300.0, // EUR per year (future)
    'photographer': 150.0, // EUR per year (future)
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