import 'dart:math' as $math;
import 'dart:ui' as $ui;

import 'package:flutter/widgets.dart';

const _2pi = $math.pi * 2;

class CometIndicator extends StatefulWidget {
  const CometIndicator({
    Key? key,
    this.duration = const Duration(seconds: 1),
    required this.baseColor,
    required this.radius,
    this.strokeWidth = 1,
    this.indicatorRatio = 1,
    this.showsDot = true,
    this.dotRadius = 2,
  }) : super(key: key);

  final Duration duration;
  final Color baseColor;
  final double radius;
  final double strokeWidth;
  final double indicatorRatio;
  final bool showsDot;
  final double dotRadius;

  @override
  State<StatefulWidget> createState() => _CometIndicatorState();
}

class _CometIndicatorState extends State<CometIndicator>
    with SingleTickerProviderStateMixin<CometIndicator> {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: _2pi,
    )..repeat(period: widget.duration);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
    _animationController = null;
  }

  @override
  Widget build(BuildContext context) {
    assert(_animationController != null);

    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationController!.value,
          child: child,
        );
      },
      child: CustomPaint(
        painter: _CometIndicatorPainer(
          baseColor: widget.baseColor,
          radius: widget.radius,
          strokeWidth: widget.strokeWidth,
          indicatorRatio: widget.indicatorRatio,
          showsDot: widget.showsDot,
          dotRadius: widget.dotRadius,
        ),
      ),
    );
  }
}

class _CometIndicatorPainer extends CustomPainter {
  const _CometIndicatorPainer({
    required this.baseColor,
    required this.radius,
    required this.strokeWidth,
    required this.indicatorRatio,
    required this.showsDot,
    required this.dotRadius,
  });

  final Color baseColor;
  final double radius;
  final double strokeWidth;
  final double indicatorRatio;
  final bool showsDot;
  final double dotRadius;

  @override
  void paint(Canvas canvas, Size size) {
    assert(indicatorRatio <= 1.0 && indicatorRatio >= 0);

    final strokePaint = Paint();
    strokePaint.shader = $ui.Gradient.sweep(
      Offset.zero,
      [
        baseColor.withOpacity(0),
        baseColor,
      ],
      null,
      TileMode.clamp,
      _2pi - _2pi * indicatorRatio,
      _2pi,
    );
    strokePaint.style = $ui.PaintingStyle.stroke;
    strokePaint.strokeWidth = strokeWidth;
    canvas.drawCircle(Offset.zero, radius, strokePaint);

    final dotPaint = Paint();
    dotPaint.color = baseColor;
    canvas.drawCircle(Offset(radius, 0), dotRadius, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
