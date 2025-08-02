#!/usr/bin/env python3
"""
DeadHour Codebase Cleanup Script
- Find duplicate classes/files
- Keep the richest version (most content/functionality)
- Move files to correct locations
- Compare files with same names
- Organize according to screen structure
"""

import os
import re
import shutil
import hashlib
from pathlib import Path
from datetime import datetime
from collections import defaultdict
import ast

# Base paths
BASE_PATH = "/Users/edsteine/Desktop/deadhour-app"
LIB_PATH = os.path.join(BASE_PATH, "lib")
TRASH_PATH = os.path.join(BASE_PATH, "trash")

# Create trash directory if it doesn't exist
os.makedirs(TRASH_PATH, exist_ok=True)

def get_file_stats(file_path):
    """Get file statistics: lines, classes, methods, imports, etc."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        stats = {
            'path': file_path,
            'size': os.path.getsize(file_path),
            'lines': len(content.splitlines()),
            'non_empty_lines': len([line for line in content.splitlines() if line.strip()]),
            'classes': len(re.findall(r'class\s+\w+', content)),
            'methods': len(re.findall(r'(?:void|Future|Widget|String|int|bool|double)\s+\w+\s*\(', content)),
            'imports': len(re.findall(r'^import\s+', content, re.MULTILINE)),
            'widgets': len(re.findall(r'extends\s+(?:StatelessWidget|StatefulWidget)', content)),
            'build_methods': len(re.findall(r'Widget\s+build\s*\(', content)),
            'has_scaffold': 'Scaffold(' in content,
            'has_app_bar': 'AppBar(' in content or 'appBar:' in content,
            'has_state_management': any(pattern in content for pattern in ['Provider', 'Consumer', 'Riverpod', 'setState']),
            'content': content
        }
        
        return stats
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return None

def calculate_richness_score(stats):
    """Calculate how 'rich' a file is based on various metrics."""
    if not stats:
        return 0
    
    score = 0
    score += stats['non_empty_lines'] * 1  # Base score from content
    score += stats['classes'] * 50         # Classes are valuable
    score += stats['methods'] * 20         # Methods add functionality
    score += stats['widgets'] * 30         # Widgets are important
    score += stats['imports'] * 5          # More imports = more dependencies/functionality
    
    # Bonus points for key Flutter features
    if stats['has_scaffold']:
        score += 100  # Main screen indicator
    if stats['has_app_bar']:
        score += 50   # UI component
    if stats['build_methods']:
        score += stats['build_methods'] * 25
    if stats['has_state_management']:
        score += 75   # State management is complex
    
    return score

def find_dart_files(directory):
    """Find all .dart files in directory and subdirectories."""
    dart_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file))
    return dart_files

def get_class_names(file_path):
    """Extract class names from a Dart file."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Find class declarations
        class_matches = re.findall(r'class\s+(\w+)', content)
        return class_matches
    except:
        return []

def find_duplicates_by_name():
    """Find duplicate files by filename."""
    print("🔍 Finding duplicate files by name...")
    
    all_files = find_dart_files(LIB_PATH)
    filename_groups = defaultdict(list)
    
    for file_path in all_files:
        filename = os.path.basename(file_path)
        filename_groups[filename].append(file_path)
    
    # Only return files with duplicates
    duplicates = {name: paths for name, paths in filename_groups.items() if len(paths) > 1}
    
    print(f"Found {len(duplicates)} duplicate filenames")
    return duplicates

def find_duplicates_by_class():
    """Find duplicate files by class names."""
    print("🔍 Finding duplicate files by class names...")
    
    all_files = find_dart_files(LIB_PATH)
    class_groups = defaultdict(list)
    
    for file_path in all_files:
        classes = get_class_names(file_path)
        for class_name in classes:
            class_groups[class_name].append(file_path)
    
    # Only return classes with duplicates
    duplicates = {name: paths for name, paths in class_groups.items() if len(paths) > 1}
    
    print(f"Found {len(duplicates)} duplicate class names")
    return duplicates

