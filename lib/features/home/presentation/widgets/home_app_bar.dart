import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'notification_icon_badge.dart';

/// Top App Bar / Header component for the Home Screen.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Callback executed when notification bell is tapped.
  final VoidCallback? onNotificationTap;

  const HomeAppBar({
    super.key,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      titleSpacing: AppSizes.p16,
      title: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(AppSizes.p8),
            decoration: BoxDecoration(
              color: AppColors.softGreen,
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
            child: const Icon(
              Icons.school_rounded,
              color: AppColors.primary,
              size: AppSizes.iconMd,
            ),
          ),
          const SizedBox(width: AppSizes.p12),
          Text(
            'MyCampus',
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: AppSizes.p8),
          child: NotificationIconBadge(
            unreadCount: 3,
            onTap: onNotificationTap,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);
}
