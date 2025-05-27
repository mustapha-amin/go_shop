import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/extensions.dart';
import 'package:go_shop/features/bottom_nav/providers/product_notifier.dart';
import 'package:go_shop/features/cart/controller/cart_controller.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/shared/flushbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import '../widgets/widgets.dart';

class DetailScreen extends ConsumerStatefulWidget {
  static const route = '/detail';
  final String id;
  const DetailScreen({required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  late TextEditingController _quantityController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _initializeQuantity(Product product) {
    if (!_isInitialized) {
      final cartNotifier = ref.read(cartControllerProvider.notifier);
      if (cartNotifier.itemInCart(product.id)) {
        _quantityController.text =
            cartNotifier.quantityInCart(product.id).toString();
      }
      _isInitialized = true;
    }
  }

  void _incrementQuantity(int maxQuantity) {
    setState(() {
      int current = int.tryParse(_quantityController.text) ?? 1;
      if (current < maxQuantity) {
        _quantityController.text = (current + 1).toString();
      } else {
        displayFlushBar(
          context,
          "You have reached the maximum quantity",
          isError: true,
        );
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      int current = int.tryParse(_quantityController.text) ?? 1;
      if (current > 1) {
        _quantityController.text = (current - 1).toString();
      }
    });
  }

  void _handleCartAction(CartItem cartItem) {
    final cartNotifier = ref.read(cartControllerProvider.notifier);
    final quantity = int.tryParse(_quantityController.text) ?? 1;

    if (!cartNotifier.itemInCart(cartItem.productID!)) {
      // Add to cart
      cartNotifier.addItem(cartItem);
      displayFlushBar(context, "Product added to cart");
    } else {
      // Update cart
      cartNotifier.updateItem(cartItem);
      displayFlushBar(context, "Cart updated");
    }
    setState(() {}); // Refresh button text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        bottomOpacity: 0,
      ),
      body: ref
          .watch(getProductByIDProvider(widget.id))
          .when(
            data: (product) {
              _initializeQuantity(product);
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ProductCarousel(productImages: product.imageUrls),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("In stock: ${product.quantity}"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ShadIconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Iconsax.minus_copy,
                                          size: 20,
                                        ),
                                        onPressed: _decrementQuantity,
                                      ),
                                      SizedBox(width: 8),
                                      SizedBox(
                                        width: 40,
                                        height: 32,
                                        child: TextField(
                                          onTapOutside: (_) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          controller: _quantityController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  vertical: 4,
                                                ),
                                          ),
                                          onChanged: (val) {
                                            setState(() {
                                              if (val.isEmpty ||
                                                  int.tryParse(val) == null) {
                                                _quantityController.text = '1';
                                              } else if (int.parse(val) >
                                                  product.quantity) {
                                                _quantityController.text =
                                                    product.quantity.toString();
                                                displayFlushBar(
                                                  context,
                                                  "Cannot exceed available stock",
                                                  isError: true,
                                                );
                                              } else if (int.parse(val) < 1) {
                                                _quantityController.text = '1';
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      ShadIconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(Iconsax.add_copy, size: 20),
                                        onPressed:
                                            () => _incrementQuantity(
                                              product.quantity,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                product.description,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          product.basePrice.toMoney,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ref
                          .watch(cartControllerProvider)
                          .when(
                            data: (cart) {
                              final cartNotifier = ref.read(
                                cartControllerProvider.notifier,
                              );
                              final isInCart = cartNotifier.itemInCart(
                                product.id,
                              );
                              final cartQuantity =
                                  isInCart
                                      ? cartNotifier.quantityInCart(product.id)
                                      : 0;
                              final currentQuantity =
                                  int.tryParse(_quantityController.text) ?? 1;
                              final buttonText =
                                  isInCart
                                      ? (currentQuantity == cartQuantity
                                          ? "Product in cart"
                                          : "Update cart")
                                      : "Add to Cart";

                              return ShadButton(
                                padding: EdgeInsets.all(10),
                                onPressed:
                                    () => _handleCartAction(
                                      isInCart
                                          ? CartItem(
                                            id:
                                                cart
                                                    .firstWhere(
                                                      (item) =>
                                                          item.productID ==
                                                          product.id,
                                                    )
                                                    .id,
                                            productID: product.id,
                                            quantity: currentQuantity,
                                          )
                                          : CartItem(
                                            id: const Uuid().v4(),
                                            productID: product.id,
                                            quantity: currentQuantity,
                                          ),
                                    ),
                                leading: Badge.count(
                                  count: currentQuantity,
                                  textColor: Theme.of(context).primaryColor,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Iconsax.shopping_cart_copy,
                                    size: 25,
                                  ),
                                ),
                                child: Text(
                                  buttonText,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              );
                            },
                            error:
                                (e, _) => ShadButton(
                                  padding: EdgeInsets.all(10),
                                  onPressed: () {},
                                  leading: Badge.count(
                                    count:
                                        int.tryParse(
                                          _quantityController.text,
                                        ) ??
                                        1,
                                    textColor: Theme.of(context).primaryColor,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Iconsax.shopping_cart_copy,
                                      size: 25,
                                    ),
                                  ),
                                  child: Text(
                                    "Error",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                            loading:
                                () => ShadButton(
                                  padding: EdgeInsets.all(10),
                                  onPressed: () {},
                                  leading: Badge.count(
                                    count:
                                        int.tryParse(
                                          _quantityController.text,
                                        ) ??
                                        1,
                                    textColor: Theme.of(context).primaryColor,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Iconsax.shopping_cart_copy,
                                      size: 25,
                                    ),
                                  ),
                                  child: Text(
                                    "Loading...",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                          ),
                    ],
                  ).padAll(8),
                ],
              ).padY(5);
            },
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            loading: () => SkeletalDetail(),
          ),
    );
  }
}
