import 'package:agriunion/App/GlobalWidgets/app_small_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../App/GlobalWidgets/app_dialogs.dart';
import '../../../../../../App/GlobalWidgets/bottom_sheet_helper.dart';
import '../../../../../../App/GlobalWidgets/delete_confirmation_dialog.dart';
import '../../../../../../App/Resources/color_manager.dart';
import '../../../../../../App/Resources/text_themes.dart';
import '../../../../../../App/Utilities/utils.dart';
import '../../../../../../App/constants/distances.dart';
import '../../../../../../App/constants/values.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../PricesList/Domain/Models/price_item_model.dart';
import '../../../../../PricesList/Presentation/ViewLogic/price_list_vl.dart';
import '../Screens/setting_values_to_price_list.dart';

class PricableListItem extends StatelessWidget {
  const PricableListItem({
    Key? key,
    required this.product,
    required this.date,
    required this.index,
  }) : super(key: key);
  final PriceItemModel product;
  final String date;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(paddingDistance),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.lightGrey1),
        borderRadius: radius8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${product.product?.nameAr}', style: getBoldStyle()),
                Text(
                    '${tr(LocaleKeys.price)} ${product.minPrice} ~ ${product.maxPrice}'),
                Text('${product.unitType?.nameAr}'),
                Text(Utils.dateFormat(date)),
              ],
            ),
          ),
          AppSmallButton(
            title: tr(LocaleKeys.edit),
            onTap: () => BottomSheetHelper(
              context: context,
              content: SettingValuesToPriceList(
                priceItemModel: product,
                onSubmit: (model) =>
                    context.read<PriceListVL>().updatePriceList(model, index),
              ),
            ).openSizedSheet(),
            color: ColorManager.primary,
          ),
          const SizedBox(width: 10),
          AppSmallButton(
            title: tr(LocaleKeys.delete),
            onTap: () => AppDialogs(context).showDelete(
              content: DeleteConfirmationDialog(
                onDelete: () =>
                    context.read<PriceListVL>().deletePriceList(product),
              ),
            ),
            color: ColorManager.favRed,
          ),
        ],
      ),
    );
  }
}
