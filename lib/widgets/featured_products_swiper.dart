import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/models/featured_products.dart';
import 'package:go_shop/screen/inner_screens/product_detail.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/widgets/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../constants/consts.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key});

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  final SwiperController swiperController = SwiperController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<List<FeaturedProduct>?>(context);
    return products!.isEmpty
        ? ShimmerWidget(
            height: 30.h,
            width: 38.w,
          )
        : Swiper(
            autoplay: true,
            index: index,
            onIndexChanged: (newIndex) {
              products.length == 1 ? null : index = newIndex;
            },
            itemCount: products.length,
            controller: swiperController,
            curve: Curves.easeInOutQuart,
            duration: 600,
            pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.amber,
                size: 3.w,
                activeSize: 3.w,
              ),
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 98.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            end: Alignment.topRight,
                            colors: [
                              Colors.green[500]!.withOpacity(0.9),
                              Colors.amber.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 8,
                      width: 60.w,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          products[index].message!,
                          style: kTextStyle(
                            size: 23,
                            color: Colors.white,
                            isBold: true,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 3,
                      child: Hero(
                        tag: "${products[index].product!.id!}featured",
                        child: Image.network(
                          products[index].product!.imgPath!,
                          width: 40.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5.sp,
                      left: 18.sp,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          minimumSize: Size(3.4.w, 6.h),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          log(products[index].product!.imgPath.toString());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductDetail(
                              product: products[index].product,
                              heroTag: "${products[index].product!.id}featured",
                            );
                          }));
                        },
                        child: Text(
                          "Shop now",
                          style: kTextStyle(size: 15),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }
}
