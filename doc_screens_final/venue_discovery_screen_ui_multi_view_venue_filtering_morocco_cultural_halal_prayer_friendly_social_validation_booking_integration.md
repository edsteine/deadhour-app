# VenueDiscoveryScreen

## Purpose
Primary venue discovery screen that enables users to find and filter Morocco venues by categories, location, cultural requirements, and special features with multiple viewing options (list, map, nearby).

## Features
- **Multi-View Display**: List, Map, and Nearby viewing options controlled by AppBar
- **Advanced Filtering**: Category, city, distance, price range, cultural filters
- **Cultural Integration**: Halal-only and prayer-friendly venue filtering
- **Social Validation**: Community activity indicators and social proof
- **Real-time Search**: Integration with advanced search service
- **Booking Integration**: Direct venue booking and group booking capabilities
- **Empty State Handling**: User-friendly no-results experience
- **Filter Management**: Clear active filters and reset functionality

## User Types
- **All Roles**: Consumer, Business, Guide, Premium - all users discover venues
- **Tourists**: Discover authentic Morocco venues with cultural considerations
- **Locals**: Find nearby venues and deals in their city
- **Cultural Users**: Filter by halal and prayer-friendly requirements

## Navigation
- **Persistent Screen**: Core part of home navigation flow
- **Venue Details**: Navigate to detailed venue information
- **Booking Flow**: Direct access to reservation system
- **Group Booking**: Social booking features for multiple users
- **External Control**: View updates from MainNavigationScreen AppBar filters

## Screen Category
**Discovery Screen** - Core venue discovery and booking conversion interface

## Integration Points

### Services Integration
- **AdvancedSearchService**: Comprehensive multi-criteria venue filtering
- **SocialValidationService**: Community activity and social proof indicators
- **AppNavigation**: Seamless navigation to venue details and booking flows

### Search & Filtering
- **Category Filtering**: Food, Entertainment, Wellness, Tourism, Sports, Family
- **Geographic Filtering**: City-based and distance radius filtering
- **Cultural Filtering**: Halal certification and prayer-friendly venues
- **Temporal Filtering**: Open now and operating hours consideration
- **Price Range**: Budget-based venue filtering
- **Sort Options**: Rating, distance, price, popularity sorting

### View Components
- **VenueCardWidget**: Individual venue display with social validation
- **VenueMapView**: Geographic venue visualization
- **VenueNearbyView**: Location-based venue discovery
- **VenueResultsHeader**: Search results summary and filter management
- **VenueEmptyState**: No-results user experience

### Booking Integration
- **BookingDialogs**: Modal booking interfaces for individual and group bookings
- **Venue Booking**: Single-user reservation flow
- **Group Booking**: Multi-user collaborative booking system
- **Social Booking**: Community-driven booking experiences

### Morocco Cultural Features
- **Halal Certification**: Filter venues by halal food and services
- **Prayer-Friendly**: Venues accommodating Islamic prayer requirements
- **Cultural Sensitivity**: Morocco-specific venue considerations
- **Local Context**: City-based discovery for major Morocco cities

### Business Model Support
- **Deal Discovery**: Find venues with active dead hours deals
- **Revenue Optimization**: Drive bookings during venue off-peak times
- **Commission Generation**: Booking conversions generate platform revenue
- **Community Validation**: Social proof increases booking confidence

### External Control Interface
- **View Switching**: External components can change display view
- **Filter Integration**: Coordinates with AppBar filter controls
- **Search Coordination**: Works with external search implementations