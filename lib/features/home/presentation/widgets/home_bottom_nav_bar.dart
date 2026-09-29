import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Bottom Navigation Bar component for the application shell.
class HomeBottomNavBar extends StatelessWidget {
  /// Current selected tab index.
  final int currentIndex;

  /// Callback triggered when a tab is selected.
  final ValueChanged<int>? onTap;

  const HomeBottomNavBar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.softGreen,
        elevation: 0.0,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: AppColors.textSecondary),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined, color: AppColors.textSecondary),
            selectedIcon: Icon(Icons.campaign_rounded, color: AppColors.primary),
            label: 'Notices',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textSecondary),
            selectedIcon: Icon(Icons.chat_bubble_rounded, color: AppColors.primary),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded, color: AppColors.textSecondary),
            selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
