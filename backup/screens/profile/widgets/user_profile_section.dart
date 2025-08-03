import 'package:flutter/material.dart';
import '../../../models/user.dart';
import '../../../utils/theme.dart';
import '../profile_screen_helpers.dart';

class UserProfileSection extends StatelessWidget {
  final DeadHourUser? currentUser;

  const UserProfileSection({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                child: currentUser!.profileImageUrl != null
                    ? ClipOval(
                        child: Image.network(currentUser!.profileImageUrl!,
                            fit: BoxFit.cover))
                    : Text(
                        currentUser!.name.substring(0, 2).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser!.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currentUser!.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppTheme.secondaryText,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          currentUser!.city,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => ProfileScreenHelpers.editProfile(context),
                icon: const Icon(Icons.edit, color: AppTheme.moroccoGreen),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProfileStat('Active Roles',
                    currentUser!.activeRoles.length.toString()),
                _buildProfileStat(
                    'Member Since',
                    ProfileScreenHelpers.formatMemberSince(
                        currentUser!.joinDate)),
                _buildProfileStat('Active Roles',
                    currentUser!.activeRoles.length.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}