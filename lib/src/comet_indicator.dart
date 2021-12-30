import 'dart:math' as $math;
import 'dart:ui' as $ui;

import 'package:flutter/widgets.dart';

class CometIndicator extends StatefulWidget {
  CometIndicator.simple({
    Key? key,
    Duration duration = const Duration(seconds: 1),
    required Color baseColor,
    required double radius,
    double strokeWidth = 1,
    double indicatorRatio = 1,
    bool showsDot = true,
    double dotRadius = 2,
  }) : this.custom(
          key: key,
          duration: duration,
          indicatorColors: [
            baseColor,
            baseColor.withOpacity(0),
          ],
          dotColor: baseColor,
          radius: radius,
          strokeWidth: strokeWidth,
          indicatorRatio: indicatorRatio,
          showsDot: showsDot,
          dotRadius: dotRadius,
        );

  const CometIndicator.custom({
    Key? key,
    this.duration = const Duration(seconds: 1),
    required this.indicatorColors,
    this.indicatorColorStops = const [0.0, 1.0],
    this.dotIcon,
    required this.dotColor,
    required this.radius,
    this.strokeWidth = 1,
    this.indicatorRatio = 1,
    this.showsDot = true,
    this.dotRadius = 2,
  })  : assert(indicatorRatio >= 0 && indicatorRatio <= 1.0),
        assert(indicatorColors.length == indicatorColorStops.length),
        super(key: key);

  final Duration duration;
  final List<Color> indicatorColors;
  final List<double> indicatorColorStops;
  final Icon? dotIcon;
  final Color dotColor;
  final double radius;
  final double strokeWidth;
  final double indicatorRatio;
  final bool showsDot;
  final double dotRadius;

  @override
  State<StatefulWidget> createState() => _CometIndicatorState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '''
    CometIndicator(
        key: $key,
        duration: $duration,
        indicatorColors: $indicatorColors,
        indicatorColorStops: $indicatorColorStops,
        dotIcon: $dotIcon,
        dotColor: $dotColor,
        radius: $radius,
        strokeWidth: $strokeWidth,
        indicatorRatio: $indicatorRatio,
        showsDot: $showsDot,
        dotRadius: $dotRadius, 
    )
    ''';
  }
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
      upperBound: $math.pi * 2,
    )..repeat(period: widget.duration);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(_animationController != null);

    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationController!.value,
          child: Center(
            child: child,
          ),
        );
      },
      child: CustomPaint(
        size: Size.fromRadius(widget.radius),
        painter: _CometIndicatorPainer(
          indicatorColors: widget.indicatorColors,
          indicatorColorStops: widget.indicatorColorStops,
          dotIcon: widget.dotIcon,
          dotColor: widget.dotColor,
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
    required this.indicatorColors,
    required this.indicatorColorStops,
    required this.dotIcon,
    required this.dotColor,
    required this.radius,
    required this.strokeWidth,
    required this.indicatorRatio,
    required this.showsDot,
    required this.dotRadius,
  });

  final List<Color> indicatorColors;
  final List<double> indicatorColorStops;
  final Icon? dotIcon;
  final Color dotColor;
  final double radius;
  final double strokeWidth;
  final double indicatorRatio;
  final bool showsDot;
  final double dotRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(radius, radius);
    final strokePaint = Paint();
    strokePaint.shader = $ui.Gradient.sweep(
      center,
      indicatorColors.reversed.toList(),
      indicatorColorStops,
      TileMode.clamp,
      $math.pi * 2 - $math.pi * 2 * indicatorRatio,
      $math.pi * 2,
    );
    strokePaint.style = $ui.PaintingStyle.stroke;
    strokePaint.strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, strokePaint);

    final dotOffset = Offset(radius * 2, radius);
    if (dotIcon?.icon != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(dotIcon!.icon!.codePoint),
          style: TextStyle(
            color: dotColor,
            fontSize: dotIcon!.size,
            fontFamily: dotIcon!.icon!.fontFamily,
            package: dotIcon!.icon!.fontPackage,
          ),
        ),
        textDirection: $ui.TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout(maxWidth: dotRadius);
      textPainter.paint(canvas, dotOffset);
    } else {
      final dotPaint = Paint();
      dotPaint.color = dotColor;
      canvas.drawCircle(dotOffset, dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
