import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/providers.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:skeletonizer/skeletonizer.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff7f7f7),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imageUrls[0]),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name, style: kTextStyle(14)),
              Text(
                intl.NumberFormat.simpleCurrency(
                  name: 'N',
                ).format(product.basePrice),
                style: kTextStyle(16, fontweight: FontWeight.w600),
              ),
              Row(
                spacing: 4,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        product.category,
                        style: kTextStyle(
                          12,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  ref
                      .watch(currentUserNotifierProvider)
                      .when(
                        data: (user) {
                          return InkWell(
                            onTap: () {
                              ref
                                  .read(currentUserNotifierProvider.notifier)
                                  .updateCart(product.id);
                            },
                            child: Icon(
                              user.cart.contains(product.id)
                                  ? Iconsax.heart
                                  : Iconsax.heart_copy,
                              size: 25,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                        error: (e, _) {
                          return Icon(Iconsax.heart_copy, size: 25);
                        },
                        loading: () {
                          return Skeleton.leaf(child: Icon(Iconsax.heart));
                        },
                      ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
