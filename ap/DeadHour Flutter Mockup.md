# DeadHour Flutter Mockup

A comprehensive Flutter mockup for the DeadHour platform - Morocco's premier social discovery app for finding deals, venues, and connecting with like-minded people during dead hours.

## 🇲🇦 About DeadHour

DeadHour solves the dual problem of:
1. **For Consumers**: Finding engaging activities and deals during typically quiet hours (2-6 PM)
2. **For Businesses**: Filling empty venues during low-traffic periods

### Key Features

- **Real-time Deal Discovery**: Find time-sensitive deals at nearby venues
- **Community Rooms**: Join location and interest-based chat rooms
- **Social Coordination**: Form groups for better discounts and shared experiences
- **Business Dashboard**: Comprehensive tools for venue owners to manage deals and analytics
- **Morocco-Centric**: Designed specifically for Moroccan culture, cities, and business practices

## 📱 App Structure

### Authentication Flow
- **Splash Screen**: Morocco-themed branding with animated logo
- **Onboarding**: Introduction to the dual-problem platform concept
- **User Type Selection**: Choose between Consumer and Business accounts
- **Login/Register**: Streamlined authentication with social options

### Consumer Experience
- **Home Screen**: Personalized deal feed with location-based recommendations
- **Deals Screen**: Advanced filtering and sorting for deal discovery
- **Community Rooms**: Location and interest-based social spaces
- **Room Chat**: Real-time messaging with deal alerts and group formation
- **Profile**: User preferences, history, and social connections

### Business Experience
- **Business Dashboard**: Comprehensive analytics and deal management
- **Deal Creation**: Easy-to-use deal posting with targeting options
- **Analytics**: Revenue tracking, customer insights, and performance metrics
- **Settings**: Business profile management and notification preferences

## 🏗️ Technical Architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── app.dart                  # App configuration
├── routes/
│   └── app_routes.dart       # Navigation routing
├── screens/
│   ├── auth/                 # Authentication screens
│   ├── home/                 # Main app screens
│   ├── community/            # Social features
│   ├── business/             # Business dashboard
│   └── profile/              # User profile
├── widgets/
│   └── common/               # Reusable UI components
├── models/                   # Data models
└── utils/                    # Utilities and constants
```

### Key Dependencies
```yaml
dependencies:
  flutter: ^3.16.0
  go_router: ^12.1.3          # Navigation
  provider: ^6.1.1            # State management
  http: ^1.1.0                # API calls
  shared_preferences: ^2.2.2  # Local storage
  geolocator: ^10.1.0         # Location services
  image_picker: ^1.0.4        # Media handling
```

## 🎨 Design System

### Color Palette (Morocco-Inspired)
- **Primary Green**: `#00A859` - Morocco's flag green
- **Gold Accent**: `#FFD700` - Traditional Moroccan gold
- **Red Accent**: `#E74C3C` - Morocco's flag red
- **Text Colors**: Dark gray hierarchy for readability

### Typography
- **Headlines**: Bold, clear hierarchy
- **Body Text**: Optimized for Arabic/French/English readability
- **UI Elements**: Consistent sizing and spacing

### Components
- **Cards**: Elevated with subtle shadows
- **Buttons**: Rounded corners with Morocco-inspired gradients
- **Navigation**: Animated bottom navigation with visual feedback
- **Loading States**: Custom Morocco-themed loading animations

## 🌍 Morocco-Specific Features

### Localization Ready
- **Multi-language Support**: Arabic, French, English
- **RTL Layout Support**: Proper right-to-left text rendering
- **Cultural Considerations**: Prayer times, local customs, business hours

### Location Integration
- **Major Cities**: Casablanca, Rabat, Marrakech, Fez, Tangier
- **Neighborhood Awareness**: District-level location targeting
- **Local Business Types**: Cafés, restaurants, hammams, souks

### Business Categories
- **Food & Dining**: Restaurants, cafés, fast food
- **Entertainment**: Cinemas, gaming centers, events
- **Wellness**: Spas, gyms, beauty salons
- **Sports**: Football clubs, tennis courts, swimming pools
- **Tourism**: Museums, tours, cultural sites
- **Family**: Kids' activities, family restaurants

## 📊 Mock Data

