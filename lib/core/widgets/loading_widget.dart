import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Reusable centered loading indicator component.
class LoadingWidget extends StatelessWidget {
  /// Color of the loading indicator spinner.
  final Color? color;

  const LoadingWidget({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.primary,
        ),
      ),
    );
  }
}
