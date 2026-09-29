import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_info_tile.dart';

/// Main screen view displaying student profile details and preferences.
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (BuildContext context) => sl<ProfileCubit>()..fetchProfile(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(title: 'Student Profile', isBack: false),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (BuildContext context, ProfileState state) {
            if (state is ProfileLoading) {
              return const LoadingWidget();
            }

            if (state is ProfileError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.p24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline_rounded,
                        color: AppColors.error,
                        size: AppSizes.iconXl,
                      ),
                      const SizedBox(height: AppSizes.p16),
                      Text(
                        state.message,
                        style: AppTextStyles.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.p24),
                      CustomButton(
                        text: 'Retry',
                        onPressed: () {
                          context.read<ProfileCubit>().fetchProfile();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileLoaded) {
              final profile = state.profile;

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  await context.read<ProfileCubit>().fetchProfile();
                },
                child: ListView(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  children: <Widget>[
                    // Top Header Card
                    ProfileHeaderCard(profile: profile),
                    const SizedBox(height: AppSizes.p8),

                    // Section: Academic Details
                    Text(
                      'Academic Details',
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.p12),
                    ProfileInfoTile(
                      icon: Icons.school_rounded,
                      label: 'Faculty',
                      value: profile.faculty,
                    ),
                    ProfileInfoTile(
                      icon: Icons.account_tree_rounded,
                      label: 'Department',
                      value: profile.department,
                    ),
                    ProfileInfoTile(
                      icon: Icons.grade_rounded,
                      label: 'Academic Level',
                      value: profile.level,
                    ),
                    ProfileInfoTile(
                      icon: Icons.email_rounded,
                      label: 'Student Email',
                      value: profile.email,
                    ),
                    const SizedBox(height: AppSizes.p16),

                    // Section: Settings & Preferences
                    Text(
                      'Preferences',
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.p12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p16,
                        vertical: AppSizes.p4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.notifications_none_rounded,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: AppSizes.p12),
                              Text(
                                'Campus Notifications',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: _notificationsEnabled,
                            activeTrackColor: AppColors.primary,
                            onChanged: (bool value) {
                              setState(() {
                                _notificationsEnabled = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.p24),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSizes.p16),

                    // Logout Button
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Student Session Signed Out'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        minimumSize: const Size.fromHeight(48.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: AppColors.error,
                      ),
                      label: Text(
                        'Log Out',
                        style: AppTextStyles.buttonText.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
