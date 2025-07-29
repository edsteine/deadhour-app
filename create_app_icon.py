#!/usr/bin/env python3
"""
Simple script to create DeadHour app icons
"""

from PIL import Image, ImageDraw, ImageFont
import os

def create_app_icon():
    # App theme colors - using a Morocco-inspired palette
    primary_color = "#E74C3C"  # Morocco red
    secondary_color = "#F39C12"  # Golden yellow  
    background_color = "#2C3E50"  # Dark blue-gray
    text_color = "#FFFFFF"
    
    # Create main app icon (1024x1024 for high resolution)
    size = 1024
    image = Image.new('RGB', (size, size), background_color)
    draw = ImageDraw.Draw(image)
    
    # Draw a clock-like circle to represent "dead hours"
    margin = size // 8
    circle_bbox = [margin, margin, size - margin, size - margin]
    draw.ellipse(circle_bbox, fill=primary_color, outline=secondary_color, width=8)
    
    # Draw clock hands pointing to "dead hour" (3 PM - common dead time)
    center = size // 2
    # Hour hand (short, pointing to 3)
    hour_end_x = center + (size // 6)
    hour_end_y = center
    draw.line([center, center, hour_end_x, hour_end_y], fill=text_color, width=12)
    
    # Minute hand (long, pointing to 12)
    minute_end_x = center
    minute_end_y = center - (size // 4)
    draw.line([center, center, minute_end_x, minute_end_y], fill=text_color, width=8)
    
    # Center dot
    dot_size = 20
    draw.ellipse([center-dot_size, center-dot_size, center+dot_size, center+dot_size], fill=secondary_color)
    
    # Add small dots around the edge to suggest community/discovery
    for i in range(12):
        angle = i * 30  # 360/12 = 30 degrees per hour
        import math
        dot_x = center + (size//3) * math.cos(math.radians(angle - 90))
        dot_y = center + (size//3) * math.sin(math.radians(angle - 90))
        dot_radius = 15
        draw.ellipse([dot_x-dot_radius, dot_y-dot_radius, dot_x+dot_radius, dot_y+dot_radius], fill=secondary_color)
    
    return image

def create_adaptive_icons():
    """Create Android adaptive icon components"""
    # Background (solid color)
    bg_image = Image.new('RGB', (432, 432), "#FAFAFA")
    
    # Foreground (main icon on transparent background)
    fg_image = Image.new('RGBA', (432, 432), (0, 0, 0, 0))
    main_icon = create_app_icon()
    # Scale down and center the main icon for foreground
    main_icon = main_icon.resize((300, 300), Image.Resampling.LANCZOS)
    fg_image.paste(main_icon, (66, 66))  # Center it
    
    # Monochrome version (for Android 13+ themed icons)
    mono_image = Image.new('RGBA', (432, 432), (0, 0, 0, 0))
    draw = ImageDraw.Draw(mono_image)
    
    # Simple monochrome clock
    center = 216
    radius = 120
    draw.ellipse([center-radius, center-radius, center+radius, center+radius], 
                 outline=(0, 0, 0, 255), width=12)
    
    # Clock hands
    draw.line([center, center, center + 60, center], fill=(0, 0, 0, 255), width=8)
    draw.line([center, center, center, center - 80], fill=(0, 0, 0, 255), width=6)
    
    return bg_image, fg_image, mono_image

def main():
    # Create assets directory
    assets_dir = "/Users/edsteine/AndroidStudioProjects/deadhour/assets/images"
    os.makedirs(assets_dir, exist_ok=True)
    
    print("Creating DeadHour app icons...")
    
    # Create main app icon
    main_icon = create_app_icon()
    main_icon.save(f"{assets_dir}/ic_launcher.png", "PNG")
    print("✓ Created ic_launcher.png")
    
    # Create splash screen image (smaller version)
    splash_icon = main_icon.resize((300, 300), Image.Resampling.LANCZOS)
    splash_icon.save(f"{assets_dir}/output.png", "PNG")
    print("✓ Created output.png (splash screen)")
    
    # Create adaptive icons for Android
    bg_image, fg_image, mono_image = create_adaptive_icons()
    bg_image.save(f"{assets_dir}/ic_launcher_background.png", "PNG")
    fg_image.save(f"{assets_dir}/ic_launcher_foreground.png", "PNG")
    mono_image.save(f"{assets_dir}/ic_launcher_monochrome.png", "PNG")
    print("✓ Created Android adaptive icons")
    
    print("\nAll icons created successfully!")
    print("Now run the following commands to generate the app icons:")
    print("1. dart run flutter_launcher_icons")
    print("2. dart run flutter_native_splash:create")

if __name__ == "__main__":
    main()