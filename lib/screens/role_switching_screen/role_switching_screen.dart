



import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';






class RoleSwitchingScreen extends StatefulWidget {
  const RoleSwitchingScreen({super.key});

  @override
  State<RoleSwitchingScreen> createState() => _RoleSwitchingScreenState();
}

class _RoleSwitchingScreenState extends State<RoleSwitchingScreen>
    with TickerProviderStateMixin {
  final _analyticsService = AnalyticsService();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Current user roles (mock data - in production would come from auth service)
  final Set<UserRole> _activeRoles = {UserRole.consumer};
  UserRole _primaryRole = UserRole.consumer;
  UserRole? _pendingRole;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
    return Scaffold(
      appBar: const DeadHourAppBar(
        title: 'Role Management',
        subtitle: 'Switch between your active roles',
        showBackButton: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoleCurrentRolesSection(
                activeRoles: _activeRoles,
                primaryRole: _primaryRole,
              ),
              const SizedBox(height: AppTheme.spacing24),
              RolePrimarySelector(
                activeRoles: _activeRoles,
                primaryRole: _primaryRole,
                onPrimaryRoleChanged: _handlePrimaryRoleChanged,
              ),
              const SizedBox(height: AppTheme.spacing24),
              RoleAvailableRolesSection(
                activeRoles: _activeRoles,
                pendingRole: _pendingRole,
                onRoleAction: _handleRoleAction,
              ),
              const SizedBox(height: AppTheme.spacing24),
              const RoleStackingBenefits(),
              const SizedBox(height: AppTheme.spacing24),
              RoleQuickSwitch(
                activeRoles: _activeRoles,
                primaryRole: _primaryRole,
                onQuickSwitch: _switchToPrimaryRole,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePrimaryRoleChanged(UserRole role) {
    setState(() {
      _primaryRole = role;
    });
    _analyticsService.trackRoleUsage(
      'primary_role_changed',
      activeRoles: _activeRoles.map((r) => r.toString()).toList(),
      primaryRole: role.toString(),
    );
  }

  Future<void> _handleRoleAction(UserRole role, bool isActive) async {
    setState(() {
      _pendingRole = role;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (isActive) {
      // Remove role
      if (_activeRoles.length > 1) {
        setState(() {
          _activeRoles.remove(role);
          if (_primaryRole == role) {
            _primaryRole = _activeRoles.first;
          }
        });
        
        _analyticsService.trackRoleUsage(
          'role_removed',
          activeRoles: _activeRoles.map((r) => r.toString()).toList(),
          switchedFromRole: role.toString(),
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${role.toString().split('.').last} role removed')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You must have at least one active role')),
          );
        }
      }
    } else {
      // Add role
      setState(() {
        _activeRoles.add(role);
      });
      
      _analyticsService.trackRoleUsage(
        'role_added',
        activeRoles: _activeRoles.map((r) => r.toString()).toList(),
        switchedToRole: role.toString(),
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${role.toString().split('.').last} role added successfully!')),
        );
      }
    }

    setState(() {
      _pendingRole = null;
    });
  }

  void _switchToPrimaryRole(UserRole role) {
    if (role != _primaryRole) {
      setState(() {
        _primaryRole = role;
      });
      
      _analyticsService.trackRoleUsage(
        'quick_switch',
        activeRoles: _activeRoles.map((r) => r.toString()).toList(),
        switchedToRole: role.toString(),
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Switched to ${role.toString().split('.').last} mode')),
      );
    }
  }
}