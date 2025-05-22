import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      height: 100.h,
      width: 100.w,
      child: Center(
        child: SpinKitThreeBounce(size: 50, color: Colors.blue[900]!),
      ),
    );
  }
}
