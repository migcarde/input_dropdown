import 'package:flutter/material.dart';
import 'package:input_dropdown/common/clippers/circular_clipper.dart';
import 'package:input_dropdown/common/clippers/dropdown_circular_clipper.dart';
import 'package:input_dropdown/common/painters/circular_painter.dart';
import 'package:input_dropdown/common/painters/circular_painter_dropdown.dart';
import 'package:input_dropdown/common/painters/empty_painter.dart';
import 'package:input_dropdown/common/painters/rectangular_painter.dart';

enum DropdownDecorationType {
  none,
  rectangular,
  circular,
  custom,
}

extension DropdownDecorationTypeExtensions on DropdownDecorationType {
  get isCircular => this == DropdownDecorationType.circular;
}

class DropdownDecoration {
  final DropdownDecorationType type;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final bool hasBorderBottomOnExpand;
  final CustomPainter? painter;

  static const _zeroValue = 0.0;

  const DropdownDecoration({
    this.type = DropdownDecorationType.none,
    this.borderWidth = _zeroValue,
    this.borderRadius = _zeroValue,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.hasBorderBottomOnExpand = false,
    this.painter,
  });

  factory DropdownDecoration.none() => const DropdownDecoration();

  factory DropdownDecoration.rectangular({
    double? borderWidth,
    Color? borderColor,
    Color? backgroundColor,
    bool? hasBorderBottom,
  }) =>
      DropdownDecoration(
        type: DropdownDecorationType.rectangular,
        borderWidth: borderWidth ?? _zeroValue,
        borderColor: borderColor ?? Colors.black,
        backgroundColor: backgroundColor ?? Colors.transparent,
        hasBorderBottomOnExpand: hasBorderBottom ?? false,
      );

  factory DropdownDecoration.circular({
    double? borderWidth,
    double? borderRadius,
    Color? borderColor,
    Color? backgroundColor,
    bool? hasBorderBottomOnExpand,
  }) =>
      DropdownDecoration(
        type: DropdownDecorationType.circular,
        borderWidth: borderWidth ?? _zeroValue,
        borderRadius: borderRadius ?? _zeroValue,
        borderColor: borderColor ?? Colors.black,
        backgroundColor: backgroundColor ?? Colors.transparent,
        hasBorderBottomOnExpand: hasBorderBottomOnExpand ?? false,
      );

  factory DropdownDecoration.custom({
    CustomPainter? painter,
  }) =>
      DropdownDecoration(
        type: DropdownDecorationType.custom,
        painter: painter,
      );
}

extension DropdownDecorationExtensions on DropdownDecoration {
  CustomPainter get painterForInputDecoration {
    switch (type) {
      case DropdownDecorationType.none:
        return EmptyPainter();
      case DropdownDecorationType.rectangular:
        return RectangularPainter(
          borderWidth: borderWidth,
          borderColor: borderColor,
          hasBorderBottom: hasBorderBottomOnExpand,
          hasBorderTop: true,
        );
      case DropdownDecorationType.circular:
        return CircularPainter(
          borderWidth: borderWidth,
          borderRadius: borderRadius,
          borderColor: borderColor,
        );
      case DropdownDecorationType.custom:
        return painter ?? EmptyPainter();
    }
  }

  CustomPainter get painterForDropdownDecoration {
    switch (type) {
      case DropdownDecorationType.none:
        return EmptyPainter();
      case DropdownDecorationType.rectangular:
        return RectangularPainter(
          borderWidth: borderWidth,
          borderColor: borderColor,
          hasBorderBottom: hasBorderBottomOnExpand,
          hasBorderTop: true,
        );
      case DropdownDecorationType.circular:
        return CircularPainterDropdown(
          borderWidth: borderWidth,
          borderRadius: borderRadius,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          hasBorderTop: hasBorderBottomOnExpand,
        );
      case DropdownDecorationType.custom:
        return painter ?? EmptyPainter();
    }
  }

  CustomClipper<Path>? get clipperForInputDecoration {
    if (type.isCircular) {
      return CircularClipper(borderRadius: borderRadius);
    } else {
      return null;
    }
  }

  CustomClipper<Path>? get clipperForDropdown {
    if (type.isCircular) {
      return DropdownCircularClipper(borderRadius: borderRadius);
    } else {
      return null;
    }
  }
}
