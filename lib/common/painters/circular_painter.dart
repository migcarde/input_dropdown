import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:input_dropdown/common/constants/dimens.dart';

class CircularPainter extends CustomPainter {
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;

  const CircularPainter({
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
  });

  static const _zeroValue = 0.0;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final radius = borderRadius > size.height ? size.height / 2 : borderRadius;
    final point1 = size.height - radius;

    final point3 = size.width - radius;

    path
      ..moveTo(_zeroValue, radius)
      ..lineTo(_zeroValue, point1)
      ..quadraticBezierTo(_zeroValue, size.height, radius, size.height)
      ..lineTo(point3, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, point1)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(
          size.width, Dimens.zeroValue, point3, Dimens.zeroValue)
      ..lineTo(radius, Dimens.zeroValue)
      ..quadraticBezierTo(
          Dimens.zeroValue, Dimens.zeroValue, Dimens.zeroValue, radius);

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
