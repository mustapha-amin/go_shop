import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/order_model.dart';

class OrdersHistory extends StatelessWidget {
  const OrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<List<Order>?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: ListView.builder(
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 15.w,
                    height: 15.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          orders[index].imgUrl!,
                        ),
                      ),
                    ),
                  ),
                  title: Text(orders[index].productName!),
                  subtitle: Text(
                    DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                      orders[index].orderDate!,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
