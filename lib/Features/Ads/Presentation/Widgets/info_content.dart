import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../Home/Presentation/Widgets/home_imports.dart';
import '../../Domain/Models/ad_model.dart';

class InfoContent extends StatelessWidget {
  const InfoContent({Key? key, required this.ad}) : super(key: key);
  final AdModel ad;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.screenHeight! * .05),
        Text("ad.farmName", style: getBoldStyle(size: 18)),
        const Divider(thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("المنتج:", style: getMediumStyle()),
                Text("الوحدة:", style: getMediumStyle()),
                Text("وزن الوحدة:", style: getMediumStyle()),
                Text("تاريخ التعبئة:", style: getMediumStyle()),
                Text("السجل الزراعي:", style: getMediumStyle()),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ad.product.nameAr, style: getMediumStyle()),
                Text(ad.unitType!.nameAr, style: getMediumStyle()),
                Text('${ad.unitWeight}', style: getMediumStyle()),
                Text("20/4/2021", style: getMediumStyle()),
                Text("313554651651", style: getMediumStyle()),
              ],
            ),
            QrImage(
              data: "1234567890",
              version: QrVersions.auto,
              size: 80.0,
            ),
          ],
        ),
        const Divider(thickness: 1),
        Row(
          children: [
            Text("السعر:", style: getBoldStyle(size: 18)),
            const SizedBox(width: 10),
            Text("${ad.price} ر.س", style: getBoldStyle(size: 18)),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Text("برعاية المنصة الزراعية", style: getRegularStyle()),
            const Spacer(),
            const CircleContainer(
              icon: AppIcons.share,
              color: ColorManager.lightGrey,
              size: 45,
              padding: EdgeInsets.all(10),
            ),
            const CircleContainer(
              icon: AppIcons.printer,
              size: 45,
              padding: EdgeInsets.all(10),
              color: ColorManager.lightGrey,
            ),
          ],
        )
      ],
    );
  }
}
