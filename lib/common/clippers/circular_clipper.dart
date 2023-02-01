import 'package:flutter/cupertino.dart';

class CircularClipper extends CustomClipper<Path> {
  final double borderRadius;

  const CircularClipper({required this.borderRadius});

  static const _zeroValue = 0.0;

  @override
  Path getClip(Size size) {
    final radius = borderRadius > size.height ? size.height / 2 : borderRadius;

    return Path()
      ..moveTo(_zeroValue, radius)
      ..lineTo(_zeroValue, size.height - radius)
      ..quadraticBezierTo(_zeroValue, size.height, radius, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(
          size.width, _zeroValue, size.width - radius, _zeroValue)
      ..lineTo(radius, _zeroValue)
      ..quadraticBezierTo(_zeroValue, _zeroValue, _zeroValue, radius);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
