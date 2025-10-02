import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/bottom_nav/providers/product_notifier.dart';
import 'package:go_shop/features/cart/controller/cart_controller.dart';
import 'package:go_shop/features/cart/controller/payment_controller.dart';
import 'package:go_shop/features/cart/widgets/cart_item_tile.dart';
import 'package:go_shop/features/cart/widgets/skeletal_cart_item.dart';
import 'package:go_shop/models/order_item.dart';
import 'package:go_shop/models/payment_status.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/shared/flushbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

final selectedItemsProvider = StateProvider((ref) {
  return <String>[];
});

final selectedProductsPriceProvider = StateProvider((ref) {
  return 0.0;
});

final orderitemsProvider = StateProvider((ref) {
  return <OrderItem>[];
});

void updateOrderItems(WidgetRef ref, Product product, int? quantity) {
  final containsProduct = ref
      .read(orderitemsProvider.notifier)
      .state
      .any((order) => order.productID == product.id);
  if (containsProduct) {
    ref.read(orderitemsProvider.notifier).state =
        ref
            .read(orderitemsProvider)
            .where((order) => order.productID != product.id)
            .toList();
  } else {
    final newOrderItem = OrderItem(
      productID: product.id,
      quantity: quantity!,
      price: product.basePrice * quantity,
    );
    ref.read(orderitemsProvider.notifier).state = [
      ...ref.read(orderitemsProvider),
      newOrderItem,
    ];
  }
}

class CartScreen extends ConsumerStatefulWidget {
  static const route = '/cart';
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(paymentNotifierProvider, (_, next) {
      if (next is PaymentSuccess) {
        ref.invalidate(paymentNotifierProvider);
        ref.invalidate(orderitemsProvider);
        ref.invalidate(selectedItemsProvider);
        ref.invalidate(selectedProductsPriceProvider);
        ref.invalidate(cartControllerProvider);
      } else if (next is PaymentFailed) {
        displayFlushBar(context, next.error, isError: true);
        ref.invalidate(paymentNotifierProvider);
        ref.invalidate(orderitemsProvider);
        ref.invalidate(selectedItemsProvider);
        ref.invalidate(selectedProductsPriceProvider);
      }
    });
    return ref
        .watch(cartControllerProvider)
        .when(
          data: (cart) {
            return cart.isEmpty
                ? Center(
                  child: Text('Your cart is empty', style: kTextStyle(15)),
                )
                : Column(
                  children: [
                    Text(
                      "Your Cart",
                      style: kTextStyle(20, fontweight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final cartItem = cart[index];
                          return ref
                              .watch(
                                getProductByIDProvider(cartItem.productID!),
                              )
                              .when(
                                data: (product) {
                                  return Row(
                                    children: [
                                      Consumer(
                                        builder: (context, ref, _) {
                                          return Checkbox(
                                            value: ref
                                                .watch(selectedItemsProvider)
                                                .contains(cartItem.id),
                                            onChanged: (_) {
                                              if (ref
                                                  .read(selectedItemsProvider)
                                                  .contains(cartItem.id)) {
                                                ref
                                                    .read(
                                                      selectedProductsPriceProvider
                                                          .notifier,
                                                    )
                                                    .state = ref
                                                        .read(
                                                          selectedProductsPriceProvider
                                                              .notifier,
                                                        )
                                                        .state -
                                                    product.basePrice *
                                                        cartItem.quantity!;
                                                updateOrderItems(
                                                  ref,
                                                  product,
                                                  cartItem.quantity!,
                                                );
                                                ref
                                                    .read(
                                                      selectedItemsProvider
                                                          .notifier,
                                                    )
                                                    .state = ref
                                                        .read(
                                                          selectedItemsProvider,
                                                        )
                                                        .where(
                                                          (id) =>
                                                              id != cartItem.id,
                                                        )
                                                        .toList();
                                              } else {
                                                ref
                                                    .read(
                                                      selectedProductsPriceProvider
                                                          .notifier,
                                                    )
                                                    .state = ref
                                                        .read(
                                                          selectedProductsPriceProvider
                                                              .notifier,
                                                        )
                                                        .state +
                                                    product.basePrice *
                                                        cartItem.quantity!;
                                                updateOrderItems(
                                                  ref,
                                                  product,
                                                  cartItem.quantity!,
                                                );
                                                ref
                                                    .read(
                                                      selectedItemsProvider
                                                          .notifier,
                                                    )
                                                    .state = [
                                                  ...ref
                                                      .read(
                                                        selectedItemsProvider
                                                            .notifier,
                                                      )
                                                      .state,
                                                  cartItem.id!,
                                                ];
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      Expanded(
                                        child: CartItemTile(
                                          cartItem: cartItem,
                                          product: product,
                                        ),
                                      ),
                                    ],
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
                    ),
                  ],
                );
          },
          error: (error, stackTrace) => Center(child: Text('Error')),
          loading: () {
            return SkeletalCartItem();
          },
        );
  }
}
