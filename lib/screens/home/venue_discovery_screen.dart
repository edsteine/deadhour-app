import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../models/venue.dart';
import '../../widgets/common/enhanced_app_bar.dart';

class VenueDiscoveryScreen extends StatefulWidget {
  const VenueDiscoveryScreen({super.key});

  @override
  State<VenueDiscoveryScreen> createState() => _VenueDiscoveryScreenState();
}

class _VenueDiscoveryScreenState extends State<VenueDiscoveryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'all';
  String _selectedCity = 'all';
  String _sortBy = 'rating';
  bool _showFilters = false;
  double _maxDistance = 10.0;
  bool _openNowOnly = false;
  String _priceRange = 'all';

  final List<Map<String, dynamic>> _categories = [
    {'id': 'all', 'name': 'All Venues', 'icon': '🏢'},
    {'id': 'food', 'name': 'Food & Dining', 'icon': '🍕'},
    {'id': 'entertainment', 'name': 'Entertainment', 'icon': '🎮'},
    {'id': 'wellness', 'name': 'Wellness', 'icon': '💆'},
    {'id': 'sports', 'name': 'Sports', 'icon': '⚽'},
    {'id': 'guide', 'name': 'Tourism', 'icon': '🌍'},
    {'id': 'family', 'name': 'Family', 'icon': '👨‍👩‍👧‍👦'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Venue> get _filteredVenues {
    var venues = MockData.venues;

    if (_selectedCategory != 'all') {
      venues = venues.where((venue) => venue.category == _selectedCategory).toList();
    }

    if (_selectedCity != 'all') {
      venues = venues.where((venue) => venue.city == _selectedCity).toList();
    }

    if (_openNowOnly) {
      venues = venues.where((venue) => venue.isOpen).toList();
    }

    if (_priceRange != 'all') {
      venues = venues.where((venue) => venue.priceRange == _priceRange).toList();
    }

    switch (_sortBy) {
      case 'rating':
        venues.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'distance':
        venues.sort((a, b) => a.id.compareTo(b.id));
        break;
      case 'newest':
        venues.sort((a, b) => (b.joinedDate ?? DateTime.now()).compareTo(a.joinedDate ?? DateTime.now()));
        break;
      case 'deals':
        venues.sort((a, b) => b.id.compareTo(a.id));
        break;
    }

    return venues;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const EnhancedAppBar(
        title: 'Discover Venues',
        subtitle: 'Find amazing places around Morocco',
        showBackButton: true,
        showGradient: true,
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildTabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVenuesTab(),
                _buildMapTab(),
                _buildNearbyTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search venues, dishes, activities...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(
                  _showFilters ? Icons.filter_list : Icons.tune,
                  color: _showFilters ? AppTheme.moroccoGreen : null,
                ),
                onPressed: () {
                  setState(() {
                    _showFilters = !_showFilters;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          if (_showFilters) ...[
            const SizedBox(height: 16),
            _buildFiltersRow(),
          ],
        ],
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
                items: ['all', 'Marrakech', 'Casablanca', 'Fez', 'Rabat', 'Tangier']
                    .map((city) => DropdownMenuItem(
                          value: city,
                          child: Text(city == 'all' ? 'All Cities' : city),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _sortBy,
                decoration: const InputDecoration(
                  labelText: 'Sort by',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'rating', child: Text('Rating')),
                  DropdownMenuItem(value: 'distance', child: Text('Distance')),
                  DropdownMenuItem(value: 'newest', child: Text('Newest')),
                  DropdownMenuItem(value: 'deals', child: Text('Best Deals')),
                ],
                onChanged: (value) {
                  setState(() {
                    _sortBy = value!;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                title: const Text('Open now'),
                value: _openNowOnly,
                onChanged: (value) {
                  setState(() {
                    _openNowOnly = value!;
                  });
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _priceRange,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('All Prices')),
                  DropdownMenuItem(value: '€', child: Text('€ - Budget')),
                  DropdownMenuItem(value: '€€', child: Text('€€ - Moderate')),
                  DropdownMenuItem(value: '€€€', child: Text('€€€ - Premium')),
                ],
                onChanged: (value) {
                  setState(() {
                    _priceRange = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppTheme.moroccoGreen,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'List View', icon: Icon(Icons.list)),
          Tab(text: 'Map View', icon: Icon(Icons.map)),
          Tab(text: 'Nearby', icon: Icon(Icons.near_me)),
        ],
      ),
    );
  }

  Widget _buildVenuesTab() {
    return Column(
      children: [
        _buildCategoryFilter(),
        _buildResultsHeader(),
        Expanded(child: _buildVenuesList()),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category['id'];

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category['icon'] as String, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(category['name'] as String, style: const TextStyle(fontSize: 12)),
                ],
              ),
              selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category['id'] as String;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_filteredVenues.length} venues found',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          TextButton.icon(
            onPressed: _showFilterBottomSheet,
            icon: const Icon(Icons.tune, size: 16),
            label: const Text('More Filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildVenuesList() {
    final venues = _filteredVenues;

    if (venues.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: venues.length,
      itemBuilder: (context, index) {
        return _buildVenueCard(venues[index]);
      },
    );
  }

  Widget _buildVenueCard(Venue venue) {
    final hasActiveDeals = MockData.deals
        .where((deal) => deal.venueId == venue.id && deal.isValid)
        .isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showVenueDetails(venue),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    venue.imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 160,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
                ),
                if (hasActiveDeals)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'DEAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: venue.isOpen ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      venue.openingStatus,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(venue.categoryIcon, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venue.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              venue.categoryName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.moroccoGreen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${venue.rating}',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Text(
                            '${venue.reviewCount} reviews',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${venue.address}, ${venue.city}',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        venue.priceRange,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    venue.description,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      if (venue.isHalal) _buildAmenityChip('Halal', Icons.restaurant),
                      if (venue.hasWifi) _buildAmenityChip('WiFi', Icons.wifi),
                      if (venue.acceptsCards) _buildAmenityChip('Cards', Icons.credit_card),
                      if (venue.isVerified) _buildAmenityChip('Verified', Icons.verified),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _viewVenueDetails(venue),
                          icon: const Icon(Icons.info, size: 16),
                          label: const Text('Details'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _bookVenue(venue),
                          icon: const Icon(Icons.book_online, size: 16),
                          label: Text(hasActiveDeals ? 'Book Deal' : 'Book Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: hasActiveDeals ? Colors.red : AppTheme.moroccoGreen,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenityChip(String label, IconData icon) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildMapTab() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Interactive Map View',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Coming Soon - View venues on an interactive map',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyTab() {
    final nearbyVenues = _filteredVenues.take(5).toList();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.moroccoGreen, AppTheme.moroccoGold],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Venues Near You',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Based on your current location',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: nearbyVenues.length,
            itemBuilder: (context, index) {
              final venue = nearbyVenues[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(venue.imageUrl),
                  ),
                  title: Text(venue.name),
                  subtitle: Text('${venue.categoryName} • ${venue.city}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          Text('${venue.rating}'),
                        ],
                      ),
                      const Text('2.3 km', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  onTap: () => _showVenueDetails(venue),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No venues found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search criteria',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Advanced Filters',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Distance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Slider(
                        value: _maxDistance,
                        min: 1,
                        max: 50,
                        divisions: 49,
                        label: '${_maxDistance.round()} km',
                        onChanged: (value) {
                          setState(() {
                            _maxDistance = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Amenities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      CheckboxListTile(
                        title: const Text('Halal Food'),
                        value: false,
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        title: const Text('WiFi Available'),
                        value: false,
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        title: const Text('Card Payment'),
                        value: false,
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        title: const Text('Verified Venue'),
                        value: false,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVenueDetails(Venue venue) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    venue.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(venue.categoryIcon, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            venue.name,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            venue.categoryName,
                            style: const TextStyle(fontSize: 16, color: AppTheme.moroccoGreen),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text('${venue.rating}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text('${venue.reviewCount} reviews'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(venue.description, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(child: Text('${venue.address}, ${venue.city}')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(venue.phone),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Operating Hours', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...venue.operatingHours.entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(entry.key.capitalize(), style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text(entry.value),
                    ],
                  ),
                )),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _bookVenue(venue);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.moroccoGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Book Now', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _viewVenueDetails(Venue venue) {
    _showVenueDetails(venue);
  }

  void _bookVenue(Venue venue) {
    final deals = MockData.deals.where((deal) => deal.venueId == venue.id && deal.isValid).toList();
    
    if (deals.isNotEmpty) {
      _showDealBookingDialog(venue, deals.first);
    } else {
      _showRegularBookingDialog(venue);
    }
  }

  void _showDealBookingDialog(Venue venue, dynamic deal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book ${deal.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('At ${venue.name}'),
            const SizedBox(height: 8),
            Text('Original Price: ${deal.originalPrice.toInt()} MAD'),
            Text(
              'Deal Price: ${deal.discountedPrice.toInt()} MAD',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.moroccoGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text('${deal.availableSpots} spots left'),
            Text('Valid until: ${deal.timeLeftDisplay}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Deal booked successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Book Deal'),
          ),
        ],
      ),
    );
  }

  void _showRegularBookingDialog(Venue venue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book at ${venue.name}'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Number of people',
                hintText: 'How many people?',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Preferred date & time',
                hintText: 'When would you like to visit?',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Special requests',
                hintText: 'Any special requirements?',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking request sent! We\'ll contact you soon.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}