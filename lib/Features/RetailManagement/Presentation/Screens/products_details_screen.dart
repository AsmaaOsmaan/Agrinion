import 'package:flutter/material.dart';

class ProductsDetailsScreen extends StatelessWidget {
  const ProductsDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تفاصيل المنتجات")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        // child: ,
      ),
    );
  }
}
