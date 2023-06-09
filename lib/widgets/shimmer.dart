import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatefulWidget {
  double? width, height;
  ShimmerWidget({this.height, this.width});

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 700),
      baseColor: Colors.grey[600]!,
      highlightColor: Colors.grey[500]!,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey,
          borderRadius:BorderRadius.circular(5),
        ),
      ),
    );
  }
}
