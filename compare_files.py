#!/usr/bin/env python3
"""
Script to compare Dart files in trash folder vs lib folder
Finds files that exist in trash but are missing from lib
"""

import os
from pathlib import Path

def get_dart_files(directory):
    """Get all .dart files in a directory recursively"""
    dart_files = set()
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                # Just get the filename, not the full path
                dart_files.add(file)
    return dart_files

def main():
    # Define paths
    trash_dir = "/Users/edsteine/Desktop/deadhour-app/trash"
    lib_dir = "/Users/edsteine/Desktop/deadhour-app/lib"
    
    # Check if directories exist
    if not os.path.exists(trash_dir):
        print(f"❌ Trash directory not found: {trash_dir}")
        return
    
    if not os.path.exists(lib_dir):
        print(f"❌ Lib directory not found: {lib_dir}")
        return
    
    print("🔍 Scanning directories...")
    
    # Get all dart files in both directories
    trash_files = get_dart_files(trash_dir)
    lib_files = get_dart_files(lib_dir)
    
    print(f"📁 Found {len(trash_files)} Dart files in trash")
    print(f"📁 Found {len(lib_files)} Dart files in lib")
    
    # Find files in trash but not in lib
    missing_in_lib = trash_files - lib_files
    
    print("\n" + "="*60)
    if missing_in_lib:
        print(f"⚠️  Found {len(missing_in_lib)} files in TRASH but MISSING from LIB:")
        print("="*60)
        for file in sorted(missing_in_lib):
            print(f"❌ {file}")
            
        print("\n" + "="*60)
        print("📋 SUMMARY:")
        print(f"   Files in trash only: {len(missing_in_lib)}")
        print(f"   Files in both:       {len(trash_files & lib_files)}")
        print(f"   Total trash files:   {len(trash_files)}")
    else:
        print("✅ All files in trash also exist in lib folder!")
        print("   No missing files found.")
    
    # Also show files that exist in lib but not in trash (for completeness)
    missing_in_trash = lib_files - trash_files
    if missing_in_trash:
        print(f"\nℹ️  Files in LIB but not in TRASH: {len(missing_in_trash)}")
        print("   (This is normal - these are active files)")

if __name__ == "__main__":
    main()