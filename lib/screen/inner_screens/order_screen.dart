import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/constants/extensions.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';

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
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Customer>(context);
    int totalQty = widget.items
        .fold(0, (previousValue, element) => previousValue + element.quantity!);
    double totalPrice = widget.items.fold(
        0, (previousValue, element) => previousValue + element.totalPrice!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place your order"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
            DropdownButton<String>(
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
            DropdownButton<String>(
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
            addVerticalSpacing(10),
            TextField(
              controller: addressController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Enter your address",
                border: OutlineInputBorder(),
              ),
            ),
            DropdownButton<String>(
              elevation: 3,
              value: selectedLGA,
              isExpanded: true,
              onChanged: (val) {
                setState(() {
                  selectedLGA = val;
                });
              },
              hint: const Text('Select payment method'),
              items: selectedPaymentMethod == null
                  ? []
                  : NigerianStatesAndLGA.getStateLGAs(selectedState!)
                      .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
