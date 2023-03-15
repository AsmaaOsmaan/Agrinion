import 'package:agriunion/Features/Ads/Presentation/Widgets/ad_sheet.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/cart_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_helper.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../generated/translations.g.dart';
import '../../../Ads/Domain/Models/ad_model.dart';

class ItemData extends StatelessWidget {
  const ItemData({
    Key? key,
    required this.ad,
    this.fromMyAds = false,
  }) : super(key: key);
  final AdModel ad;
  final bool fromMyAds;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ad.product.nameAr,
            style: getBoldStyle(),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            ad.creator!.name!,
            style: getMediumStyle(fontColor: ColorManager.grey),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            ad.category!.name,
            style:
                getSemiBoldStyle(fontColor: ColorManager.primary, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.pin_drop_outlined,
                size: 15,
              ),
              Expanded(
                child: Text(
                  "${ad.city!.nameAr} | ${ad.market!.nameAr}",
                  style: getSemiBoldStyle(
                      fontColor: ColorManager.black, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          context.read<CartVL>().visibilityOfAddToCartButton(ad, fromMyAds)
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: ColorManager.black),
                  onPressed: () => BottomSheetHelper(
                    context: context,
                    content: AdSheet(ad: ad, fromMyAds: fromMyAds),
                  ).openSizedSheet(height: SizeConfig.screenHeight! * .85),
                  child: Text(
                    tr(LocaleKeys.add_to_basket),
                    style: getBoldStyle(fontColor: Colors.white, size: 14),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
