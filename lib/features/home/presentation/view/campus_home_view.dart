import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../messages/presentation/views/conversations_list_view.dart';
import '../../../notices/presentation/views/notices_list_view.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_banner_card.dart';
import '../widgets/home_bottom_nav_bar.dart';
import '../widgets/home_features_grid.dart';

/// Main Campus Home View displaying the primary user dashboard and bottom tab navigation shell.
class CampusHomeView extends StatefulWidget {
  /// Initial tab index to display.
  final int initialIndex;

  const CampusHomeView({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<CampusHomeView> createState() => _CampusHomeViewState();
}

class _CampusHomeViewState extends State<CampusHomeView> {
  late int _currentNavIndex;

  @override
  void initState() {
    super.initState();
    _currentNavIndex = widget.initialIndex;
  }

  void _onNavTabSelected(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  void _onNotificationPressed() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
   
  }

  Widget _buildBody() {
    switch (_currentNavIndex) {
      case 1:
        return const NoticesListView();
      case 2:
        return const ConversationsListView();
      case 3:
        return const ProfileView();
      case 0:
      default:
        return _HomeDashboardTab(
          onNotificationPressed: _onNotificationPressed,
          onTabSelected: _onNavTabSelected,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildBody(),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTabSelected,
      ),
    );
  }
}

/// Private helper widget rendering the primary Home Dashboard tab content.
class _HomeDashboardTab extends StatelessWidget {
  final VoidCallback onNotificationPressed;
  final ValueChanged<int> onTabSelected;

  const _HomeDashboardTab({
    required this.onNotificationPressed,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: HomeAppBar(
        onNotificationTap: onNotificationPressed,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
          vertical: AppSizes.p12,
        ),
        child: Column(
          children: <Widget>[
            const HomeBannerCard(studentName: 'Amira'),
            const SizedBox(height: AppSizes.p24),
            HomeFeaturesGrid(
              onTabSelected: onTabSelected,
            ),
            const SizedBox(height: AppSizes.p16),
          ],
        ),
      ),
    );
  }
}
