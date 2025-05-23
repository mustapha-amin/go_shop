import 'package:flutter/material.dart';
import 'package:go_shop/models/product.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletalDetail extends StatelessWidget {
  const SkeletalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: SoldColorEffect(color: Colors.grey.shade300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 100.w, height: 40.h, color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dummyProduct.name,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      dummyProduct.description,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'N${dummyProduct.basePrice}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ShadButton(
                leading: Icon(Icons.add_shopping_cart),
                child: Text('Add to Cart'),
                onPressed: () {
                  // Add to cart action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
