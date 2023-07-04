import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/screen/inner_screens/payment_successful.dart';
import 'package:go_shop/services/utils.dart';
import 'package:sizer/sizer.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                maxLength: 19,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberFormatter()
                ],
                decoration: const InputDecoration(
                  hintText: "XXXX XXXX XXXX XXXX",
                  hintStyle: TextStyle(color: Colors.grey),
                  label: Text("Card number"),
                  labelStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  counterText: "",
                ),
              ),
            ),
            Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: TextField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("MM"),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8),
                        counterText: "",
                      ),
                    ),
                  ),
                ),
                Text(
                  "/",
                  style: TextStyle(fontSize: 40, color: Colors.grey[600]),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: InputDecoration(
                        label: Text("YY"),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8),
                        counterText: "",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("CVV"),
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8),
                  counterText: "",
                ),
              ),
            ),
            SizedBox(
              width: 100.w,
              height: 8.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PaymentSuccessful();
                  }));
                },
                child: Text(
                  "Pay now",
                  style: kTextStyle(size: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
