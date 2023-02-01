import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularPainter extends CustomPainter {
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final bool hasBorderBottom;
  final bool hasBorderTop;

  const CircularPainter({
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.hasBorderBottom,
    required this.hasBorderTop,
  });

  static const _zeroValue = 0.0;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final point2 = borderRadius > size.height ? size.height / 2 : borderRadius;
    final point1 = hasBorderBottom ? size.height - point2 : size.height;

    final point3 = hasBorderBottom ? size.width - point2 : size.width;

    if (hasBorderBottom) {
      path
        ..moveTo(_zeroValue, point2)
        ..lineTo(_zeroValue, point1)
        ..quadraticBezierTo(_zeroValue, size.height, point2, size.height)
        ..lineTo(point3, size.height)
        ..quadraticBezierTo(size.width, size.height, size.width, point1);
    } else {
      path
        ..lineTo(_zeroValue, point1)
        ..moveTo(size.width, size.height)
        ..lineTo(size.height, 0);
    }

    if (hasBorderTop) {
      path
        ..lineTo(size.width, point2)
        ..quadraticBezierTo(size.width, _zeroValue, point3, _zeroValue)
        ..lineTo(point2, _zeroValue)
        ..quadraticBezierTo(_zeroValue, _zeroValue, _zeroValue, point2);
    } else {
      path
        ..lineTo(size.height, _zeroValue)
        ..lineTo(_zeroValue, _zeroValue);
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
