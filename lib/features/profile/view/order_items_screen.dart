import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/bottom_nav/providers/product_notifier.dart';
import 'package:go_shop/models/order_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OrderItemsScreen extends ConsumerWidget {
  static const route = '/order-items';
  final List<OrderItem> orderItems;
  const OrderItemsScreen({required this.orderItems, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Items',
          style: kTextStyle(18, fontweight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:
              orderItems.map((item) {
                return ref
                    .watch(getProductByIDProvider(item.productID))
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
                            product.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Quantity: ${item.quantity}\nPrice: ${NumberFormat.simpleCurrency(name: 'N').format(item.price)}',
                          ),
                        );
                      },
                      error:
                          (error, stackTrace) =>
                              ListTile(title: Text('Error loading product')),
                      loading: () => const ListTile(title: Text('Loading...')),
                    );
              }).toList(),
        ),
      ),
    );
  }
}
