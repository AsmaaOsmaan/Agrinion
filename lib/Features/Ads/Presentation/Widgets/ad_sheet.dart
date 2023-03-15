import 'package:agriunion/App/GlobalWidgets/favorite_icon.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/cart_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Utilities/size_config.dart';
import '../../../../App/constants/values.dart';
import '../../../cart/Presention/ViewLogic/cart_vl.dart';
import '../../Domain/Models/ad_model.dart';
import 'adding_to_cart_widget.dart';

class AdSheet extends StatelessWidget {
  const AdSheet({
    Key? key,
    required this.ad,
    this.fromMyAds = false,
  }) : super(key: key);
  final AdModel ad;
  final bool fromMyAds;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight! * .25,
                decoration: BoxDecoration(borderRadius: radius8),
                child: Image.network(ad.image!, fit: BoxFit.cover),
              ),
              SizedBox(height: SizeConfig.screenHeight! * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(ad.product.nameAr, style: getBoldStyle(size: 22)),
                  Text(
                    "${ad.price} ${tr(LocaleKeys.riyal)}",
                    style: getBoldStyle(fontColor: ColorManager.grey, size: 18),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight! * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(LocaleKeys.details),
                    style: getBoldStyle(size: 22)
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                  FavoriteIcon(
                    adModel: ad,
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight! * .01),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr(LocaleKeys.unit), style: getBoldStyle()),
                      Text(tr(LocaleKeys.unit_weight), style: getBoldStyle()),
                      Text(tr(LocaleKeys.unit_count), style: getBoldStyle()),
                      Text(tr(LocaleKeys.market_name), style: getBoldStyle()),
                      Text(tr(LocaleKeys.city), style: getBoldStyle()),
                      ad.remainingQty != null
                          ? Text(tr(LocaleKeys.remaining),
                              style: getBoldStyle())
                          : const SizedBox()
                    ],
                  ),
                  const SizedBox(width: paddingDistance),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ad.unitType!.nameAr, style: getBoldStyle()),
                      Text('${ad.unitWeight}', style: getBoldStyle()),
                      Text('${ad.quantity}', style: getBoldStyle()),
                      Text(ad.market!.nameAr, style: getBoldStyle()),
                      Text(ad.city!.nameAr, style: getBoldStyle()),
                      ad.remainingQty != null
                          ? Text('${ad.remainingQty}', style: getBoldStyle())
                          : const SizedBox(),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight! * .03),
              ad.notes != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr(LocaleKeys.notes),
                          style: getBoldStyle(size: 22)
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                        Text('${ad.notes}', style: getBoldStyle()),
                      ],
                    )
                  : const SizedBox(),
              context.read<CartVL>().visibilityOfAddToCartButton(ad, fromMyAds)
                  ? AddingToCartWidget(
                      ad: ad,
                      fromMyAds: fromMyAds,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
