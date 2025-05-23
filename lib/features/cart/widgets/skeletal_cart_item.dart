import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletalCartItem extends StatelessWidget {
  const SkeletalCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
              child: Skeletonizer(
                effect: SoldColorEffect(color: Colors.grey.shade300),
                child: Column(
                  children: [
                    ...List.generate(
                      5,
                      (index) => ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          color: Colors.black,
                        ),
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
                    ),
                  ],
                ),
              ),
            );
  }
}