import 'package:flutter/material.dart';

/// Represents a single feature tile in the home screen grid.
class HomeFeatureItem {
  /// Display title/label of the feature (e.g. Notices, Classes).
  final String title;

  /// Icon representing the feature.
  final IconData icon;

  /// Primary color theme for the feature icon and background tint.
  final Color color;

  /// Route destination path for navigation when tapped.
  final String route;

  const HomeFeatureItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
