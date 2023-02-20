import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:input_dropdown/common/constants/dimens.dart';

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

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final radius = borderRadius > size.height ? size.height / 2 : borderRadius;
    final point1 = size.height - radius;
    final point2 = size.width - radius;
    final point3 = Dimens.zeroValue - borderRadius;

    path
      ..moveTo(Dimens.zeroValue, point3)
      ..lineTo(Dimens.zeroValue, point1)
      ..quadraticBezierTo(Dimens.zeroValue, size.height, radius, size.height)
      ..lineTo(point2, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, point1)
      ..lineTo(size.width, point3)
      ..quadraticBezierTo(
          size.width, Dimens.zeroValue, point2, Dimens.zeroValue)
      ..lineTo(radius, Dimens.zeroValue)
      ..quadraticBezierTo(
          Dimens.zeroValue, Dimens.zeroValue, Dimens.zeroValue, point3);

    canvas.drawPath(path, Paint()..color = backgroundColor);
    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );

    if (!hasBorderTop) {
      final repaintBorderPath = Path();
      repaintBorderPath
        ..moveTo(size.width, point3)
        ..quadraticBezierTo(
            size.width, Dimens.zeroValue, point2, Dimens.zeroValue)
        ..lineTo(radius, Dimens.zeroValue)
        ..quadraticBezierTo(
            Dimens.zeroValue, Dimens.zeroValue, Dimens.zeroValue, point3);

      canvas.drawPath(
        repaintBorderPath,
        Paint()
          ..color = Colors.black
          ..strokeWidth = borderWidth
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
