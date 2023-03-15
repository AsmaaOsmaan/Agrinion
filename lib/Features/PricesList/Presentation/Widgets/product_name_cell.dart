import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../Domain/Models/price_item_model.dart';

class ProductDetailsCell extends StatelessWidget {
  const ProductDetailsCell({Key? key, required this.model}) : super(key: key);
  final PriceItemModel model;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ColorManager.lightGrey1,
        height: SizeConfig.screenHeight! * .1,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.product!.nameAr, style: getBoldStyle()),
            Text(
              model.unitType!.nameAr,
              style: getRegularStyle(fontColor: ColorManager.grey),
            ),
            Row(
              children: [
                Text(
                  tr(LocaleKeys.unit_weight),
                  style: getRegularStyle(fontColor: ColorManager.grey),
                ),
                const SizedBox(width: paddingDistance),
                Text(
                  '${model.weight}',
                  style: getSemiBoldStyle(fontColor: ColorManager.grey),
                ),
                const SizedBox(width: paddingDistance / 2),
                Text(
                  tr("kilo"),
                  style: getRegularStyle(fontColor: ColorManager.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
