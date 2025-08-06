import 'package:flutter/material.dart';
import 'dart:math' as math;

class LightningAnimation extends StatefulWidget {
  const LightningAnimation({super.key});

  @override
  State<LightningAnimation> createState() => _LightningAnimationState();
}

class _LightningAnimationState extends State<LightningAnimation>
    with TickerProviderStateMixin {
  late AnimationController _lightningController;
  late AnimationController _glowController;
  late Animation<double> _lightningAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _lightningController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _lightningAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _lightningController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _startAnimation();
  }

  void _startAnimation() {
    _lightningController.repeat(reverse: true);
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _lightningController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: Listenable.merge([_lightningController, _glowController]),
          builder: (context, child) {
            return CustomPaint(
              painter: LightningPainter(
                lightningProgress: _lightningAnimation.value,
                glowProgress: _glowAnimation.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class LightningPainter extends CustomPainter {
  final double lightningProgress;
  final double glowProgress;

  LightningPainter({
    required this.lightningProgress,
    required this.glowProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD32F2F).withOpacity(0.6)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = const Color(0xFFD32F2F).withOpacity(0.2 * glowProgress)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw small lightning bolts in corners
    _drawLightning(
      canvas,
      size,
      paint,
      glowPaint,
      0.1,
      0.1,
      0.3,
      0.4,
    );
    _drawLightning(
      canvas,
      size,
      paint,
      glowPaint,
      0.8,
      0.1,
      0.9,
      0.4,
    );
    _drawLightning(
      canvas,
      size,
      paint,
      glowPaint,
      0.5,
      0.0,
      0.6,
      0.3,
    );
  }

  void _drawLightning(
    Canvas canvas,
    Size size,
    Paint paint,
    Paint glowPaint,
    double startX,
    double startY,
    double endX,
    double endY,
  ) {
    final path = Path();
    final glowPath = Path();

    final startPoint = Offset(size.width * startX, size.height * startY);
    final endPoint = Offset(size.width * endX, size.height * endY);

    final points = _generateLightningPoints(startPoint, endPoint, 6);

    path.moveTo(points.first.dx, points.first.dy);
    glowPath.moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
      glowPath.lineTo(points[i].dx, points[i].dy);
    }

    // Draw glow effect
    canvas.drawPath(glowPath, glowPaint);

    // Draw main lightning with animation
    final animatedPath = Path();
    animatedPath.moveTo(points.first.dx, points.first.dy);

    final segmentCount = points.length - 1;
    final visibleSegments = (segmentCount * lightningProgress).floor();

    for (int i = 1; i <= visibleSegments && i < points.length; i++) {
      animatedPath.lineTo(points[i].dx, points[i].dy);
    }

    // Add partial segment for smooth animation
    if (visibleSegments < segmentCount) {
      final progress = lightningProgress * segmentCount - visibleSegments;
      final currentPoint = points[visibleSegments];
      final nextPoint = points[visibleSegments + 1];
      final interpolatedPoint = Offset(
        currentPoint.dx + (nextPoint.dx - currentPoint.dx) * progress,
        currentPoint.dy + (nextPoint.dy - currentPoint.dy) * progress,
      );
      animatedPath.lineTo(interpolatedPoint.dx, interpolatedPoint.dy);
    }

    canvas.drawPath(animatedPath, paint);
  }

  List<Offset> _generateLightningPoints(
    Offset start,
    Offset end,
    int segments,
  ) {
    final points = <Offset>[start];
    final random = math.Random(42); // Fixed seed for consistent animation

    for (int i = 1; i < segments; i++) {
      final progress = i / segments;
      final baseX = start.dx + (end.dx - start.dx) * progress;
      final baseY = start.dy + (end.dy - start.dy) * progress;

      // Add some randomness to create lightning effect
      final offsetX = (random.nextDouble() - 0.5) * 30;
      final offsetY = (random.nextDouble() - 0.5) * 20;

      points.add(Offset(baseX + offsetX, baseY + offsetY));
    }

    points.add(end);
    return points;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
