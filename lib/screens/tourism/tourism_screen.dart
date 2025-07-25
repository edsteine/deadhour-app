import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../providers/role_toggle_provider.dart';
import '../../models/user.dart';
import '../home/main_navigation_screen.dart';

class TourismScreen extends ConsumerStatefulWidget {
  const TourismScreen({super.key});

  @override
  ConsumerState<TourismScreen> createState() => _TourismScreenState();
}

class _TourismScreenState extends ConsumerState<TourismScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCity = 'Casablanca';
  late final bool _isPremiumUser;

  final List<Tab> _tabs = [
    const Tab(text: 'Discover'),
    const Tab(text: 'Local Experts'),
    const Tab(text: 'Experiences'),
    const Tab(text: 'Cultural'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _isPremiumUser = ref.read(roleToggleProvider) == UserRole.premium;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeadHourAppBar(
        title: 'Explore Morocco',
        actions: [
          IconButton(
            onPressed: _showCitySelector,
            icon: const Icon(Icons.location_on),
          ),
          IconButton(
            onPressed: _showTourismMenu,
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tourism welcome banner
          _buildTourismWelcomeBanner(),

          // Tab bar
          TabBar(
            controller: _tabController,
            labelColor: AppTheme.moroccoGreen,
            unselectedLabelColor: AppTheme.secondaryText,
            indicatorColor: AppTheme.moroccoGreen,
            tabs: _tabs,
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDiscoverTab(),
                _buildLocalExpertsTab(),
                _buildExperiencesTab(),
                _buildCulturalTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "tourismExpertFAB",
        onPressed: _showExpertRequest,
        backgroundColor: AppColors.tourismCategory,
        icon: const Icon(Icons.person_add),
        label: const Text('Find Expert'),
      ),
    );
  }

  Widget _buildTourismWelcomeBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.tourismCategory,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.tourismCategory.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text('🧭', style: TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore Morocco',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Discover authentic experiences with local guides',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          if (!_isPremiumUser)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGold,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'UPGRADE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick discovery categories
          _buildSectionHeader('🎯 Quick Discovery'),
          const SizedBox(height: 12),
          _buildQuickDiscoveryGrid(),
          const SizedBox(height: 24),

          // Trending experiences
          _buildSectionHeader('🔥 Trending This Week'),
          const SizedBox(height: 12),
          _buildTrendingExperiences(),
          const SizedBox(height: 24),

          // Social Discovery Button
          _buildSocialDiscoveryButton(),
          const SizedBox(height: 24),

          // Tourist-friendly venues with deals
          _buildSectionHeader('🏪 Tourist-Friendly Deals'),
          const SizedBox(height: 12),
          _buildTouristFriendlyDeals(),
        ],
      ),
    );
  }

  Widget _buildLocalExpertsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expert matching section
          if (!_isPremiumUser) ...[
            _buildPremiumUpgradeCard(),
            const SizedBox(height: 16),
          ],

          _buildSectionHeader('🌟 Available Local Experts'),
          const SizedBox(height: 12),
          
          ...List.generate(5, (index) => _buildExpertCard(index)),
        ],
      ),
    );
  }

  Widget _buildExperiencesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('🎨 Authentic Experiences'),
          const SizedBox(height: 12),
          
          _buildExperienceCard(
            '🏺 Traditional Pottery Workshop',
            'Learn from master craftsmen in Fez medina',
            '2 hours • 45€ • English/French',
            Icons.handyman,
            Colors.orange,
          ),
          
          _buildExperienceCard(
            '🍽️ Home Cooking with Local Family',
            'Cook tagine and couscous in authentic setting',
            '3 hours • 35€ • All languages',
            Icons.home,
            Colors.green,
          ),
          
          _buildExperienceCard(
            '🕌 Spiritual Journey & Prayer Experience',
            'Respectful mosque visit with cultural guide',
            '90 min • 25€ • Modest dress required',
            Icons.mosque,
            Colors.blue,
          ),
          
          _buildExperienceCard(
            '🛒 Souk Navigation Masterclass',
            'Bargaining secrets and hidden shop discoveries',
            '2 hours • 30€ • Small groups only',
            Icons.shopping_bag,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildCulturalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cultural integration dashboard
          _buildCulturalDashboard(),
          
          const SizedBox(height: 24),
          
          _buildSectionHeader('📅 Cultural Calendar'),
          const SizedBox(height: 12),
          _buildCulturalEvents(),
          
          const SizedBox(height: 24),
          
          _buildSectionHeader('🧭 Cultural Tips'),
          const SizedBox(height: 12),
          _buildCulturalTips(),
        ],
      ),
    );
  }

  Widget _buildQuickDiscoveryGrid() {
    final categories = [
      {'icon': '🏛️', 'name': 'Historic Sites', 'count': '45'},
      {'icon': '🍽️', 'name': 'Food Tours', 'count': '28'},
      {'icon': '🛒', 'name': 'Souks & Markets', 'count': '12'},
      {'icon': '🎨', 'name': 'Art & Crafts', 'count': '34'},
      {'icon': '🌊', 'name': 'Beach & Coast', 'count': '18'},
      {'icon': '🏔️', 'name': 'Mountains', 'count': '22'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(category['icon']!, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                  category['name']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${category['count']} options',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrendingExperiences() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 250,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.tourismCategory.withValues(alpha: 0.3),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const Center(
                    child: Text('🕌', style: TextStyle(fontSize: 40)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hassan II Mosque Guide',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Professional guided tour with cultural insights',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' 4.9 • '),
                          Text('25€', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.tourismCategory,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTouristFriendlyDeals() {
    return Column(
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.tourismCategory.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.tourismCategory.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('☕', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rick\'s Café - 20% OFF',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Famous movie location café',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.language, size: 14, color: AppColors.success),
                        Text(' English menu', style: TextStyle(fontSize: 12)),
                        SizedBox(width: 8),
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        Text(' 4.7', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tourismCategory,
                      minimumSize: const Size(80, 32),
                    ),
                    child: const Text('Book', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(height: 4),
                  const Text('2.1km', style: TextStyle(fontSize: 10, color: AppTheme.secondaryText)),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPremiumUpgradeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.moroccoGold, Color(0xFFFFB300)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.workspace_premium, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Unlock Premium Tourism',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '''
• Personal local expert assigned
• Access to exclusive experiences
• 24/7 cultural support
• Premium community rooms
''',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: _showPremiumUpgrade,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.moroccoGold,
                ),
                child: const Text('Upgrade - 15€/month'),
              ),
              const Spacer(),
              const Text(
                '7-day free trial',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpertCard(int index) {
    final experts = [
      {'name': 'Samir Ben-Ali', 'city': 'Marrakech', 'rating': '4.9', 'languages': 'Arabic, French, English', 'specialty': 'Cultural Guide', 'avatar': '🧔'},
      {'name': 'Fatima El-Khoury', 'city': 'Fez', 'rating': '4.8', 'languages': 'Arabic, French', 'specialty': 'Traditional Crafts', 'avatar': '👩'},
      {'name': 'Omar Benjelloun', 'city': 'Casablanca', 'rating': '4.9', 'languages': 'Arabic, English, Spanish', 'specialty': 'Modern Culture', 'avatar': '👨'},
      {'name': 'Aicha Tamouh', 'city': 'Essaouira', 'rating': '4.7', 'languages': 'Arabic, French, German', 'specialty': 'Coastal Culture', 'avatar': '👩‍🦳'},
      {'name': 'Youssef Alami', 'city': 'Tangier', 'rating': '4.8', 'languages': 'Arabic, English, French', 'specialty': 'History & Architecture', 'avatar': '👨‍🎓'},
    ];

    final expert = experts[index % experts.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.tourismCategory.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(expert['avatar']!, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expert['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${expert['specialty']} • ${expert['city']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    Text(' ${expert['rating']} • '),
                    const Icon(Icons.language, size: 14, color: AppColors.info),
                    Expanded(
                      child: Text(
                        ' ${expert['languages']}',
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (_isPremiumUser) ...[
                ElevatedButton(
                  onPressed: () => context.push('/tourism/local-expert'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tourismCategory,
                    minimumSize: const Size(70, 32),
                  ),
                  child: const Text('Chat', style: TextStyle(fontSize: 12)),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.moroccoGold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Premium',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.moroccoGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 4),
              const Text('Online now', style: TextStyle(fontSize: 10, color: AppColors.success)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(String title, String description, String details, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
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
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              minimumSize: const Size(60, 32),
            ),
            child: const Text('Book', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildCulturalDashboard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.tourismCategory, Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.mosque, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'Cultural Dashboard - Casablanca',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Today - Thursday, March 15\nRegular day • No special events',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🕐 Prayer Schedule - Casablanca:',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const Text(
                  '✅ Fajr: 06:18 (Completed)\n✅ Dhuhr: 13:42 (Completed)\n⏰ Asr: 16:55 (in 1h 25min)\n🌅 Maghrib: 18:28\n🌙 Isha: 19:54',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '🎯 Smart Planning: Best activity window Now-16:30',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCulturalEvents() {
    final events = [
      {'date': 'March 20', 'event': 'Spring Equinox 🌸', 'description': 'Garden festivals begin'},
      {'date': 'April 10', 'event': 'Ramadan Begins 🌙', 'description': 'Special Iftar experiences'},
      {'date': 'May 15', 'event': 'Rose Festival', 'description': 'Kelaat M\'Gouna celebration'},
    ];

    return Column(
      children: events.map((event) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.tourismCategory.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                event['date']!.split(' ')[1],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['event']!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    event['description']!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildCulturalTips() {
    final tips = [
      {'icon': '🧭', 'tip': 'Dress modestly for old medina visits'},
      {'icon': '🤝', 'tip': 'Use right hand for greetings and eating'},
      {'icon': '💬', 'tip': '"Inshallah" means "God willing" - common phrase'},
      {'icon': '🛒', 'tip': 'Bargaining is expected in souks and markets'},
      {'icon': '🕌', 'tip': 'Remove shoes before entering mosques'},
    ];

    return Column(
      children: tips.map((tip) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.tourismCategory.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.tourismCategory.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Text(tip['icon']!, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                tip['tip']!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildSocialDiscoveryButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.moroccoGreen.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.people_outline, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Social Discovery Platform',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Connect with travelers, create experiences, and discover Morocco through authentic local connections.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/tourism/social-discovery'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.moroccoGreen,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.explore),
                  label: const Text(
                    'Explore Social Platform',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialFeature('🌍', 'Discover\nExperiences'),
              _buildSocialFeature('👥', 'Connect with\nTravelers'),
              _buildSocialFeature('🎯', 'Host Your Own\nExperiences'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialFeature(String emoji, String text) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.secondaryText,
      ),
    );
  }

  void _showCitySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select City',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...['Casablanca', 'Marrakech', 'Fez', 'Rabat', 'Tangier', 'Essaouira'].map((city) {
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(city),
                trailing: _selectedCity == city ? const Icon(Icons.check, color: AppColors.tourismCategory) : null,
                onTap: () {
                  setState(() => _selectedCity = city);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showTourismMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tourism Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.workspace_premium, color: AppTheme.moroccoGold),
              title: const Text('Upgrade to Premium'),
              onTap: () {
                Navigator.pop(context);
                _showPremiumUpgrade();
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Tourism Help'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Emergency Contacts'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showExpertRequest() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Find Local Expert'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isPremiumUser) ...[
              const Text('Premium feature - Connect with verified local experts for authentic Morocco experiences.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showPremiumUpgrade,
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.moroccoGold),
                child: const Text('Upgrade to Premium'),
              ),
            ] else ...[
              const Text('What type of local expert do you need?'),
              const SizedBox(height: 16),
              ...['Cultural Guide', 'Food Expert', 'Shopping Assistant', 'Historical Tours'].map((type) =>
                ListTile(
                  title: Text(type),
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/tourism/local-expert');
                  },
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showPremiumUpgrade() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.workspace_premium, color: AppTheme.moroccoGold),
            SizedBox(width: 8),
            Text('Tourism Premium'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unlock authentic Morocco for 15€/month:'),
            SizedBox(height: 12),
            Text('✅ Personal local expert assigned'),
            Text('✅ Exclusive premium experiences'),
            Text('✅ 24/7 cultural support & translation'),
            Text('✅ Access to premium community rooms'),
            Text('✅ Prayer-time smart planning'),
            Text('✅ Emergency assistance'),
            SizedBox(height: 16),
            Text('💎 7-day free trial included', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isPremiumUser = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Premium Tourism activated! Welcome to authentic Morocco 🇲🇦'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.moroccoGold),
            child: const Text('Start Free Trial'),
          ),
        ],
      ),
    );
  }
}