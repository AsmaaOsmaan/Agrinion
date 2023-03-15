import 'package:agriunion/App/GlobalWidgets/app_fab.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Presentation/Logic/products_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/add_products_sheet.dart';
import '../Widgets/products_list.dart';

class ProductsManagementScreen extends StatefulWidget {
  const ProductsManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsManagementScreen> createState() =>
      _ProductsManagementScreenState();
}

class _ProductsManagementScreenState extends State<ProductsManagementScreen> {
  @override
  void initState() {
    context.read<ProductsVL>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة المنتجات")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            // TextField(
            //   decoration: InputDecoration(hintText: "البحث عن منتجات"),
            // ),
            // SizedBox(height: 10),
            ProductsList(),
          ],
        ),
      ),
      floatingActionButton: AppFAB(onTap: () {
        BottomSheetHelper(
          context: context,
          content: const AddProductsSheet(),
        ).openFullSheet();
      }),
    );
  }
}
