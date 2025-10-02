import 'package:flutter/material.dart';
import 'package:go_shop/core/extensions.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/home/widgets/product_card.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/shared/simple_grid.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletalHome extends StatelessWidget {
  const SkeletalHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: SoldColorEffect(color: Colors.grey[300]!),
      child: Column(
        spacing: 10,
        children: [
          SizedBox(
            height: 45,
            child: SearchBar(
              padding: WidgetStatePropertyAll(EdgeInsets.all(3)),
              elevation: WidgetStatePropertyAll(0),
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              backgroundColor: WidgetStatePropertyAll(Color(0xfffff7f7f7)),
              hintText: "Search products",
              hintStyle: WidgetStatePropertyAll(
                kTextStyle(16, color: Colors.grey),
              ),
              leading: Icon(Iconsax.search_normal_1_copy, size: 20).padX(7),
            ),
          ),
          Expanded(
            child: SimpleGrid(
              gap: 2,
              columns: 2,
              children: [
                ...List.generate(10, (_) {
                  return ProductCard(product: dummyProduct);
                }),
              ],
            ),
          ),
        ],
      ).padX(14),
    );
  }
}
