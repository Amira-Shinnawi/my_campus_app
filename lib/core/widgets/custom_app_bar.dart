import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

/// Custom reusable AppBar following the SoftTaqwa design system.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title text to display in the app bar.
  final String title;

  /// Optional list of action widgets.
  final List<Widget>? actions;

  /// Optional leading widget (e.g. back button).
  final Widget? leading;

  /// Whether the title should be centered.
  final bool centerTitle;
  final bool? isBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.isBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyles.headlineMedium),
      centerTitle: centerTitle,
      leading: isBack == true
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () {
                context.pop();
              },
            )
          : leading,
      actions: actions,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.surface,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);
}
