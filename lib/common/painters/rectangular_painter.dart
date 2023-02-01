import 'package:flutter/cupertino.dart';

class RectangularPainter extends CustomPainter {
  final double borderWidth;
  final Color borderColor;
  final bool hasBorderBottom;
  final bool hasBorderTop;

  const RectangularPainter({
    required this.borderWidth,
    required this.borderColor,
    required this.hasBorderBottom,
    required this.hasBorderTop,
  });

  static const _zeroValue = 0.0;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.lineTo(_zeroValue, size.height);

    if (hasBorderBottom) {
      path.lineTo(size.height, size.width);
    } else {
      path.moveTo(size.height, size.width);
    }

    path.lineTo(size.height, _zeroValue);

    if (hasBorderTop) {
      path.lineTo(_zeroValue, _zeroValue);
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
