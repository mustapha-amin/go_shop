import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/services/utils.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitFadingCircle(
            duration: Duration(milliseconds: 500),
            size: 60,
            color: Colors.black,
          ),
          Text(
            "Please wait",
            style: kTextStyle(
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
