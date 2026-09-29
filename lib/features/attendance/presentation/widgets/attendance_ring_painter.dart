import 'dart:math' as math;
import 'package:flutter/material.dart';

/// CustomPainter that renders a smooth gradient circular attendance ring chart.
class AttendanceRingPainter extends CustomPainter {
  /// Percentage progress value (0.0 to 1.0).
  final double progress;

  /// Main arc stroke color.
  final Color strokeColor;

  /// Background track color.
  final Color trackColor;

  /// Width of stroke line.
  final double strokeWidth;

  const AttendanceRingPainter({
    required this.progress,
    required this.strokeColor,
    required this.trackColor,
    this.strokeWidth = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = (size.width - strokeWidth) / 2.0;

    // Draw background track
    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    // Draw active progress arc
    if (progress > 0) {
      final Paint progressPaint = Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;

      final double startAngle = -math.pi / 2.0; // Top center
      final double sweepAngle = 2.0 * math.pi * progress.clamp(0.0, 1.0);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AttendanceRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