def analyze_and_deduplicate():
    """Main function to analyze and deduplicate files."""
    print("🚀 Starting DeadHour Codebase Cleanup")
    print("=" * 50)
    
    # Find duplicates
    filename_duplicates = find_duplicates_by_name()
    class_duplicates = find_duplicates_by_class()
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    report_file = os.path.join(BASE_PATH, f"cleanup_report_{timestamp}.txt")
    
    with open(report_file, 'w') as report:
        report.write("DeadHour Codebase Cleanup Report\n")
        report.write("=" * 40 + "\n\n")
        
        # Process filename duplicates
        if filename_duplicates:
            print(f"\n📁 Processing {len(filename_duplicates)} filename duplicates...")
            report.write(f"FILENAME DUPLICATES ({len(filename_duplicates)}):\n")
            report.write("-" * 30 + "\n")
            
            for filename, file_paths in filename_duplicates.items():
                print(f"\n🔍 Analyzing: {filename}")
                report.write(f"\n{filename}:\n")
                
                # Get stats for each duplicate
                file_stats = []
                for path in file_paths:
                    stats = get_file_stats(path)
                    if stats:
                        stats['richness'] = calculate_richness_score(stats)
                        file_stats.append(stats)
                
                if not file_stats:
                    continue
                
                # Sort by richness score (highest first)
                file_stats.sort(key=lambda x: x['richness'], reverse=True)
                
                # Keep the richest file, move others to trash
                keeper = file_stats[0]
                to_remove = file_stats[1:]
                
                report.write(f"  KEEPER: {keeper['path']} (score: {keeper['richness']})\n")
                print(f"  ✅ KEEPING: {keeper['path']} (score: {keeper['richness']})")
                
                for stats in to_remove:
                    old_path = stats['path']
                    trash_path = os.path.join(TRASH_PATH, f"{os.path.basename(old_path)}_{timestamp}")
                    
                    try:
                        shutil.move(old_path, trash_path)
                        print(f"  🗑️  MOVED TO TRASH: {old_path}")
                        report.write(f"  REMOVED: {old_path} (score: {stats['richness']})\n")
                    except Exception as e:
                        print(f"  ❌ ERROR moving {old_path}: {e}")
                        report.write(f"  ERROR: {old_path} - {e}\n")
        
        # Process class duplicates
        if class_duplicates:
            print(f"\n🏗️  Processing {len(class_duplicates)} class duplicates...")
            report.write(f"\n\nCLASS DUPLICATES ({len(class_duplicates)}):\n")
            report.write("-" * 30 + "\n")
            
            for class_name, file_paths in class_duplicates.items():
                # Skip if files were already handled in filename duplicates
                remaining_paths = [p for p in file_paths if os.path.exists(p)]
                if len(remaining_paths) <= 1:
                    continue
                
                print(f"\n🔍 Analyzing class: {class_name}")
                report.write(f"\n{class_name}:\n")
                
                # Get stats for each file containing this class
                file_stats = []
                for path in remaining_paths:
                    stats = get_file_stats(path)
                    if stats:
                        stats['richness'] = calculate_richness_score(stats)
                        file_stats.append(stats)
                
                if len(file_stats) <= 1:
                    continue
                
                # Sort by richness score
                file_stats.sort(key=lambda x: x['richness'], reverse=True)
                
                # Keep the richest file, move others to trash
                keeper = file_stats[0]
                to_remove = file_stats[1:]
                
                report.write(f"  KEEPER: {keeper['path']} (score: {keeper['richness']})\n")
                print(f"  ✅ KEEPING: {keeper['path']} (score: {keeper['richness']})")
                
                for stats in to_remove:
                    old_path = stats['path']
                    trash_path = os.path.join(TRASH_PATH, f"{os.path.basename(old_path)}_{timestamp}")
                    
                    try:
                        shutil.move(old_path, trash_path)
                        print(f"  🗑️  MOVED TO TRASH: {old_path}")
                        report.write(f"  REMOVED: {old_path} (score: {stats['richness']})\n")
                    except Exception as e:
                        print(f"  ❌ ERROR moving {old_path}: {e}")
                        report.write(f"  ERROR: {old_path} - {e}\n")
    
    print(f"\n📋 Cleanup report saved to: {report_file}")
    return report_file

def find_large_files():
    """Find files that need splitting (over 500 lines)."""
    print("\n📏 Finding large files that need splitting...")
    
    all_files = find_dart_files(LIB_PATH)
    large_files = []
    
    for file_path in all_files:
        stats = get_file_stats(file_path)
        if stats and stats['lines'] > 500:
            large_files.append((file_path, stats['lines']))
    
    large_files.sort(key=lambda x: x[1], reverse=True)
    
    print(f"Found {len(large_files)} files over 500 lines:")
    for file_path, lines in large_files[:10]:  # Show top 10
        print(f"  📄 {lines:4d} lines: {file_path}")
    
    return large_files

def organize_by_screen_structure():
    """Organize files according to screen structure from TODO copy.md."""
    print("\n🏗️  Organizing files by screen structure...")
    
    # Define screen folders based on TODO copy.md
    screen_folders = [
        'splash_screen', 'onboarding_screen', 'login_screen', 'register_screen',
        'home_screen', 'deals_screen', 'venues_screen', 'venue_detail_screen',
        'tourism_screen', 'local_expert_screen', 'rooms_screen', 'room_chat_screen',
        'room_detail_screen', 'booking_flow_screen', 'payment_screen',
        'business_dashboard_screen', 'create_deal_screen', 'analytics_dashboard_screen',
        'revenue_optimization_screen', 'profile_screen', 'role_switching_screen',
        'role_marketplace_screen', 'premium_role_screen', 'community_health_dashboard_screen',
        'network_effects_dashboard_screen', 'settings_screen', 'accessibility_settings_screen',
        'offline_settings_screen', 'social_discovery_screen', 'group_booking_screen',
        'notifications_screen', 'cultural_ambassador_application_screen',
        'dev_menu_screen', 'main_navigation_screen', 'guide_role_screen',
        'web_companion_screen'
    ]
    
    screens_path = os.path.join(LIB_PATH, 'screens')
    
    # Create screen folders if they don't exist
    for screen in screen_folders:
        screen_path = os.path.join(screens_path, screen)
        os.makedirs(screen_path, exist_ok=True)
    
    print(f"✅ Created {len(screen_folders)} screen folders")

if __name__ == "__main__":
    try:
        # Step 1: Analyze and deduplicate
        report_file = analyze_and_deduplicate()
        
        # Step 2: Find large files
        large_files = find_large_files()
        
        # Step 3: Organize by screen structure
        organize_by_screen_structure()
        
        print("\n🎉 Cleanup completed successfully!")
        print(f"📋 Report: {report_file}")
        print(f"🗑️  Trash folder: {TRASH_PATH}")
        
    except Exception as e:
        print(f"❌ Error during cleanup: {e}")
        import traceback
        traceback.print_exc()