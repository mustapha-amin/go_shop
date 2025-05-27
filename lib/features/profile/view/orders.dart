import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/bottom_nav/providers/product_notifier.dart';
import 'package:go_shop/features/profile/controllers/order_controller.dart';
import 'package:go_shop/features/profile/view/order_items_screen.dart';
import 'package:go_shop/features/profile/view/profile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersScreen extends ConsumerWidget {
  static const route = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: kTextStyle(18, fontweight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ref
          .watch(fetchOrdersProvider)
          .when(
            data: (orders) {
              if (orders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final rest = order.items.length - 1;
                  final extraRemark = rest > 0 ? ' + $rest more' : '';
                  return ref
                      .watch(
                        getProductByIDProvider(order.items.first.productID),
                      )
                      .when(
                        data: (product) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.imageUrls[0],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              '${product.name} $extraRemark',
                              style: kTextStyle(14),
                            ),
                            subtitle: Text(
                              'Total: ${NumberFormat.simpleCurrency().format(order.totalAmount)}',
                            ),
                            trailing: Text(
                              order.status,
                              style: kTextStyle(12, color: Colors.green),
                            ),
                            onTap: () {
                              context.push(
                                ProfileScreen.route +
                                    OrdersScreen.route +
                                    OrderItemsScreen.route,
                                extra: order.items,
                              );
                            },
                          );
                        },
                        loading:
                            () =>
                                Skeletonizer(child: Text("Loading product...")),
                        error: (error, stack) => Text('Error: $error'),
                      );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
    );
  }
}
