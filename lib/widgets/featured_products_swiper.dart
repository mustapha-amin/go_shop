import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/models/featured_products.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/widgets/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../constants/consts.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key});

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  final SwiperController swiperController = SwiperController();
  late Stream<List<FeaturedProduct>> featuredProducts;
  int index = 0;

  @override
  void initState() {
    featuredProducts = DatabaseService().getFeaturedProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FeaturedProduct>?>(
      stream: featuredProducts,
      builder: (context, snapshot) {
        List<FeaturedProduct>? products = snapshot.data!;
        return Swiper(
          index: index,
          onIndexChanged: (newIndex) {
            index = newIndex;
          },
          itemCount: products.length,
          controller: swiperController,
          curve: Curves.easeInOutQuart,
          pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
              activeColor: Colors.amber,
            ),
          ),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  color: Colors.green[800]!.withOpacity(0.9),
                  width: 100.w,
                  height: 30.h,
                ),
                // Container(
                //   width: 20.w,
                //   height: 40.h,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.amber,
                //   ),
                // ),
                Positioned(
                  top: 2,
                  left: 3,
                  width: 60.w,
                  child: Text(
                    products[index].message!,
                    style: kTextStyle(
                      size: 23,
                      color: Colors.white,
                      isBold: true,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 3,
                  child: Image.network(
                    products[index].product!.imgPath!,
                    width: 40.w,
                    height: 20.h,
                    colorBlendMode: BlendMode.color,
                    frameBuilder: (context, child, frame, _) {
                      if (frame == null) {
                        // fallback to placeholder
                        return ShimmerWidget(
                          height: 20.h,
                          width: 40.w,
                        );
                      }
                      return child;
                    },
                  ),
                ),
                Positioned(
                  bottom: 3,
                  left: 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Shop now",
                      style: kTextStyle(size: 13),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
