import 'package:flutter/cupertino.dart';
import 'package:input_dropdown/common/constants/dimens.dart';

class CircularClipper extends CustomClipper<Path> {
  final double borderRadius;

  const CircularClipper({required this.borderRadius});

  @override
  Path getClip(Size size) {
    final radius = borderRadius > size.height ? size.height / 2 : borderRadius;

    return Path()
      ..moveTo(Dimens.zeroValue, radius)
      ..lineTo(Dimens.zeroValue, size.height - radius)
      ..quadraticBezierTo(Dimens.zeroValue, size.height, radius, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(
          size.width, Dimens.zeroValue, size.width - radius, Dimens.zeroValue)
      ..lineTo(radius, Dimens.zeroValue)
      ..quadraticBezierTo(
          Dimens.zeroValue, Dimens.zeroValue, Dimens.zeroValue, radius);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
