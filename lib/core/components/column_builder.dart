import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final int itemCount;
  final bool row;

  const ColumnBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.row = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (row) {
      return Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        verticalDirection: verticalDirection,
        children:
            List.generate(itemCount, (index) => itemBuilder(context, index))
                .toList(),
      );
    }
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      children: List.generate(itemCount, (index) => itemBuilder(context, index))
          .toList(),
    );
  }
}
