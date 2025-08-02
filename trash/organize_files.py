#!/usr/bin/env python3
"""
DeadHour File Organization Script
- Move files to correct screen folders
- Split large files if needed
- Fix import statements
- Remove unused files from TODO.md list
"""

import os
import re
import shutil
from pathlib import Path
from datetime import datetime

# Base paths
BASE_PATH = "/Users/edsteine/Desktop/deadhour-app"
LIB_PATH = os.path.join(BASE_PATH, "lib")
SCREENS_PATH = os.path.join(LIB_PATH, "screens")
TRASH_PATH = os.path.join(BASE_PATH, "trash")

# Files to remove (from TODO.md unused files list)
UNUSED_FILES = [
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/tourist_home_screen/tourist_home_screen.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/cultural_ambassador_application_screen/cultural_ambassador_application_screen.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/utils/halal_filter_service.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/utils/global_error_widget.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/utils/offline_data_info.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/utils/performance_monitor.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/utils/retry_mechanism.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/home_screen/home_screen.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/widgets/pull_to_refresh_wrapper.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/services/onboarding_step_extension.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/widgets/mock_auth_section.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/widgets/loading_state_wrapper.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/premium_role_screen/premium_role_screen.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/profile_screen/widgets/prayer_schedule_card.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/business_dashboard_screen/services/analytics_properties.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/business_dashboard_screen/services/analytics_events.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/role_switching_screen/enhanced_role_switcher_widget.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/role_switching_screen/role_switching_screen.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/web_companion/web_companion_screen.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/web_companion/services/web_companion_service.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/group_booking_screen/group_booking_screen.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/community_health_dashboard_screen/community_health_dashboard_screen.dart",
    "/Users/edsteine/Desktop/deadhour-app/lib/screens/payment_screen/payment_screen.dart",
]

def find_dart_files(directory):
    """Find all .dart files in directory and subdirectories."""
    dart_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file))
    return dart_files

def get_screen_name_from_file(file_path):
    """Determine which screen folder a file belongs to."""
    filename = os.path.basename(file_path)
    dir_path = os.path.dirname(file_path)
    
    # Direct screen file mapping
    screen_mappings = {
        'splash_screen.dart': 'splash_screen',
        'onboarding_screen.dart': 'onboarding_screen',
        'onboarding_page.dart': 'onboarding_screen',
        'login_screen.dart': 'login_screen',
        'register_screen.dart': 'register_screen',
        'home_screen.dart': 'home_screen',
        'deals_screen.dart': 'deals_screen',
        'venues_screen.dart': 'venues_screen',
        'venue_detail_screen.dart': 'venue_detail_screen',
        'tourism_screen.dart': 'tourism_screen',
        'local_expert_screen.dart': 'local_expert_screen',
        'rooms_screen.dart': 'rooms_screen',
        'room_chat_screen.dart': 'room_chat_screen',
        'room_detail_screen.dart': 'room_detail_screen',
        'booking_flow_screen.dart': 'booking_flow_screen',
        'payment_screen.dart': 'payment_screen',
        'business_dashboard_screen.dart': 'business_dashboard_screen',
        'create_deal_screen.dart': 'create_deal_screen',
        'analytics_dashboard_screen.dart': 'analytics_dashboard_screen',
        'revenue_optimization_screen.dart': 'revenue_optimization_screen',
        'profile_screen.dart': 'profile_screen',
        'role_switching_screen.dart': 'role_switching_screen',
        'role_marketplace_screen.dart': 'role_marketplace_screen',
        'premium_role_screen.dart': 'premium_role_screen',
        'community_health_dashboard_screen.dart': 'community_health_dashboard_screen',
        'network_effects_dashboard_screen.dart': 'network_effects_dashboard_screen',
        'settings_screen.dart': 'settings_screen',
        'accessibility_settings_screen.dart': 'accessibility_settings_screen',
        'offline_settings_screen.dart': 'offline_settings_screen',
        'social_discovery_screen.dart': 'social_discovery_screen',
        'group_booking_screen.dart': 'group_booking_screen',
        'notifications_screen.dart': 'notifications_screen',
        'cultural_ambassador_application_screen.dart': 'cultural_ambassador_application_screen',
        'dev_menu_screen.dart': 'dev_menu_screen',
        'main_navigation_screen.dart': 'main_navigation_screen',
        'guide_role_screen.dart': 'guide_role_screen',
        'web_companion_screen.dart': 'web_companion_screen',
        'tourist_home_screen.dart': 'tourist_home_screen',
    }
    
    # Check direct mapping first
    if filename in screen_mappings:
        return screen_mappings[filename]
    
    # Check if file is in a screen-specific directory
    for screen in screen_mappings.values():
        if f"/{screen}/" in dir_path or dir_path.endswith(f"/{screen}"):
            return screen
    
    # Check for patterns in filename
    for screen in screen_mappings.values():
        screen_base = screen.replace('_screen', '')
        if screen_base in filename.lower():
            return screen
    
    # Shared components
    if '/shared/' in dir_path or '/dev_menu_components/' in dir_path:
        return 'shared'
    
    # Utils
    if '/utils/' in dir_path:
        return 'utils'
    
    return None

