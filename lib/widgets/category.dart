import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_shop/services/utils.dart';

import '../models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      height: size.height / 3,
      width: size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Utils(context).appTheme ? Colors.grey[800] : Colors.grey[400],
      ),
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height / 4.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(category.imgPath!),
              ),
            ),
          ),
          Text(
            category.name!,
            style: GoogleFonts.lato(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
