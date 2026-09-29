import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_campus_app/core/router/app_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/home_feature_item.dart';
import 'home_feature_card.dart';

/// Grid view displaying campus feature options in a 3-column layout.
class HomeFeaturesGrid extends StatelessWidget {
  /// Default list of campus features.
  static final List<HomeFeatureItem> defaultFeatures = <HomeFeatureItem>[
    const HomeFeatureItem(
      title: 'Notices',
      icon: Icons.campaign_rounded,
      color: Color(0xFFE53935),
      route: AppRouter.noticesPath,
    ),
    const HomeFeatureItem(
      title: 'Classes',
      icon: Icons.class_rounded,
      color: Color(0xFF1E88E5),
      route: AppRouter.classesPath,
    ),
    const HomeFeatureItem(
      title: 'Attendance',
      icon: Icons.fact_check_rounded,
      color: Color(0xFF43A047),
      route: AppRouter.attendancePath,
    ),
    const HomeFeatureItem(
      title: 'Results',
      icon: Icons.workspace_premium_rounded,
      color: Color(0xFFFB8C00),
      route: AppRouter.resultsPath,
    ),
    const HomeFeatureItem(
      title: 'Assignments',
      icon: Icons.assignment_rounded,
      color: Color(0xFF8E24AA),
      route: AppRouter.assignmentsPath,
    ),
    const HomeFeatureItem(
      title: 'Events',
      icon: Icons.event_rounded,
      color: Color(0xFF00ACC1),
      route: AppRouter.eventsPath,
    ),

    const HomeFeatureItem(
      title: 'Profile',
      icon: Icons.person_4_rounded,
      color: Color(0xFFD81B60),
      route: AppRouter.profilePath,
    ),
    const HomeFeatureItem(
      title: 'Messages',
      icon: Icons.chat_rounded,
      color: Color(0xFF00897B),
      route: AppRouter.messagesPath,
    ),
  ];

  /// Optional features list override.
  final List<HomeFeatureItem>? features;

  /// Optional callback to select bottom nav tab index.
  final ValueChanged<int>? onTabSelected;

  const HomeFeaturesGrid({
    super.key,
    this.features,
    this.onTabSelected,
  });

  void _onFeatureTap(BuildContext context, HomeFeatureItem item) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (onTabSelected != null) {
      if (item.route == AppRouter.noticesPath) {
        onTabSelected!(1);
        return;
      }
      if (item.route == AppRouter.messagesPath) {
        onTabSelected!(2);
        return;
      }
      if (item.route == AppRouter.profilePath) {
        onTabSelected!(3);
        return;
      }
    }

    context.push(item.route);
  }

  @override
  Widget build(BuildContext context) {
    final List<HomeFeatureItem> items = features ?? defaultFeatures;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Quick Access',
              style: AppTextStyles.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.p12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSizes.p12,
            mainAxisSpacing: AppSizes.p12,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (BuildContext context, int index) {
            final HomeFeatureItem item = items[index];
            return HomeFeatureCard(
              item: item,
              onTap: () => _onFeatureTap(context, item),
            );
          },
        ),
      ],
    );
  }
}
