import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/constants/extensions.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/models/order_model.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/screen/inner_screens/card_details_screen.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/cart_item.dart';
import '../../services/utils.dart';

class OrderScreen extends StatefulWidget {
  List<CartItem> items;
  OrderScreen({required this.items, super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? selectedState;
  String? selectedLGA;
  String? selectedPaymentMethod;
  List<String> paymentMethods = ["Card", "Bank transfer"];
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Customer>(context);
    int totalQty = widget.items
        .fold(0, (previousValue, element) => previousValue + element.quantity!);
    double totalPrice = widget.items.fold(
        0, (previousValue, element) => previousValue + element.totalPrice!);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Place your order"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer name: ${provider.name}",
                    style: kTextStyle(size: 15),
                  ),
                  Text(
                    "Items total: $totalQty",
                    style: kTextStyle(size: 15),
                  ),
                  Text(
                    "Total price: $nairaSymbol${totalPrice.toMoney}",
                    style: kTextStyle(size: 15),
                  ),
                  addVerticalSpacing(20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        elevation: 3,
                        value: selectedState,
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            selectedState = val;
                            selectedLGA = null;
                          });
                        },
                        hint: const Text('Select your state'),
                        items: NigerianStatesAndLGA.allStates
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  addVerticalSpacing(10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        elevation: 3,
                        value: selectedLGA,
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            selectedLGA = val;
                          });
                        },
                        hint: const Text('Select your LGA'),
                        items: selectedState == null
                            ? []
                            : NigerianStatesAndLGA.getStateLGAs(selectedState!)
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                      ),
                    ),
                  ),
                  addVerticalSpacing(10),
                  TextField(
                    controller: addressController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Enter your address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  addVerticalSpacing(10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        elevation: 3,
                        value: selectedPaymentMethod,
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            selectedPaymentMethod = val;
                          });
                        },
                        hint: const Text('Select payment method'),
                        items: paymentMethods
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100.w, 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                selectedState != null &&
                        selectedLGA != null &&
                        addressController.text.isNotEmpty
                    ? widget.items
                        .map((e) async => await DatabaseService()
                            .createAnOrder(
                              context,
                              Order(
                                productName: e.product!.name,
                                imgUrl: e.product!.imgPath,
                                customerID: AuthService().userid,
                                quantity: e.quantity,
                                price: e.totalPrice,
                                state: selectedState,
                                LGA: selectedLGA,
                                address: addressController.text.trim(),
                                orderDate: DateTime.now(),
                              ),
                            )
                            .whenComplete(() => widget.items
                                .map((e) => DatabaseService().deleteFromCart(e))
                                .toList())
                            .whenComplete(() => Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return CardDetailsScreen();
                                })))))
                        .toList()
                    : showSnackbar(context, "Fill in the required details");
              },
              child: Text(
                "Proceed to payment",
                style: kTextStyle(size: 15, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
