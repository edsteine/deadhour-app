#!/usr/bin/env python3
"""
Move Files to Proper Screen Folders Script
- Analyze each file and move to correct screen folder
- Handle widgets, services, models, utils properly
- Create proper folder structure
"""

import os
import shutil
from pathlib import Path
from datetime import datetime

# Base paths
BASE_PATH = "/Users/edsteine/Desktop/deadhour-app"
LIB_PATH = os.path.join(BASE_PATH, "lib")
SCREENS_PATH = os.path.join(LIB_PATH, "screens")
TRASH_PATH = os.path.join(BASE_PATH, "trash")

def find_all_dart_files():
    """Find all .dart files in lib/ directory."""
    dart_files = []
    for root, dirs, files in os.walk(LIB_PATH):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file))
    return dart_files

def determine_target_folder(file_path):
    """Determine where a file should be moved based on its name and path."""
    filename = os.path.basename(file_path)
    current_path = file_path.replace(LIB_PATH, "").lstrip("/")
    
    # Screen mappings based on filename patterns
    screen_files = {
        # Main screen files
        'splash_screen.dart': 'splash_screen',
        'onboarding_screen.dart': 'onboarding_screen',
        'onboarding_page.dart': 'onboarding_screen',
        'login_screen.dart': 'login_screen',
        'register_screen.dart': 'register_screen',
        'deals_screen.dart': 'deals_screen',
        'venues_screen.dart': 'venues_screen',
        'venue_detail_screen.dart': 'venue_detail_screen',
        'tourism_screen.dart': 'tourism_screen',
        'local_expert_screen.dart': 'local_expert_screen',
        'rooms_screen.dart': 'rooms_screen',
        'room_chat_screen.dart': 'room_chat_screen',
        'room_detail_screen.dart': 'room_detail_screen',
        'booking_flow_screen.dart': 'booking_flow_screen',
        'business_dashboard_screen.dart': 'business_dashboard_screen',
        'create_deal_screen.dart': 'create_deal_screen',
        'analytics_dashboard_screen.dart': 'analytics_dashboard_screen',
        'revenue_optimization_screen.dart': 'revenue_optimization_screen',
        'profile_screen.dart': 'profile_screen',
        'role_switching_screen.dart': 'role_switching_screen',
        'role_marketplace_screen.dart': 'role_marketplace_screen',
        'community_health_dashboard_screen.dart': 'community_health_dashboard_screen',
        'network_effects_dashboard_screen.dart': 'network_effects_dashboard_screen',
        'settings_screen.dart': 'settings_screen',
        'accessibility_settings_screen.dart': 'accessibility_settings_screen',
        'offline_settings_screen.dart': 'offline_settings_screen',
        'social_discovery_screen.dart': 'social_discovery_screen',
        'notifications_screen.dart': 'notifications_screen',
        'cultural_ambassador_application_screen.dart': 'cultural_ambassador_application_screen',
        'dev_menu_screen.dart': 'dev_menu_screen',
        'main_navigation_screen.dart': 'main_navigation_screen',
        'guide_role_screen.dart': 'guide_role_screen',
        'web_companion_screen.dart': 'web_companion_screen',
    }
    
    # Direct filename match
    if filename in screen_files:
        return screen_files[filename]
    
    # Check if already in correct screen folder
    for screen_name in screen_files.values():
        if f"screens/{screen_name}/" in current_path:
            return screen_name
    
    # Pattern matching for related files
    patterns = {
        'deal': 'deals_screen',
        'venue': 'venues_screen',
        'room': 'rooms_screen',
        'booking': 'booking_flow_screen',
        'payment': 'payment_screen',
        'business': 'business_dashboard_screen',
        'analytics': 'analytics_dashboard_screen',
        'profile': 'profile_screen',
        'auth': 'profile_screen',
        'user': 'profile_screen',
        'role': 'role_switching_screen',
        'social': 'social_discovery_screen',
        'group': 'social_discovery_screen',
        'notification': 'notifications_screen',
        'tourism': 'tourism_screen',
        'cultural': 'cultural_ambassador_application_screen',
        'navigation': 'main_navigation_screen',
        'setting': 'settings_screen',
        'accessibility': 'accessibility_settings_screen',
        'offline': 'offline_settings_screen',
        'guide': 'guide_role_screen',
        'local_expert': 'local_expert_screen',
        'web_companion': 'web_companion_screen',
    }
    
    filename_lower = filename.lower()
    for pattern, screen in patterns.items():
        if pattern in filename_lower:
            return screen
    
    # Shared components
    shared_patterns = [
        'shared/', 'dev_menu_components/', 'app_bar', 'navigation_', 
        'prayer_time', 'ramadan', 'google_map', 'optimized_', 'performance_',
        'offline_status', 'data_freshness', 'compact_offline'
    ]
    
    for pattern in shared_patterns:
        if pattern in current_path or pattern in filename_lower:
            return 'shared'
    
    # Utils
    if current_path.startswith('utils/'):
        return 'utils'  # Keep in utils
    
    return None