The app includes realistic mock data representing:
- **20+ Venues**: Across different categories and cities
- **50+ Deals**: Various discount types and time ranges
- **15+ Community Rooms**: Interest and location-based
- **User Profiles**: Diverse demographics and preferences
- **Business Analytics**: Revenue, customer, and performance data

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.16.0 or higher)
- Dart SDK (3.2.0 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd deadhour_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup
1. **Enable developer options** on your device
2. **Install Flutter and Dart extensions** in your IDE
3. **Configure emulators** for testing
4. **Set up hot reload** for faster development

## 📱 Screen Specifications

### Authentication Screens
- **Splash Screen**: Animated logo with Morocco colors
- **Onboarding**: 3-step introduction to platform benefits
- **User Type Selection**: Consumer vs Business account types
- **Login**: Email/phone with social login options
- **Registration**: Multi-step form with validation

### Main App Screens
- **Home**: Deal feed with location-based recommendations
- **Deals**: Filterable list with map integration
- **Community**: Room discovery with category filters
- **Profile**: User settings and activity history

### Social Features
- **Room Chat**: Real-time messaging with special message types
- **Deal Alerts**: Community-driven deal sharing
- **Group Formation**: Collaborative booking for better discounts

### Business Features
- **Dashboard**: Overview with key metrics and insights
- **Deal Management**: Create, edit, and monitor active deals
- **Analytics**: Revenue tracking and customer insights
- **Settings**: Business profile and notification management

## 🔧 Customization

### Theming
The app uses a comprehensive theming system:
- **Colors**: Easily customizable Morocco-inspired palette
- **Typography**: Scalable text styles with proper hierarchy
- **Components**: Consistent styling across all UI elements

### Configuration
Key configuration files:
- `lib/utils/theme.dart`: Color schemes and styling
- `lib/utils/constants.dart`: App-wide constants
- `lib/utils/mock_data.dart`: Sample data for development

## 🧪 Testing Strategy

### Unit Tests
- Model validation and data parsing
- Utility functions and helpers
- Business logic components

### Widget Tests
- Individual screen rendering
- User interaction flows
- State management validation

### Integration Tests
- End-to-end user journeys
- Navigation flow testing
- API integration validation

## 📈 Performance Considerations

### Optimization Techniques
- **Lazy Loading**: Efficient data loading for large lists
- **Image Caching**: Optimized image handling and storage
- **State Management**: Efficient state updates and rebuilds
- **Memory Management**: Proper disposal of resources

### Monitoring
- **Performance Metrics**: Frame rate and memory usage
- **User Analytics**: Screen time and interaction patterns
- **Error Tracking**: Crash reporting and error logging

## 🔒 Security Features

### Data Protection
- **Local Storage Encryption**: Secure user preferences
- **API Security**: Token-based authentication
- **Input Validation**: Comprehensive form validation
- **Privacy Controls**: User data management options

## 🌐 API Integration

### Endpoints Structure
```
/api/v1/
├── auth/           # Authentication endpoints
├── deals/          # Deal management
├── venues/         # Venue information
├── users/          # User profiles
├── rooms/          # Community rooms
└── analytics/      # Business analytics
```

### Data Models
- **User**: Profile, preferences, location
- **Venue**: Details, location, categories
- **Deal**: Pricing, timing, availability
- **Room**: Community spaces and members

## 📋 Development Roadmap

### Phase 1: MVP (Current)
- ✅ Core UI/UX implementation
- ✅ Authentication flow
- ✅ Basic deal discovery
- ✅ Community rooms
- ✅ Business dashboard

### Phase 2: Enhanced Features
- [ ] Real-time notifications
- [ ] Advanced filtering
- [ ] Social features expansion
- [ ] Payment integration

### Phase 3: Scale & Optimize
- [ ] Performance optimization
- [ ] Advanced analytics
- [ ] Multi-language support
- [ ] Offline capabilities

## 🤝 Contributing

### Code Standards
- **Dart Style Guide**: Follow official Dart conventions
- **Documentation**: Comprehensive code comments
- **Testing**: Maintain test coverage above 80%
- **Performance**: Profile and optimize critical paths

### Pull Request Process
1. Fork the repository
2. Create a feature branch
3. Implement changes with tests
4. Submit pull request with description

## 📄 License

This project is a mockup implementation for demonstration purposes. All design concepts and business logic are proprietary to the DeadHour platform concept.

## 📞 Support

For questions about this mockup implementation:
- **Technical Issues**: Check the troubleshooting section
- **Feature Requests**: Submit through the issue tracker
- **Business Inquiries**: Contact the DeadHour team

---

**Built with ❤️ for Morocco's vibrant social and business community**

