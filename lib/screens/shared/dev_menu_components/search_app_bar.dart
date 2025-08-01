import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

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