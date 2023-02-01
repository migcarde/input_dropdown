import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularPainterDropdown extends CustomPainter {
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final bool hasBorderTop;

  const CircularPainterDropdown({
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.backgroundColor,
    required this.hasBorderTop,
  });

  static const _zeroValue = 0.0;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final radius = borderRadius > size.height ? size.height / 2 : borderRadius;
    final point1 = size.height - radius;
    final point2 = size.width - radius;
    final point3 = _zeroValue - borderRadius;

    if (!hasBorderTop) {
      final whitePath = Path();
      whitePath
        ..moveTo(size.width, point3)
        ..quadraticBezierTo(size.width, _zeroValue, point2, _zeroValue)
        ..lineTo(radius, _zeroValue)
        ..quadraticBezierTo(_zeroValue, _zeroValue, _zeroValue, point3);

      canvas.drawPath(
        whitePath,
        Paint()
          ..color = backgroundColor
          ..strokeWidth = borderWidth + 1.0
          ..style = PaintingStyle.stroke,
      );
    }

    path
      ..moveTo(_zeroValue, point3)
      ..lineTo(_zeroValue, point1)
      ..quadraticBezierTo(_zeroValue, size.height, radius, size.height)
      ..lineTo(point2, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, point1)
      ..lineTo(size.width, point3);

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
