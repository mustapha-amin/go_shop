import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/cart/controller/cart_controller.dart';
import 'package:go_shop/features/cart/view/cart_screen.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/product.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

class CartItemTile extends ConsumerWidget {
  final CartItem cartItem;
  final Product product;
  const CartItemTile({
    required this.cartItem,
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(product.imageUrls[0]),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      title: Row(
        spacing: 3,
        children: [
          Text(product.name, style: kTextStyle(15)),
          Text(
            "(${cartItem.quantity})",
            style: kTextStyle(18, fontweight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Text(
        NumberFormat.simpleCurrency(
          name: 'N',
          decimalDigits: 0,
        ).format(product.basePrice),
      ),
      trailing: IconButton(
        icon: Icon(Iconsax.minus_cirlce_copy, size: 20, color: Colors.red),
        onPressed: () {
          showShadDialog(
            context: context,
            builder: (context) {
              return ShadDialog(
                radius: BorderRadius.circular(20),
                constraints: BoxConstraints(maxWidth: 80.w),
                actionsAxis: Axis.horizontal,
                title: Text('Remove item'),
                actions: [
                  Expanded(
                    child: ShadButton(
                      backgroundColor: Colors.red[50],
                      foregroundColor: Colors.red[500],
                      onPressed: () {
                        ref
                            .read(cartControllerProvider.notifier)
                            .removeItem(cartItem.id!);
                        ref.read(selectedProductsPriceProvider.notifier).state =
                            ref
                                .read(selectedProductsPriceProvider.notifier)
                                .state -
                            product.basePrice * cartItem.quantity!;
                        Navigator.pop(context);
                      },
                      child: Text('Remove'),
                    ),
                  ),
                  Expanded(
                    child: ShadButton.ghost(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                ],
                child: SizedBox(
                  width: 80.w,
                  child: Text(
                    'Are you sure you want to remove this item from your cart?',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
