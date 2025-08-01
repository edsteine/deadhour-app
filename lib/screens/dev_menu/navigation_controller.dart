import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/performance_utils.dart';

/// Handles navigation state and logic for MainNavigationScreen
class NavigationController extends ChangeNotifier {
  late TabController _tabController;
  late PageController _pageController;
  int _currentIndex = 0;
  
  // Filter states for different tabs
  String _selectedRoomType = 'all_rooms';
  String _selectedTourismTab = 'discover';
  String _selectedVenueView = 'list_view';

  // Getters
  TabController get tabController => _tabController;
  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex;
  String get selectedRoomType => _selectedRoomType;
  String get selectedTourismTab => _selectedTourismTab;
  String get selectedVenueView => _selectedVenueView;

  void initialize(TickerProvider vsync) {
    _tabController = TabController(length: 6, vsync: vsync);
    _pageController = PageController(initialPage: _currentIndex);
    
    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _currentIndex != _tabController.index) {
        _currentIndex = _tabController.index;
        notifyListeners();
        PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
      }
    });
  }

  void setTabFromRoute(BuildContext context) {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.last.matchedLocation;
    int tabIndex = 0;
    
    switch (location) {
      case '/deals':
        tabIndex = 0;
        break;
      case '/venues':
        tabIndex = 1;
        break;
      case '/community':
        tabIndex = 2;
        break;
      case '/tourism':
        tabIndex = 3;
        break;
      case '/notifications':
        tabIndex = 4;
        break;
      case '/profile':
        tabIndex = 5;
        break;
      default:
        tabIndex = 0;
    }
    
    if (tabIndex != _currentIndex) {
      _currentIndex = tabIndex;
      notifyListeners();
      _pageController.animateToPage(
        tabIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onItemTapped(int index) {
    if (_currentIndex != index) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    }
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    _tabController.animateTo(index);
    notifyListeners();
    PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
  }

  void applyRoomTypeFilter(String roomType) {
    _selectedRoomType = roomType;
    notifyListeners();
  }

  void applyTourismFilter(String contentType) {
    _selectedTourismTab = contentType;
    notifyListeners();
  }

  void applyVenueViewFilter(String viewType) {
    _selectedVenueView = viewType;
    notifyListeners();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}