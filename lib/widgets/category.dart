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
      padding: const EdgeInsets.all(5),
      height: size.height / 3,
      width: size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color:  Colors.grey[400],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(category.imgPath!),
                  filterQuality: FilterQuality.high,
                  
                ),
                borderRadius: BorderRadius.circular(6),
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
