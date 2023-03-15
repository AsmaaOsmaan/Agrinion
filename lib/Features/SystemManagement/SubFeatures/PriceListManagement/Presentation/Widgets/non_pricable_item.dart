import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/Features/PricesList/Presentation/ViewLogic/price_list_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../App/Resources/color_manager.dart';
import '../../../../../../App/constants/values.dart';
import '../Screens/setting_values_to_price_list.dart';

class NonPricableProductItem extends StatelessWidget {
  const NonPricableProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: radius8,
          side: const BorderSide(width: 1.5, color: ColorManager.lightGrey1),
        ),
        title: Text(product.nameAr),
        trailing: ActionChip(
          label: Text(tr(LocaleKeys.add_price)),
          onPressed: () => BottomSheetHelper(
            context: context,
            content: SettingValuesToPriceList(
              product: product,
              onSubmit: (model) =>
                  context.read<PriceListVL>().createPriceList(model),
            ),
          ).openSizedSheet(),
        ),
      ),
    );
  }
}
