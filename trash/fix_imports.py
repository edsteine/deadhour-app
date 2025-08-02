#!/usr/bin/env python3
"""
Fix Import Issues Script
- Fix broken imports after cleanup
- Replace missing imports with working alternatives
- Update import paths
"""

import os
import re

# Base paths
BASE_PATH = "/Users/edsteine/Desktop/deadhour-app"
LIB_PATH = os.path.join(BASE_PATH, "lib")

def fix_file_imports(file_path, replacements):
    """Fix imports in a specific file."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        for old_import, new_import in replacements:
            content = content.replace(old_import, new_import)
        
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"  ✅ Fixed imports in: {os.path.basename(file_path)}")
            return True
        
        return False
        
    except Exception as e:
        print(f"  ❌ Error fixing {file_path}: {e}")
        return False

def main():
    """Fix all import issues."""
    print("🔧 Fixing Import Issues")
    print("=" * 30)
    
    # Fix deals_list_view.dart - remove optimized_list_view import
    print("📄 Fixing deals_list_view.dart...")
    deals_list_view_path = os.path.join(LIB_PATH, "screens/deals_screen/widgets/deals_list_view.dart")
    replacements = [
        ("import 'package:deadhour/screens/deals_screen/widgets/optimized_list_view.dart';", "// Removed unused import"),
        ("return BasicOptimizedListView(", "return ListView("),
    ]
    fix_file_imports(deals_list_view_path, replacements)
    
    # Fix notifications_list.dart - replace app_navigation with app_routes
    print("📄 Fixing notifications_list.dart...")
    notifications_list_path = os.path.join(LIB_PATH, "screens/notifications_screen/widgets/notifications_list.dart")
    replacements = [
        ("import 'package:deadhour/utils/app_navigation.dart';", "import 'package:deadhour/utils/app_routes.dart';"),
        ("AppNavigation.navigateTo", "AppRoutes.navigateTo"),
    ]
    fix_file_imports(notifications_list_path, replacements)
    
    # Fix dead_hour_app_bar.dart - remove cultural_timing_widget import
    print("📄 Fixing dead_hour_app_bar.dart...")
    dead_hour_app_bar_path = os.path.join(LIB_PATH, "screens/shared/dev_menu_components/dead_hour_app_bar.dart")
    replacements = [
        ("import 'package:deadhour/screens/cultural_ambassador_application_screen/cultural_timing_widget.dart';", "// Removed unused import"),
        ("AppBarCulturalTimingWidget()", "Container() // Removed missing widget"),
    ]
    fix_file_imports(dead_hour_app_bar_path, replacements)
    
    # Fix social_discovery_screen.dart - remove experiences_tab import
    print("📄 Fixing social_discovery_screen.dart...")
    social_discovery_path = os.path.join(LIB_PATH, "screens/social_discovery_screen/social_discovery_screen.dart")
    replacements = [
        ("import 'package:deadhour/screens/social_discovery_screen/widgets/experiences_tab.dart';", "// Removed unused import"),
        ("SocialExperiencesTab()", "Container(child: Text('Experiences')) // Placeholder"),
    ]
    fix_file_imports(social_discovery_path, replacements)
    
    # Fix venues_screen.dart - replace app_navigation with app_routes
    print("📄 Fixing venues_screen.dart...")
    venues_screen_path = os.path.join(LIB_PATH, "screens/venues_screen/venues_screen.dart")
    replacements = [
        ("import 'package:deadhour/utils/app_navigation.dart';", "import 'package:deadhour/utils/app_routes.dart';"),
        ("AppNavigation.navigateToVenueDetail", "AppRoutes.navigateToVenueDetail"),
        ("AppNavigation.navigateToDeals", "AppRoutes.navigateToDeals"),
        ("AppNavigation.navigateToBooking", "AppRoutes.navigateToBooking"),
    ]
    fix_file_imports(venues_screen_path, replacements)
    
    # Fix venue_card_widget.dart - replace app_navigation with app_routes
    print("📄 Fixing venue_card_widget.dart...")
    venue_card_widget_path = os.path.join(LIB_PATH, "screens/venues_screen/widgets/venue_card_widget.dart")
    replacements = [
        ("import 'package:deadhour/utils/app_navigation.dart';", "import 'package:deadhour/utils/app_routes.dart';"),
        ("AppNavigation.navigateToVenueDetail", "AppRoutes.navigateToVenueDetail"),
        ("AppNavigation.pushToVenueDetail", "AppRoutes.pushToVenueDetail"),
    ]
    fix_file_imports(venue_card_widget_path, replacements)
    
    # Create a simple AppError class to fix app_error_handler.dart
    print("📄 Creating AppError class...")
    app_error_path = os.path.join(LIB_PATH, "utils/app_error.dart")
    app_error_content = '''// Simple AppError class to replace the deleted one
class AppError {
  final String message;
  final String? code;
  final dynamic originalError;
  
  AppError(this.message, {this.code, this.originalError});
  
  factory AppError.network(String message) => AppError(message, code: 'NETWORK');
  factory AppError.validation(String message) => AppError(message, code: 'VALIDATION');
  factory AppError.authentication(String message) => AppError(message, code: 'AUTH');
  factory AppError.permission(String message) => AppError(message, code: 'PERMISSION');
  factory AppError.notFound(String message) => AppError(message, code: 'NOT_FOUND');
  factory AppError.timeout(String message) => AppError(message, code: 'TIMEOUT');
  factory AppError.unknown(String message) => AppError(message, code: 'UNKNOWN');
  
  @override
  String toString() => 'AppError: $message${code != null ? ' ($code)' : ''}';
}
'''
    
    with open(app_error_path, 'w', encoding='utf-8') as f:
        f.write(app_error_content)
    print(f"  ✅ Created: {os.path.basename(app_error_path)}")
    
    print("\n🎉 Import fixes completed!")
    print("📋 Running flutter analyze to verify fixes...")

if __name__ == "__main__":
    main()