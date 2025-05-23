import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/bottom_nav/providers/product_notifier.dart';
import 'package:go_shop/features/cart/controller/cart_controller.dart';
import 'package:go_shop/features/cart/widgets/skeletal_cart_item.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends ConsumerWidget {
  static const route = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(cartControllerProvider)
        .when(
          data: (cart) {
            return Scaffold(
              appBar: AppBar(title: Text('Cart')),
              body:
                  cart.isEmpty
                      ? Center(
                        child: Text(
                          'Your cart is empty',
                          style: kTextStyle(15),
                        ),
                      )
                      : ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final cartItem = cart[index];
                          return ref
                              .watch(
                                getProductByIDProvider(cartItem.productID!),
                              )
                              .when(
                                data: (product) {
                                  return ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            product.imageUrls[0],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    title: Row(
                                      spacing: 3,
                                      children: [
                                        Text(
                                          product.name,
                                          style: kTextStyle(15),
                                        ),
                                        Text(
                                          "(${cartItem.quantity})",
                                          style: kTextStyle(
                                            18,
                                            fontweight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text('N${product.basePrice}'),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Iconsax.minus_cirlce_copy,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        showShadDialog(
                                          context: context,
                                          builder: (context) {
                                            return ShadDialog(
                                              radius: BorderRadius.circular(20),
                                              constraints: BoxConstraints(
                                                maxWidth: 80.w,
                                              ),
                                              actionsAxis: Axis.horizontal,
                                              title: Text('Remove item'),
                                              actions: [
                                                Expanded(
                                                  child: ShadButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ShadButton(
                                                    backgroundColor:
                                                        Colors.red[50],
                                                    foregroundColor:
                                                        Colors.red[500],
                                                    onPressed: () {
                                                      ref
                                                          .read(
                                                            cartControllerProvider
                                                                .notifier,
                                                          )
                                                          .removeItem(
                                                            cartItem.id!,
                                                          );
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Remove'),
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
                                },
                                error: (e, _) {
                                  return ListTile(
                                    title: Text('Error loading product'),
                                    subtitle: Text('N ----}'),
                                    trailing: IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        // ref
                                        //     .read(cartControllerProvider.notifier)
                                        //     .removeItem(cartItem.id!);
                                      },
                                    ),
                                  );
                                },
                                loading: () {
                                  return Skeletonizer(
                                    effect: SoldColorEffect(
                                      color: Colors.grey.shade300,
                                    ),
                                    child: ListTile(
                                      title: Container(
                                        height: 20,
                                        width: 100,
                                        color: Colors.black,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 50,
                                        color: Colors.black,
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                },
                              );
                        },
                      ),
            );
          },
          error: (error, stackTrace) => Center(child: Text('Error')),
          loading: () {
            return SkeletalCartItem();
          },
        );
  }
}
