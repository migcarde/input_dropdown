library input_dropdown;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_dropdown/common/enums/icon_function.dart';
import 'package:input_dropdown/common/enums/icon_position.dart';
import 'package:input_dropdown/widgets/dropdown_icon.dart';
import 'package:input_dropdown/widgets/dropdown_overlay.dart';
import 'package:input_dropdown/widgets/models/dropdown_decoration.dart';

class InputDropdown<T> extends StatelessWidget {
  const InputDropdown({
    super.key,
    required this.showDropdownButton,
    required this.onSendItem,
    required this.onSubmitInput,
    required this.items,
    required this.inputBoxDecoration,
    this.maxLines = 1,
    this.iconPosition = IconPosition.end,
    this.executeFunction = IconFunction.tapIcon,
    this.insetPadding = const EdgeInsets.only(
      left: _defaultInputPaddingLeft,
    ),
    this.textHint,
    this.textStyle,
    this.hideDropdownButton,
    this.inputFormatter,
    this.dropdownOffset = 0.0,
    this.mouseCursor,
    this.inputController,
  });

  final int maxLines;
  final Icon showDropdownButton;
  final IconPosition iconPosition;
  final IconFunction executeFunction;
  final List<T> items;
  final Function(T) onSendItem;
  final Function(String) onSubmitInput;
  final double dropdownOffset;
  final DropdownDecoration inputBoxDecoration;
  final String? textHint;
  final TextStyle? textStyle;
  final EdgeInsets insetPadding;
  final List<TextInputFormatter>? inputFormatter;
  final Icon? hideDropdownButton;
  final MouseCursor? mouseCursor;
  final TextEditingController? inputController;

  static const _defaultInputPaddingLeft = 10.0;
  static const _inputPaddingLeftOnIconStart = 20.0;

  @override
  Widget build(BuildContext context) {
    OverlayEntry? overlayEntry;
    OverlayState? overlayState = Overlay.of(context);
    final layerLink = LayerLink();
    final inputController = this.inputController ?? TextEditingController();

    return CompositedTransformTarget(
      link: layerLink,
      child: ClipPath(
        clipper: inputBoxDecoration.clipper,
        child: Container(
          padding: EdgeInsets.all(inputBoxDecoration.borderWidth),
          color: inputBoxDecoration.backgroundColor,
          child: CustomPaint(
            painter: inputBoxDecoration.painterForInputDecoration,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TextField(
                    maxLines: maxLines,
                    style: textStyle,
                    inputFormatters: inputFormatter,
                    controller: inputController..text,
                    onSubmitted: (value) => onSubmitInput(value),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: iconPosition.isStart
                          ? insetPadding.add(
                              EdgeInsets.only(
                                left: showDropdownButton.size ??
                                    _inputPaddingLeftOnIconStart,
                              ),
                            )
                          : insetPadding,
                      hintText: textHint,
                      hintStyle: textStyle,
                      labelStyle: textStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Align(
                  alignment: iconPosition.isStart
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: DropdownIcon(
                    icon: showDropdownButton,
                    mouseCursor: mouseCursor,
                    onFunction: (isExpanded) => overlayEntry = _showOverlay(
                      context: context,
                      layerLink: layerLink,
                      overlayEntry: overlayEntry,
                      overlayState: overlayState,
                      show: isExpanded,
                      dropdownDecoration: inputBoxDecoration,
                      onTapItem: (index) {
                        final item = items[index];
                        inputController.text = item.toString();
                        onSendItem(item);
                        overlayEntry?.remove();
                      },
                      onMouseLeaveList: () => executeFunction.isHover
                          ? overlayEntry?.remove()
                          : null,
                    ),
                    functionTrigger: executeFunction.dropdownButtonIconTrigger,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry? _showOverlay({
    required BuildContext context,
    required LayerLink layerLink,
    required OverlayEntry? overlayEntry,
    required OverlayState? overlayState,
    required bool show,
    required Function(int) onTapItem,
    required VoidCallback onMouseLeaveList,
    required DropdownDecoration dropdownDecoration,
  }) {
    if (show && overlayState != null) {
      final newOverlayEntry = DropdownOverlay<T>().create(
        context: context,
        layerLink: layerLink,
        items: items,
        itemTextStyle: textStyle,
        itemPadding: insetPadding,
        dropdownDecoration: dropdownDecoration,
        onSelectItem: (index) {
          onTapItem(index);
        },
        onMouseLeaveList: () => onMouseLeaveList(),
        offset: dropdownOffset,
      );
      overlayState.insert(newOverlayEntry);

      return newOverlayEntry;
    } else {
      overlayEntry?.remove();

      return null;
    }
  }
}
