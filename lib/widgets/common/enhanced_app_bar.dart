import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/theme.dart';

class EnhancedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool showGradient;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;

  const EnhancedAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.showBackButton = false,
    this.onBackPressed,
    this.centerTitle = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.showGradient = false,
    this.flexibleSpace,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBackgroundColor =
        backgroundColor ?? (showGradient ? null : AppTheme.cardColor);
    final defaultForegroundColor = foregroundColor ?? AppTheme.primaryText;

    return AppBar(
      title: _buildTitle(),
      leading: _buildLeading(context),
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: defaultBackgroundColor,
      foregroundColor: defaultForegroundColor,
      elevation: elevation,
      systemOverlayStyle: _getSystemOverlayStyle(),
      flexibleSpace: showGradient ? _buildGradientBackground() : flexibleSpace,
      bottom: bottom,
      shape: elevation > 0
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            )
          : null,
    );
  }

  Widget _buildTitle() {
    if (subtitle != null) {
      return Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: showGradient ? Colors.white : AppTheme.primaryText,
            ),
          ),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: showGradient
                  ? Colors.white.withValues(alpha: 0.9)
                  : AppTheme.secondaryText,
            ),
          ),
        ],
      );
    }

    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: showGradient ? Colors.white : AppTheme.primaryText,
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showBackButton) {
      return IconButton(
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: showGradient ? Colors.white : AppTheme.primaryText,
        ),
      );
    }

    return null;
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  SystemUiOverlayStyle _getSystemOverlayStyle() {
    if (showGradient) {
      return SystemUiOverlayStyle.light;
    }
    return SystemUiOverlayStyle.dark;
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}

class SliverEnhancedAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final bool pinned;
  final bool floating;
  final bool snap;
  final double expandedHeight;
  final Widget? flexibleSpace;
  final Widget? background;

  const SliverEnhancedAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.showBackButton = false,
    this.onBackPressed,
    this.centerTitle = false,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.expandedHeight = 200,
    this.flexibleSpace,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: _buildTitle(),
      leading: _buildLeading(context),
      actions: actions,
      centerTitle: centerTitle,
      pinned: pinned,
      floating: floating,
      snap: snap,
      expandedHeight: expandedHeight,
      backgroundColor: AppTheme.moroccoGreen,
      foregroundColor: Colors.white,
      flexibleSpace: flexibleSpace ?? _buildDefaultFlexibleSpace(),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _buildTitle() {
    if (subtitle != null) {
      return Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      );
    }

    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showBackButton) {
      return IconButton(
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      );
    }

    return null;
  }

  Widget _buildDefaultFlexibleSpace() {
    return FlexibleSpaceBar(
      background: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          if (background != null) background!,
          // Morocco pattern overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/400/300?random=10',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final bool showBadge;
  final String? badgeText;
  final Color? badgeColor;

  const AppBarAction({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.showBadge = false,
    this.badgeText,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconButton = IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      tooltip: tooltip,
    );

    if (showBadge) {
      return Stack(
        children: [
          iconButton,
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: badgeColor ?? AppColors.error,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                badgeText ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return iconButton;
  }
}

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClosed;
  final List<Widget>? actions;

  const SearchAppBar({
    super.key,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClosed,
    this.actions,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.cardColor,
      elevation: 0,
      leading: IconButton(
        onPressed: widget.onClosed ?? () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: AppTheme.lightText,
            fontSize: 16,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: AppTheme.primaryText,
        ),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
      ),
      actions: [
        if (_controller.text.isNotEmpty)
          IconButton(
            onPressed: () {
              _controller.clear();
              widget.onChanged?.call('');
            },
            icon: const Icon(Icons.clear),
          ),
        ...?widget.actions,
      ],
    );
  }
}