def move_file_to_screen_folder(file_path, target_screen):
    """Move a file to its target screen folder."""
    if not target_screen:
        return False
    
    # Skip if it's utils - keep in utils folder
    if target_screen == 'utils':
        return False
    
    filename = os.path.basename(file_path)
    current_path = file_path.replace(LIB_PATH, "").lstrip("/")
    
    # Determine target directory
    if target_screen == 'shared':
        # Handle shared components
        if 'widgets' in current_path or any(w in filename.lower() for w in ['widget', 'card', 'button']):
            target_dir = os.path.join(SCREENS_PATH, 'shared', 'widgets')
        elif 'dev_menu_components' in current_path or 'app_bar' in filename.lower():
            target_dir = os.path.join(SCREENS_PATH, 'shared', 'dev_menu_components')
        else:
            target_dir = os.path.join(SCREENS_PATH, 'shared', 'components')
    else:
        # Screen-specific folder
        target_dir = os.path.join(SCREENS_PATH, target_screen)
        
        # Preserve subdirectory structure (widgets, services, models, utils)
        path_parts = current_path.split('/')
        if len(path_parts) > 2:
            # Find relevant subdirectories to preserve
            subdirs = []
            for part in path_parts[1:-1]:  # Skip 'screens' and filename
                if part in ['widgets', 'services', 'models', 'utils', 'providers', 'filters']:
                    subdirs.append(part)
            
            if subdirs:
                target_dir = os.path.join(target_dir, *subdirs)
    
    # Create target directory
    os.makedirs(target_dir, exist_ok=True)
    
    # Target file path
    target_path = os.path.join(target_dir, filename)
    
    # Handle conflicts
    if os.path.exists(target_path):
        # Check if files are identical
        try:
            with open(file_path, 'r') as f1, open(target_path, 'r') as f2:
                if f1.read() == f2.read():
                    # Files are identical, just remove the source
                    os.remove(file_path)
                    print(f"  ♻️  Removed duplicate: {filename}")
                    return True
        except:
            pass
        
        # Files are different, backup the existing one
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_path = os.path.join(TRASH_PATH, f"conflict_{filename}_{timestamp}")
        shutil.move(target_path, backup_path)
        print(f"    📦 Backed up existing file: {filename}")
    
    # Move the file
    try:
        shutil.move(file_path, target_path)
        print(f"  ✅ {filename} → {target_screen}/")
        return True
    except Exception as e:
        print(f"  ❌ Error moving {filename}: {e}")
        return False

def main():
    """Main file organization function."""
    print("📁 Moving Files to Proper Screen Folders")
    print("=" * 45)
    
    # Get all dart files
    all_files = find_all_dart_files()
    print(f"Found {len(all_files)} Dart files to analyze")
    
    # Create screen folders
    screen_folders = [
        'splash_screen', 'onboarding_screen', 'login_screen', 'register_screen',
        'deals_screen', 'venues_screen', 'venue_detail_screen', 'tourism_screen',
        'local_expert_screen', 'rooms_screen', 'room_chat_screen', 'room_detail_screen',
        'booking_flow_screen', 'payment_screen', 'business_dashboard_screen',
        'create_deal_screen', 'analytics_dashboard_screen', 'revenue_optimization_screen',
        'profile_screen', 'role_switching_screen', 'role_marketplace_screen',
        'community_health_dashboard_screen', 'network_effects_dashboard_screen',
        'settings_screen', 'accessibility_settings_screen', 'offline_settings_screen',
        'social_discovery_screen', 'notifications_screen', 'cultural_ambassador_application_screen',
        'dev_menu_screen', 'main_navigation_screen', 'guide_role_screen', 'web_companion_screen'
    ]
    
    for folder in screen_folders:
        os.makedirs(os.path.join(SCREENS_PATH, folder), exist_ok=True)
    
    # Also create shared structure
    shared_dirs = ['shared/widgets', 'shared/components', 'shared/dev_menu_components']
    for shared_dir in shared_dirs:
        os.makedirs(os.path.join(SCREENS_PATH, shared_dir), exist_ok=True)
    
    print(f"✅ Created {len(screen_folders)} screen folders + shared structure")
    
    # Process each file
    moved_count = 0
    for file_path in all_files:
        target_screen = determine_target_folder(file_path)
        if target_screen and target_screen != 'utils':
            if move_file_to_screen_folder(file_path, target_screen):
                moved_count += 1
    
    print(f"\n📁 Moved {moved_count} files to proper locations")
    
    # Remove empty directories
    print("\n🧹 Cleaning up empty directories...")
    removed_count = 0
    for root, dirs, files in os.walk(LIB_PATH, topdown=False):
        for dir_name in dirs:
            dir_path = os.path.join(root, dir_name)
            try:
                if not os.listdir(dir_path):  # Directory is empty
                    os.rmdir(dir_path)
                    print(f"  🗑️  Removed: {dir_path}")
                    removed_count += 1
            except OSError:
                pass  # Directory not empty or other error
    
    print(f"🧹 Removed {removed_count} empty directories")
    print("\n🎉 File organization completed!")
    print("📋 Files are now organized by screen in proper folders")

if __name__ == "__main__":
    main()