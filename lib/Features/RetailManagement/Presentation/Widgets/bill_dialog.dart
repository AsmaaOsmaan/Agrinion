import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../App/GlobalWidgets/logo_with_date.dart';
import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../Home/Presentation/Widgets/home_imports.dart';

class BillDialog extends StatelessWidget {
  const BillDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        const LogoWithTime(),
        const Divider(color: ColorManager.black, thickness: .75),
        QrImage(
          data: "1234567890",
          version: QrVersions.auto,
          size: 120.0,
        ),
        const Divider(color: ColorManager.black, thickness: .75),
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
