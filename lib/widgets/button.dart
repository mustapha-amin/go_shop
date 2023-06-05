import 'package:flutter/material.dart';
import '../services/utils.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  double? width, height;
  VoidCallback? onTap;
  String? labelText;
  bool? isElevated;

  AppButton({
    this.width,
    this.height,
    this.onTap,
    this.labelText,
    this.isElevated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width,
      height: height,
      child: isElevated!
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onTap,
              child: Text(labelText!,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                  )),
            )
          : TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: onTap,
              child: Text(
                labelText!,
                style: kTextStyle(
                  18,
                  context,
                ),
              ),
            ),
    );
  }
}
