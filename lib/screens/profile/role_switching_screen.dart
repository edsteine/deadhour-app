import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../widgets/common/dead_hour_app_bar.dart';
import '../../models/user.dart';
import '../../services/analytics_service.dart';

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

  final Map<UserRole, Map<String, dynamic>> _roleData = {
    UserRole.consumer: {
      'title': 'Consumer',
      'subtitle': 'Discover deals and experiences',
      'icon': Icons.shopping_bag,
      'color': Colors.blue,
      'price': 'Free',
      'features': [
        'Browse and book deals',
        'Join community rooms',
        'Access to local recommendations',
        'Basic cultural calendar',
      ],
      'description': 'Perfect for tourists and locals looking for great deals during dead hours.',
    },
    UserRole.business: {
      'title': 'Business',
      'subtitle': 'Optimize revenue during dead hours',
      'icon': Icons.business,
      'color': AppTheme.moroccoGreen,
      'price': '€30/month',
      'features': [
        'Create and manage deals',
        'Revenue analytics dashboard',
        'Customer engagement tools',
        'Dead hours optimization',
        'Community integration',
      ],
      'description': 'Ideal for restaurant owners, café managers, and venue operators.',
    },
    UserRole.guide: {
      'title': 'Local Guide',
      'subtitle': 'Share expertise and earn',
      'icon': Icons.person_pin,
      'color': Colors.orange,
      'price': '€20/month',
      'features': [
        'Create cultural experiences',
        'Guide booking management',
        'Expert recommendations',
        'Commission earnings',
        'Cultural content creation',
      ],
      'description': 'Perfect for local experts, cultural ambassadors, and tour guides.',
    },
    UserRole.premium: {
      'title': 'Premium',
      'subtitle': 'Enhanced features across all roles',
      'icon': Icons.star,
      'color': Colors.amber,
      'price': '€15/month',
      'features': [
        'Priority booking access',
        'Advanced analytics',
        'Multiple role discounts',
        'Premium customer support',
        'Early access to new features',
      ],
      'description': 'Upgrade that enhances all your active roles with premium benefits.',
    },
  };

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
              _buildCurrentRolesSection(),
              const SizedBox(height: AppTheme.spacing24),
              _buildPrimaryRoleSelector(),
              const SizedBox(height: AppTheme.spacing24),
              _buildAvailableRolesSection(),
              const SizedBox(height: AppTheme.spacing24),
              _buildRoleStacking(),
              const SizedBox(height: AppTheme.spacing24),
              _buildQuickSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentRolesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Your Active Roles',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Active roles display
            Wrap(
              spacing: AppTheme.spacing8,
              runSpacing: AppTheme.spacing8,
              children: _activeRoles.map((role) {
                final roleInfo = _roleData[role]!;
                final isPrimary = role == _primaryRole;
                
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing12,
                    vertical: AppTheme.spacing8,
                  ),
                  decoration: BoxDecoration(
                    color: isPrimary 
                        ? (roleInfo['color'] as Color).withValues(alpha: 0.2)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    border: Border.all(
                      color: isPrimary 
                          ? (roleInfo['color'] as Color)
                          : Colors.grey.withValues(alpha: 0.3),
                      width: isPrimary ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        roleInfo['icon'] as IconData,
                        size: 16,
                        color: roleInfo['color'] as Color,
                      ),
                      const SizedBox(width: AppTheme.spacing8),
                      Text(
                        roleInfo['title'] as String,
                        style: TextStyle(
                          fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
                          color: isPrimary 
                              ? (roleInfo['color'] as Color)
                              : Colors.grey[700],
                        ),
                      ),
                      if (isPrimary) ...[
                        const SizedBox(width: AppTheme.spacing4),
                        Icon(
                          Icons.star,
                          size: 12,
                          color: roleInfo['color'] as Color,
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Revenue and benefits summary
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, color: AppTheme.moroccoGreen),
                      const SizedBox(width: AppTheme.spacing8),
                      const Text(
                        'Monthly Value',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        '€${_calculateTotalMonthlyValue()}',
                        style: const TextStyle(
                          color: AppTheme.moroccoGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    'You\'re maximizing value with ${_activeRoles.length} role${_activeRoles.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryRoleSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Primary Role',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Your primary role determines your default app experience',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Primary role selector
            ...UserRole.values.where((role) => _activeRoles.contains(role)).map((role) {
              final roleInfo = _roleData[role]!;
              final isSelected = role == _primaryRole;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
                child: RadioListTile<UserRole>(
                  value: role,
                  groupValue: _primaryRole,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _primaryRole = value;
                      });
                      _analyticsService.trackRoleUsage(
                        'primary_role_changed',
                        activeRoles: _activeRoles.map((r) => r.toString()).toList(),
                        primaryRole: value.toString(),
                      );
                    }
                  },
                  title: Row(
                    children: [
                      Icon(
                        roleInfo['icon'] as IconData,
                        color: roleInfo['color'] as Color,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacing8),
                      Text(
                        roleInfo['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  subtitle: Text(roleInfo['subtitle'] as String),
                  activeColor: AppTheme.moroccoGreen,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableRolesSection() {
    final inactiveRoles = UserRole.values
        .where((role) => !_activeRoles.contains(role))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add More Roles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        ...inactiveRoles.map((role) => Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
          child: _buildRoleCard(role, isActive: false),
        )),
      ],
    );
  }

  Widget _buildRoleCard(UserRole role, {required bool isActive}) {
    final roleInfo = _roleData[role]!;
    final isPending = _pendingRole == role;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing8),
                  decoration: BoxDecoration(
                    color: (roleInfo['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: Icon(
                    roleInfo['icon'] as IconData,
                    color: roleInfo['color'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            roleInfo['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacing8,
                              vertical: AppTheme.spacing4,
                            ),
                            decoration: BoxDecoration(
                              color: (roleInfo['color'] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              roleInfo['price'] as String,
                              style: TextStyle(
                                color: roleInfo['color'] as Color,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        roleInfo['subtitle'] as String,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              roleInfo['description'] as String,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            
            // Features list
            ...((roleInfo['features'] as List<String>).take(3).map((feature) =>
              Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: roleInfo['color'] as Color,
                      size: 16,
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            
            if ((roleInfo['features'] as List<String>).length > 3) ...[
              const SizedBox(height: AppTheme.spacing4),
              Text(
                '+${(roleInfo['features'] as List<String>).length - 3} more features',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isPending ? null : () => _handleRoleAction(role, isActive),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive ? Colors.red : (roleInfo['color'] as Color),
                  foregroundColor: Colors.white,
                ),
                child: isPending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(isActive ? 'Remove Role' : 'Add Role'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleStacking() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.layers,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Role Stacking Benefits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Stacking examples
            _buildStackingExample(
              'Business + Guide',
              'Venue owner who offers cultural tours',
              '€45/month',
              '€50/month',
              Icons.business,
              Icons.person_pin,
            ),
            
            const SizedBox(height: AppTheme.spacing12),
            
            _buildStackingExample(
              'Business + Premium',
              'Enhanced analytics and priority support',
              '€40/month',
              '€45/month',
              Icons.business,
              Icons.star,
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Text(
                      'Save money by combining roles! Multi-role users get automatic discounts.',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStackingExample(
    String combination,
    String description,
    String bundlePrice,
    String originalPrice,
    IconData icon1,
    IconData icon2,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Icon(icon1, color: AppTheme.moroccoGreen, size: 20),
              const SizedBox(width: AppTheme.spacing4),
              const Icon(Icons.add, color: Colors.grey, size: 16),
              const SizedBox(width: AppTheme.spacing4),
              Icon(icon2, color: Colors.orange, size: 20),
            ],
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  combination,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                bundlePrice,
                style: const TextStyle(
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                originalPrice,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSwitch() {
    if (_activeRoles.length <= 1) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.swap_horiz,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Quick Switch',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Quickly switch your primary role experience',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            Row(
              children: _activeRoles.map((role) {
                final roleInfo = _roleData[role]!;
                final isPrimary = role == _primaryRole;
                
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppTheme.spacing8),
                    child: GestureDetector(
                      onTap: () => _switchToPrimaryRole(role),
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacing12),
                        decoration: BoxDecoration(
                          color: isPrimary
                              ? (roleInfo['color'] as Color).withValues(alpha: 0.2)
                              : Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          border: Border.all(
                            color: isPrimary
                                ? (roleInfo['color'] as Color)
                                : Colors.grey.withValues(alpha: 0.3),
                            width: isPrimary ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              roleInfo['icon'] as IconData,
                              color: roleInfo['color'] as Color,
                              size: 24,
                            ),
                            const SizedBox(height: AppTheme.spacing4),
                            Text(
                              roleInfo['title'] as String,
                              style: TextStyle(
                                fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
                                fontSize: 12,
                                color: isPrimary
                                    ? (roleInfo['color'] as Color)
                                    : Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
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
            SnackBar(content: Text('${_roleData[role]!['title']} role removed')),
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
          SnackBar(content: Text('${_roleData[role]!['title']} role added successfully!')),
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
        SnackBar(content: Text('Switched to ${_roleData[role]!['title']} mode')),
      );
    }
  }

  int _calculateTotalMonthlyValue() {
    int total = 0;
    for (final role in _activeRoles) {
      final price = _roleData[role]!['price'] as String;
      if (price.contains('€')) {
        final amount = int.tryParse(price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        total += amount;
      }
    }
    
    // Apply multi-role discount
    if (_activeRoles.length > 1) {
      total = (total * 0.9).round(); // 10% multi-role discount
    }
    
    return total;
  }
}