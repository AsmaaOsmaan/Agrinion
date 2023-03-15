import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/my_ads_cart_vl.dart';
import 'package:agriunion/Features/cart/Presention/widgets/choose_commercial_profile_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item_widget.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAdsCartVL>(builder: (context, cartVl, child) {
      return Scaffold(
        appBar: AppBar(title: Text(tr(LocaleKeys.cart))),
        body: ListView.separated(
          itemCount: cartVl.offers.length,
          padding: const EdgeInsets.all(paddingDistance),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(thickness: 1.5);
          },
          itemBuilder: (BuildContext context, int index) {
            return CartItemWidget(
              index: index,
              offer: cartVl.offers[index],
              fromMyAds: true,
            );
          },
        ),
        bottomSheet: cartVl.offers.isEmpty
            ? const SizedBox()
            : Container(
                decoration: const BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(8), right: Radius.circular(8)),
                ),
                padding: const EdgeInsets.all(paddingDistance),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ChooseCommercialProfile(),
                    SizedBox(height: SizeConfig.screenHeight! * .015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr(LocaleKeys.total),
                          style: getBoldStyle(
                            fontColor: ColorManager.white,
                            size: 18,
                          ),
                        ),
                        Text(
                          '${cartVl.total.ceil()} ${tr(LocaleKeys.riyal)}',
                          style: getBoldStyle(
                            fontColor: ColorManager.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * .01),
                    AppButton(
                      title: tr(LocaleKeys.send_order),
                      color: ColorManager.lightPrimary,
                      onTap: () => cartVl.createDirectOrderWithOffers(context),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