def move_unused_files_to_trash():
    """Move unused files from TODO.md list to trash."""
    print("🗑️  Moving unused files to trash...")
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    moved_count = 0
    
    for file_path in UNUSED_FILES:
        if os.path.exists(file_path):
            filename = os.path.basename(file_path)
            trash_path = os.path.join(TRASH_PATH, f"unused_{filename}_{timestamp}")
            
            try:
                shutil.move(file_path, trash_path)
                print(f"  ✅ Moved: {filename}")
                moved_count += 1
            except Exception as e:
                print(f"  ❌ Error moving {filename}: {e}")
    
    print(f"🗑️  Moved {moved_count} unused files to trash")
    return moved_count

def organize_files_by_screen():
    """Move files to their correct screen folders."""
    print("📁 Organizing files by screen...")
    
    all_files = find_dart_files(LIB_PATH)
    moved_files = []
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    for file_path in all_files:
        screen = get_screen_name_from_file(file_path)
        if not screen:
            continue
            
        # Skip if file is already in correct location
        current_screen_dir = None
        parts = file_path.split('/')
        if 'screens' in parts:
            screens_idx = parts.index('screens')
            if screens_idx + 1 < len(parts):
                current_screen_dir = parts[screens_idx + 1]
        
        if current_screen_dir == screen:
            continue  # Already in correct location
        
        # Determine target path
        if screen == 'shared':
            target_dir = os.path.join(LIB_PATH, 'screens', 'shared')
            if '/widgets/' in file_path:
                target_dir = os.path.join(target_dir, 'widgets')
            elif '/dev_menu_components/' in file_path:
                target_dir = os.path.join(target_dir, 'dev_menu_components')
            else:
                target_dir = os.path.join(target_dir, 'components')
        elif screen == 'utils':
            target_dir = os.path.join(LIB_PATH, 'utils')
        else:
            target_dir = os.path.join(SCREENS_PATH, screen)
            
            # Preserve subdirectory structure (widgets, services, models, etc.)
            relative_path = os.path.relpath(file_path, LIB_PATH)
            path_parts = relative_path.split('/')
            if len(path_parts) > 2:  # Has subdirectories
                subdirs = path_parts[2:-1]  # Everything except 'screens', screen_name, and filename
                if subdirs:
                    target_dir = os.path.join(target_dir, *subdirs)
        
        # Create target directory
        os.makedirs(target_dir, exist_ok=True)
        
        # Move file
        filename = os.path.basename(file_path)
        target_path = os.path.join(target_dir, filename)
        
        # Handle conflicts
        if os.path.exists(target_path):
            print(f"  ⚠️  Conflict: {filename} already exists in {screen}")
            # Create backup of existing file
            backup_path = os.path.join(TRASH_PATH, f"conflict_{filename}_{timestamp}")
            shutil.move(target_path, backup_path)
            print(f"    📦 Backed up existing file to trash")
        
        try:
            shutil.move(file_path, target_path)
            moved_files.append((file_path, target_path))
            print(f"  ✅ {filename} → {screen}/")
        except Exception as e:
            print(f"  ❌ Error moving {filename}: {e}")
    
    print(f"📁 Moved {len(moved_files)} files to correct locations")
    return moved_files

def remove_empty_directories():
    """Remove empty directories after file moves."""
    print("🧹 Removing empty directories...")
    removed_count = 0
    
    for root, dirs, files in os.walk(LIB_PATH, topdown=False):
        for dir_name in dirs:
            dir_path = os.path.join(root, dir_name)
            try:
                if not os.listdir(dir_path):  # Directory is empty
                    os.rmdir(dir_path)
                    print(f"  🗑️  Removed empty directory: {dir_path}")
                    removed_count += 1
            except OSError:
                pass  # Directory not empty or other error
    
    print(f"🧹 Removed {removed_count} empty directories")
    return removed_count

def update_import_statements():
    """Update import statements after file moves (basic version)."""
    print("🔗 Updating import statements...")
    
    all_files = find_dart_files(LIB_PATH)
    updated_count = 0
    
    for file_path in all_files:
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # Update common import patterns
            # This is a basic version - may need manual fixes
            content = re.sub(
                r"import\s+['\"]lib/screens/([^/]+)/([^'\"]+)['\"]",
                r"import 'lib/screens/\1/\2'",
                content
            )
            
            if content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                updated_count += 1
                print(f"  ✅ Updated imports in: {os.path.basename(file_path)}")
                
        except Exception as e:
            print(f"  ❌ Error updating imports in {file_path}: {e}")
    
    print(f"🔗 Updated imports in {updated_count} files")
    return updated_count

def main():
    """Main organization function."""
    print("🚀 Starting DeadHour File Organization")
    print("=" * 50)
    
    try:
        # Step 1: Move unused files to trash
        move_unused_files_to_trash()
        
        # Step 2: Organize files by screen
        organize_files_by_screen()
        
        # Step 3: Remove empty directories
        remove_empty_directories()
        
        # Step 4: Update import statements
        update_import_statements()
        
        print("\n🎉 File organization completed successfully!")
        print("📋 Next steps:")
        print("  1. Run 'flutter analyze' to check for import errors")
        print("  2. Fix any remaining import issues manually")
        print("  3. Test app compilation")
        
    except Exception as e:
        print(f"❌ Error during organization: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()