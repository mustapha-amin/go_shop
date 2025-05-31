import 'package:flutter/material.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

class ProductCarousel extends StatelessWidget {
  final List<String> productImages;
  const ProductCarousel({required this.productImages, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: CarouselView(
        itemExtent: 100.w,
        itemSnapping: true,
        children: [
          ...productImages.map(
            (imageUrl) => Stack(
              children: [
                Hero(
                  tag: imageUrl,
                  child: Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.8),
                    ),
                    child: Text(
                      "${productImages.indexOf(imageUrl) + 1}/${productImages.length}",
                      style: kTextStyle(14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
