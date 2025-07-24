import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../widgets/common/enhanced_app_bar.dart';

class SocialDiscoveryScreen extends StatefulWidget {
  const SocialDiscoveryScreen({super.key});

  @override
  State<SocialDiscoveryScreen> createState() => _SocialDiscoveryScreenState();
}

class _SocialDiscoveryScreenState extends State<SocialDiscoveryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedInterest = 'all';
  final String _selectedCity = 'all';

  final List<Map<String, dynamic>> _socialInterests = [
    {'id': 'all', 'name': 'All Interests', 'icon': '🌟'},
    {'id': 'foodie', 'name': 'Foodie Adventures', 'icon': '🍽️'},
    {'id': 'culture', 'name': 'Cultural Explorer', 'icon': '🎭'},
    {'id': 'nightlife', 'name': 'Nightlife', 'icon': '🌙'},
    {'id': 'wellness', 'name': 'Wellness Journey', 'icon': '🧘'},
    {'id': 'adventure', 'name': 'Adventure Seeker', 'icon': '🏔️'},
    {'id': 'local', 'name': 'Local Secrets', 'icon': '🗝️'},
  ];

  final List<Map<String, dynamic>> _mockSocialExperiences = [
    {
      'id': '1',
      'title': 'Hidden Gems Food Tour',
      'category': 'foodie',
      'description': 'Discover authentic street food spots locals love',
      'host': {
        'name': 'Youssef Local',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 4.9,
        'isVerified': true,
      },
      'participants': 8,
      'maxParticipants': 12,
      'price': 180,
      'location': 'Marrakech Medina',
      'dateTime': 'Today 18:00',
      'duration': '3 hours',
      'tags': ['authentic', 'local-guide', 'small-group'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Multiple locations',
      'dealConnected': true,
    },
    {
      'id': '2',
      'title': 'Sunset Rooftop Social',
      'category': 'nightlife',
      'description': 'Meet fellow travelers at the best rooftop in Casa',
      'host': {
        'name': 'Sarah Expat',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 4.7,
        'isVerified': true,
      },
      'participants': 15,
      'maxParticipants': 25,
      'price': 120,
      'location': 'Casablanca Marina',
      'dateTime': 'Tomorrow 19:30',
      'duration': '4 hours',
      'tags': ['networking', 'rooftop', 'sunset'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Sky Lounge Casa',
      'dealConnected': true,
    },
    {
      'id': '3',
      'title': 'Traditional Hammam Experience',
      'category': 'wellness',
      'description': 'Authentic Moroccan spa ritual with local guide',
      'host': {
        'name': 'Aicha Wellness',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 5.0,
        'isVerified': true,
      },
      'participants': 6,
      'maxParticipants': 8,
      'price': 250,
      'location': 'Fez Medina',
      'dateTime': 'This Weekend',
      'duration': '2.5 hours',
      'tags': ['traditional', 'wellness', 'authentic'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Hammam Traditionnel',
      'dealConnected': false,
    },
    {
      'id': '4',
      'title': 'Atlas Mountains Day Trip',
      'category': 'adventure',
      'description': 'Small group hiking with Berber village visit',
      'host': {
        'name': 'Omar Mountain Guide',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 4.8,
        'isVerified': true,
      },
      'participants': 10,
      'maxParticipants': 16,
      'price': 380,
      'location': 'Imlil Village',
      'dateTime': 'Saturday 07:00',
      'duration': '8 hours',
      'tags': ['hiking', 'berber-culture', 'mountain'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Atlas Mountains',
      'dealConnected': true,
    },
    {
      'id': '5',
      'title': 'Local Coffee Culture Deep Dive',
      'category': 'culture',
      'description': 'Traditional coffee ceremony and cultural exchange',
      'host': {
        'name': 'Hassan Cultural Guide',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 4.9,
        'isVerified': true,
      },
      'participants': 4,
      'maxParticipants': 6,
      'price': 95,
      'location': 'Rabat Old Town',
      'dateTime': 'Today 15:00',
      'duration': '2 hours',
      'tags': ['coffee', 'cultural-exchange', 'intimate'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Traditional Coffee House',
      'dealConnected': true,
    },
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

  List<Map<String, dynamic>> get _filteredExperiences {
    var experiences = _mockSocialExperiences;

    if (_selectedInterest != 'all') {
      experiences = experiences.where((exp) => exp['category'] == _selectedInterest).toList();
    }

    if (_selectedCity != 'all') {
      experiences = experiences.where((exp) => 
        (exp['location'] as String).toLowerCase().contains(_selectedCity.toLowerCase())
      ).toList();
    }

    return experiences;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const EnhancedAppBar(
        title: 'Social Discovery',
        subtitle: 'Find authentic experiences through local connections',
        showBackButton: true,
        showGradient: true,
      ),
      body: Column(
        children: [
          _buildFiltersAndSearch(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildExperiencesTab(),
                _buildMyConnectionsTab(),
                _buildCreateExperienceTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewExperience,
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Host Experience'),
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
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
              hintText: 'Search experiences, hosts, locations...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showAdvancedFilters,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 16),
          
          // Interest Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _socialInterests.length,
              itemBuilder: (context, index) {
                final interest = _socialInterests[index];
                final isSelected = _selectedInterest == interest['id'];

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(interest['icon'] as String, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        Text(interest['name'] as String, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                    onSelected: (selected) {
                      setState(() {
                        _selectedInterest = interest['id'] as String;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppTheme.moroccoGreen,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'Discover'),
          Tab(text: 'My Network'),
          Tab(text: 'Host'),
        ],
      ),
    );
  }

  Widget _buildExperiencesTab() {
    return Column(
      children: [
        _buildStatsHeader(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _filteredExperiences.length,
            itemBuilder: (context, index) {
              return _buildExperienceCard(_filteredExperiences[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatsHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              '${_filteredExperiences.length}',
              'Experiences',
              Icons.explore,
              AppTheme.moroccoGreen,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              '127',
              'Active Hosts',
              Icons.people,
              AppTheme.moroccoGold,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              '89%',
              'Success Rate',
              Icons.star,
              Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> experience) {
    final host = experience['host'] as Map<String, dynamic>;
    final dealConnected = experience['dealConnected'] as bool;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _viewExperienceDetails(experience),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with deal badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    experience['images'][0] as String,
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
                if (dealConnected)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.moroccoGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'DEAL CONNECTED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
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
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${experience['participants']}/${experience['maxParticipants']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
                  // Title and category
                  Row(
                    children: [
                      Text(
                        _socialInterests.firstWhere(
                          (interest) => interest['id'] == experience['category'],
                          orElse: () => _socialInterests.first,
                        )['icon'] as String,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          experience['title'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${experience['price']} MAD',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    experience['description'] as String,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Host info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(host['avatar'] as String),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  host['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (host['isVerified'] as bool) ...[
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.verified,
                                    size: 12,
                                    color: AppTheme.moroccoGreen,
                                  ),
                                ],
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 12, color: Colors.amber),
                                const SizedBox(width: 2),
                                Text(
                                  '${host['rating']}',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.schedule, size: 12, color: Colors.grey),
                              const SizedBox(width: 2),
                              Text(
                                experience['duration'] as String,
                                style: const TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 12, color: Colors.grey),
                              const SizedBox(width: 2),
                              Text(
                                experience['location'] as String,
                                style: const TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: (experience['tags'] as List<String>).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.moroccoGreen,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 12),

                  // Date and action buttons
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience['dateTime'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (dealConnected)
                              const Text(
                                'Includes venue deal',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.moroccoGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () => _contactHost(experience),
                            child: const Text('Message', style: TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _joinExperience(experience),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.moroccoGreen,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Join', style: TextStyle(fontSize: 12)),
                          ),
                        ],
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

  Widget _buildMyConnectionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Connection Stats
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.moroccoGreen, AppTheme.moroccoGold],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Social Network',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildNetworkStat('23', 'Connections', Icons.people),
                    ),
                    Expanded(
                      child: _buildNetworkStat('8', 'Experiences', Icons.explore),
                    ),
                    Expanded(
                      child: _buildNetworkStat('4.9', 'Rating', Icons.star),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recent Connections
          const Text(
            'Recent Connections',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildConnectionCard('Sarah Expat', 'Rooftop Social Host', 4.8, 'Connected after joining sunset experience'),
          _buildConnectionCard('Hassan Guide', 'Cultural Expert', 4.9, 'Coffee culture experience leader'),
          _buildConnectionCard('Omar Mountain', 'Adventure Guide', 4.7, 'Atlas Mountains hiking guide'),

          const SizedBox(height: 24),

          // Upcoming Experiences
          const Text(
            'Your Upcoming Experiences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildUpcomingExperienceCard('Traditional Hammam', 'Saturday 14:00', 'Fez Medina', 250),
          _buildUpcomingExperienceCard('Atlas Day Trip', 'Sunday 07:00', 'Imlil Village', 380),
        ],
      ),
    );
  }

  Widget _buildCreateExperienceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Host Benefits
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[400]!, Colors.purple[600]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Become a Host',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Share your passion, meet amazing people, and earn money by hosting unique experiences',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _startHostApplication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple[600],
                  ),
                  child: const Text('Start Hosting'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Host Benefits
          const Text(
            'Why Host with DeadHour?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildBenefitCard(
            Icons.monetization_on,
            'Earn Good Money',
            'Set your own prices and keep 85% of earnings',
            AppTheme.moroccoGreen,
          ),

          _buildBenefitCard(
            Icons.people,
            'Meet Like-minded People',
            'Connect with travelers and locals who share your interests',
            AppTheme.moroccoGold,
          ),

          _buildBenefitCard(
            Icons.local_offer,
            'Connect with Venues',
            'Partner with local businesses for special deals and enhanced experiences',
            Colors.blue,
          ),

          _buildBenefitCard(
            Icons.support,
            'Full Support',
            'Marketing help, insurance coverage, and 24/7 customer support',
            Colors.green,
          ),

          const SizedBox(height: 24),

          // Experience Ideas
          const Text(
            'Popular Experience Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildCategoryCard('🍽️', 'Food Tours', 'Share local cuisine'),
              _buildCategoryCard('🎭', 'Cultural', 'Traditional experiences'),
              _buildCategoryCard('🏔️', 'Adventure', 'Outdoor activities'),
              _buildCategoryCard('🧘', 'Wellness', 'Relaxation & health'),
              _buildCategoryCard('🌙', 'Nightlife', 'Evening experiences'),
              _buildCategoryCard('🗝️', 'Hidden Gems', 'Secret local spots'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionCard(String name, String role, double rating, String connection) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('https://via.placeholder.com/50'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  connection,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text('$rating'),
                ],
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => _messageConnection(name),
                child: const Text('Message', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingExperienceCard(String title, String dateTime, String location, int price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.event,
              color: AppTheme.moroccoGreen,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dateTime,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$price MAD',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGreen,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _viewExperienceDetails({}),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.moroccoGreen,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(80, 32),
                ),
                child: const Text('View', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitCard(IconData icon, String title, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String emoji, String title, String description) {
    return GestureDetector(
      onTap: () => _exploreCategory(title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Action Methods
  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Advanced Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Price Range'),
            RangeSlider(
              values: const RangeValues(50, 300),
              min: 0,
              max: 500,
              onChanged: (values) {},
            ),
            const SizedBox(height: 16),
            const Text('Group Size'),
            DropdownButton<String>(
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'small', child: Text('Small (2-8 people)')),
                DropdownMenuItem(value: 'medium', child: Text('Medium (8-15 people)')),
                DropdownMenuItem(value: 'large', child: Text('Large (15+ people)')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),
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
    );
  }

  void _viewExperienceDetails(Map<String, dynamic> experience) {
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
                const Text(
                  'Experience Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // Add detailed experience information here
                const SizedBox(height: 16),
                const Text('Full experience details would be shown here...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createNewExperience() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening experience creation wizard...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _contactHost(Map<String, dynamic> experience) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening chat with host...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _joinExperience(Map<String, dynamic> experience) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Join ${experience['title']}'),
        content: Text('Confirm booking for ${experience['price']} MAD?'),
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
                  content: Text('Successfully joined experience!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _startHostApplication() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting host application process...'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _messageConnection(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening chat with $name...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _exploreCategory(String category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exploring $category experiences...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }
}