import 'package:flutter/material.dart';
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
        children: [
          ...productImages.map(
            (imageUrl) => Container(
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
        ],
      ),
    );
  }
}
