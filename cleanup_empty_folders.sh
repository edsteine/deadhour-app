#!/bin/bash

# Script to safely remove ONLY empty folders in lib directory
# This script will NOT delete files, only empty directories

echo "🧹 Starting cleanup of empty folders in lib directory..."
echo "⚠️  This script will ONLY delete EMPTY folders, never files"
echo ""

# Change to the lib directory
cd "/Users/edsteine/Desktop/deadhour-app/lib" || {
    echo "❌ Error: Could not access lib directory"
    exit 1
}

# Function to safely remove empty directories
cleanup_empty_dirs() {
    local removed_count=0
    
    # Find and remove empty directories (excluding .git and other hidden dirs)
    # Process directories from deepest to shallowest to handle nested empty dirs
    while IFS= read -r -d '' dir; do
        if [ -d "$dir" ] && [ "$(ls -A "$dir" 2>/dev/null | wc -l)" -eq 0 ]; then
            echo "🗑️  Removing empty folder: $dir"
            rmdir "$dir" 2>/dev/null && ((removed_count++))
        fi
    done < <(find . -type d -not -path "./.git*" -not -path "./.*" -print0 | sort -rz)
    
    return $removed_count
}

# Show what empty folders exist before cleanup
echo "📋 Empty folders found:"
find . -type d -not -path "./.git*" -not -path "./.*" -empty -print | sort

echo ""
echo "🤔 Do you want to proceed with removing these empty folders? (y/N)"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo ""
    echo "🧹 Cleaning up empty folders..."
    
    # Run cleanup multiple times to handle nested empty directories
    total_removed=0
    for i in {1..5}; do
        cleanup_empty_dirs
        current_removed=$?
        total_removed=$((total_removed + current_removed))
        
        if [ $current_removed -eq 0 ]; then
            break
        fi
        echo "   Pass $i: Removed $current_removed empty folders"
    done
    
    echo ""
    echo "✅ Cleanup complete! Removed $total_removed empty folders total."
    
    # Show remaining structure
    echo ""
    echo "📁 Current lib directory structure:"
    tree -I "__pycache__|*.pyc|.git" -a -L 3 . || ls -la
    
else
    echo "❌ Cleanup cancelled by user"
fi

echo ""
echo "🔍 Verification: Checking for any remaining empty folders..."
remaining_empty=$(find . -type d -not -path "./.git*" -not -path "./.*" -empty | wc -l)
if [ "$remaining_empty" -gt 0 ]; then
    echo "⚠️  Found $remaining_empty remaining empty folders:"
    find . -type d -not -path "./.git*" -not -path "./.*" -empty -print
else
    echo "✅ No empty folders remaining!"
fi