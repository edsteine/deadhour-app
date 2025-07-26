import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/theme.dart';
import '../../../models/room.dart';

class CreateRoomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final String selectedCity;

  const CreateRoomSheet({
    super.key,
    required this.scrollController,
    required this.selectedCity,
  });

  @override
  State<CreateRoomSheet> createState() => _CreateRoomSheetState();
}

class _CreateRoomSheetState extends State<CreateRoomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'food';
  String _selectedCity = 'Casablanca';
  bool _isPublic = true;
  bool _allowDeals = true;
  bool _isPrayerTimeAware = false;
  bool _isHalalOnly = false;
  bool _isPremiumOnly = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'food',
      'name': 'Food & Dining',
      'icon': '🍕',
      'description': 'Restaurants, cafés, and culinary experiences',
      'examples': ['Coffee meetups', 'Restaurant deals', 'Food tours', 'Cooking classes']
    },
    {
      'id': 'entertainment',
      'name': 'Entertainment',
      'icon': '🎮',
      'description': 'Movies, games, and fun activities',
      'examples': ['Gaming tournaments', 'Cinema groups', 'Escape rooms', 'Comedy shows']
    },
    {
      'id': 'wellness',
      'name': 'Wellness & Spa',
      'icon': '💆',
      'description': 'Health, fitness, and relaxation',
      'examples': ['Spa deals', 'Hammam sessions', 'Fitness groups', 'Yoga classes']
    },
    {
      'id': 'sports',
      'name': 'Sports & Fitness',
      'icon': '⚽',
      'description': 'Sports activities and fitness',
      'examples': ['Padel matches', 'Football teams', 'Gym buddies', 'Running groups']
    },
    {
      'id': 'tourism',
      'name': 'Tourism & Culture',
      'icon': '🌍',
      'description': 'Local experiences and cultural activities',
      'examples': ['City tours', 'Cultural events', 'Local guides', 'Historical sites']
    },
    {
      'id': 'family',
      'name': 'Family Fun',
      'icon': '👨‍👩‍👧‍👦',
      'description': 'Family-friendly activities and events',
      'examples': ['Kids activities', 'Family outings', 'Parent groups', 'Children events']
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.selectedCity;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategoryData = _categories.firstWhere(
      (cat) => cat['id'] == _selectedCategory,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: widget.scrollController,
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
              Row(
                children: [
                  Text(
                    selectedCategoryData['icon'] as String,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create New Room',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Build a community around ${selectedCategoryData['name']}',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category['id'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category['id'] as String;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? AppTheme.moroccoGreen : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected ? AppTheme.moroccoGreen.withValues(alpha: 0.1) : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              category['icon'] as String,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['name'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? AppTheme.moroccoGreen : null,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedCategoryData['description'] as String,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Popular room types:',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: (selectedCategoryData['examples'] as List<String>).map((example) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Text(
                            example,
                            style: const TextStyle(fontSize: 11),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Room Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Room Name *',
                  hintText: 'e.g., Coffee Lovers Casablanca',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City *',
                  border: OutlineInputBorder(),
                ),
                items: ['Casablanca', 'Marrakech', 'Rabat', 'Fez', 'Tangier', 'Agadir']
                    .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'What will members do in this room?',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Room Settings',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Public Room'),
                subtitle: const Text('Anyone can find and join this room'),
                value: _isPublic,
                onChanged: (value) {
                  setState(() {
                    _isPublic = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Allow Deal Sharing'),
                subtitle: const Text('Members can share venue deals and offers'),
                value: _allowDeals,
                onChanged: (value) {
                  setState(() {
                    _allowDeals = value;
                  });
                },
              ),
              if (_selectedCategory == 'food' || _selectedCategory == 'wellness')
                SwitchListTile(
                  title: const Text('Halal Only'),
                  subtitle: const Text('Focus on halal venues and activities'),
                  value: _isHalalOnly,
                  onChanged: (value) {
                    setState(() {
                      _isHalalOnly = value;
                    });
                  },
                ),
              SwitchListTile(
                title: const Text('Prayer Time Aware'),
                subtitle: const Text('Consider prayer times when scheduling activities'),
                value: _isPrayerTimeAware,
                onChanged: (value) {
                  setState(() {
                    _isPrayerTimeAware = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Premium Room'),
                subtitle: const Text('Only premium members can join'),
                value: _isPremiumOnly,
                onChanged: (value) {
                  setState(() {
                    _isPremiumOnly = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _createRoom,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.moroccoGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Create Room'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _createRoom() {
    if (_formKey.currentState!.validate()) {
      // Create a new Room object with the collected data
      final newRoom = Room(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
        name: _nameController.text,
        displayName: _nameController.text, // Assuming display name is same as name for now
        category: _selectedCategory,
        city: _selectedCity,
        description: _descriptionController.text,
        memberCount: 1, // Creator is the first member
        onlineCount: 1,
        isPublic: _isPublic,
        allowDeals: _allowDeals,
        isPrayerTimeAware: _isPrayerTimeAware,
        isHalalOnly: _isHalalOnly,
        isPremiumOnly: _isPremiumOnly,
        createdAt: DateTime.now(),
        lastActivity: DateTime.now(),
        moderators: [], // Add current user as moderator later
        recentMessages: [],
      );

      // In a real app, you would send this to your backend (e.g., Firebase Firestore)
      // For now, we'll just simulate success.

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_nameController.text} room created successfully!'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'View',
            onPressed: () {
              // Navigate to the newly created room's detail page
              context.go('/community/room/${newRoom.id}');
            },
          ),
        ),
      );
    }
  }
}
