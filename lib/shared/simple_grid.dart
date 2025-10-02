import 'package:flutter/material.dart';

class SimpleGrid extends StatelessWidget {
  const SimpleGrid({
    super.key,
    required this.gap,
    required this.columns,
    required this.children,
  });

  final double gap;
  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final paintableWidth = constraints.maxWidth - gap * (columns - 1);

        return children.length == 1
            ? Row(
                children: [
                  SizedBox(
                    width: paintableWidth / columns,
                    child: children.first,
                  ),
                ],
              )
            : Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final x in children)
                    SizedBox(width: paintableWidth / columns, child: x),
                ],
              );
      },
    );
  }
}
