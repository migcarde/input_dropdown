import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:input_dropdown/common/constants/dimens.dart';
import 'package:input_dropdown/widgets/hoverable_item.dart';

//? Use extends for this class?
class DropdownOverlay<T> {
  OverlayEntry create({
    required BuildContext context,
    required LayerLink layerLink,
    required List<T> items,
    required TextStyle? itemTextStyle,
    required Function(int) onSelectItem,
    required VoidCallback onMouseLeaveList,
    double offset = 0.0,
    EdgeInsets? itemPadding,
    BoxDecoration? dropdownDecoration,
    BoxDecoration? itemDecoration,
    BoxDecoration? itemHoveredDecoration,
  }) {
    final dropdownInput = context.findRenderObject() as RenderBox;

    return OverlayEntry(
      builder: (overlayContext) => Positioned(
        width: dropdownInput.size.width,
        height: dropdownInput.size.height,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(Dimens.zeroValue, dropdownInput.size.height + offset),
          child: MouseRegion(
            onExit: (event) => onMouseLeaveList(),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (listContext, index) => HoverableItem(
                child: (isHovered) => GestureDetector(
                  onTap: () => onSelectItem(index),
                  child: Container(
                    decoration:
                        isHovered ? itemHoveredDecoration : itemDecoration,
                    child: Padding(
                      padding:
                          itemPadding ?? const EdgeInsets.all(Dimens.zeroValue),
                      child: Text(
                        items[index].toString(),
                        style: itemTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
