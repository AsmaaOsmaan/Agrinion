import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Presentation/Logic/products_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Presentation/Widgets/update_products_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../App/GlobalWidgets/app_tile.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProductsVL>(builder: (context, vl, child) {
        return ListView.builder(
          itemCount: vl.products.length,
          itemBuilder: (BuildContext context, int index) {
            return AppTile(
              title: vl.products[index].nameAr,
              onDelete: () => vl.deleteProduct(vl.products[index]),
              onUdpate: () => BottomSheetHelper(
                context: context,
                content: UpdateProductsSheet(
                  index: index,
                  product: vl.products[index],
                ),
              ).openFullSheet(),
            );
          },
        );
      }),
    );
  }
}
