import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_button.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/values.dart';
import '../../../../generated/translations.g.dart';

class AdSummaryStepWidget extends StatelessWidget {
  const AdSummaryStepWidget({
    Key? key,
    required this.carNo,
    required this.carPlate,
    required this.vl,
  }) : super(key: key);

  final TextEditingController carNo;
  final TextEditingController carPlate;
  final AdsVL vl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: paddingDistance),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tr(LocaleKeys.category)} :',
                  style: getRegularStyle(fontSize: 16),
                ),
                Text(
                  tr(LocaleKeys.city),
                  style: getRegularStyle(fontSize: 16),
                ),
                Text(
                  '${tr(LocaleKeys.market_name)} :',
                  style: getRegularStyle(fontSize: 16),
                ),
                vl.broker == null
                    ? Text(
                        '${tr(LocaleKeys.farmer)} :',
                        style: getRegularStyle(fontSize: 16),
                      )
                    : Text(
                        '${tr(LocaleKeys.marketer)} :',
                        style: getRegularStyle(fontSize: 16),
                      ),
                Text(
                  '${tr(LocaleKeys.car_number)} :',
                  style: getRegularStyle(fontSize: 16),
                ),
                Text(
                  '${tr(LocaleKeys.plate_number)} :',
                  style: getRegularStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vl.category!.name, style: getBoldStyle(size: 16)),
                  Text(vl.city!.nameAr, style: getBoldStyle(size: 16)),
                  Text(vl.market!.nameAr, style: getBoldStyle(size: 16)),
                  vl.broker == null
                      ? Text('${vl.farmer?.profileName}',
                          style: getBoldStyle(size: 16))
                      : Text('${vl.broker!.nameAr}',
                          style: getBoldStyle(size: 16)),
                  Text(
                      carNo.text == ""
                          ? '${vl.clonedAd?.carNumber}'
                          : carNo.text,
                      style: getBoldStyle(size: 16)),
                  Text(
                      carPlate.text == ""
                          ? '${vl.clonedAd?.carPlate}'
                          : carPlate.text,
                      style: getBoldStyle(size: 16)),
                ],
              ),
            ),
          ],
        ),
        const Divider(thickness: 3),
        Text(tr(LocaleKeys.products), style: getBoldStyle(size: 20)),
        Wrap(
          children: List.generate(
            vl.adProducts.length,
            (index) => Container(
              margin: const EdgeInsets.only(left: paddingDistance),
              padding: const EdgeInsets.all(paddingDistance),
              decoration: BoxDecoration(
                color: ColorManager.lightGrey,
                borderRadius: radius20,
              ),
              child: Text(vl.adProducts[index].name),
            ),
          ),
        ),
        const Spacer(),
        AppButton(
          title: tr(LocaleKeys.add_ad),
          onTap: () => context.read<AdsVL>().manageAdsCreation(context),
        ),
      ],
    ));
  }
}
