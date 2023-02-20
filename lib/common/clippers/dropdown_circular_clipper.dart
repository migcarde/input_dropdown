import 'package:flutter/cupertino.dart';
import 'package:input_dropdown/common/constants/dimens.dart';

class DropdownCircularClipper extends CustomClipper<Path> {
  final double borderRadius;

  const DropdownCircularClipper({required this.borderRadius});

  @override
  Path getClip(Size size) {
    final radius = borderRadius > size.height ? size.height / 2 : borderRadius;

    return Path()
      ..lineTo(Dimens.zeroValue, size.height - radius)
      ..quadraticBezierTo(Dimens.zeroValue, size.height, radius, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, Dimens.zeroValue)
      ..lineTo(Dimens.zeroValue, Dimens.zeroValue);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
