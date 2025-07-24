import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class AnimatedBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double elevation;

  const AnimatedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8,
  });

  @override
  State<AnimatedBottomNavigationBar> createState() => _AnimatedBottomNavigationBarState();
}

class _AnimatedBottomNavigationBarState extends State<AnimatedBottomNavigationBar> with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );

    _animations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      );
    }).toList();

    // Animate the initially selected item
    _animationControllers[widget.currentIndex].forward();
  }

  @override
  void didUpdateWidget(AnimatedBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animationControllers[oldWidget.currentIndex].reverse();
      _animationControllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppTheme.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: widget.elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.currentIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => widget.onTap(index),
                  child: AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, child) {
                      return _buildNavItem(item, isSelected, _animations[index].value);
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BottomNavItem item, bool isSelected, double animationValue) {
    final selectedColor = widget.selectedItemColor ?? AppTheme.moroccoGreen;
    final unselectedColor = widget.unselectedItemColor ?? AppTheme.lightText;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? selectedColor.withValues(alpha: 0.1 * animationValue) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon with animation
          Stack(
            alignment: Alignment.center,
            children: [
              // Background circle animation
              if (isSelected)
                Transform.scale(
                  scale: animationValue,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: selectedColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              // Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.identity()..scale(isSelected ? 1.2 : 1.0),
                child: Icon(
                  isSelected ? item.activeIcon : item.icon,
                  color: isSelected ? selectedColor : unselectedColor,
                  size: 24,
                ),
              ),
              // Badge
              if (item.badge != null)
                Positioned(
                  right: 0,
                  top: 0,
                  child: _buildBadge(item.badge!),
                ),
            ],
          ),

          const SizedBox(height: 4),

          // Label with animation
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: isSelected ? 12 : 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? selectedColor : unselectedColor,
            ),
            child: Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BadgeData badge) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: badge.color ?? AppColors.error,
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(
        minWidth: 16,
        minHeight: 16,
      ),
      child: badge.text != null
          ? Text(
              badge.text!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          : null,
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final BadgeData? badge;

  const BottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.badge,
  });
}

class BadgeData {
  final String? text;
  final Color? color;

  const BadgeData({
    this.text,
    this.color,
  });
}

class FloatingBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const FloatingBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  State<FloatingBottomNavigationBar> createState() => _FloatingBottomNavigationBarState();
}

class _FloatingBottomNavigationBarState extends State<FloatingBottomNavigationBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 100 * (1 - _slideAnimation.value)),
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? AppTheme.cardColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: AppTheme.shadowColor,
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isSelected = index == widget.currentIndex;

                    return _buildFloatingNavItem(item, isSelected, index);
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingNavItem(BottomNavItem item, bool isSelected, int index) {
    final selectedColor = widget.selectedItemColor ?? AppTheme.moroccoGreen;
    final unselectedColor = widget.unselectedItemColor ?? AppTheme.lightText;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Icon(
                  isSelected ? item.activeIcon ?? item.icon : item.icon,
                  color: isSelected ? selectedColor : unselectedColor,
                  size: 24,
                ),
                if (item.badge != null)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: _buildBadge(item.badge!),
                  ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: selectedColor,
                ),
                child: Text(item.label),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(BadgeData badge) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: badge.color ?? AppColors.error,
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(
        minWidth: 12,
        minHeight: 12,
      ),
      child: badge.text != null
          ? Text(
              badge.text!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          : null,
    );
  }
}
