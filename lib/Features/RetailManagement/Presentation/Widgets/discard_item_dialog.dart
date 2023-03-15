import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/logo_with_date.dart';
import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/utils.dart';

class DiscardItemDialog extends StatelessWidget {
  const DiscardItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const LogoWithTime(),
        const Divider(color: ColorManager.black, thickness: .75),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("رقم الإشعار", style: getMediumStyle()),
                Text("رقم الفاتورة", style: getMediumStyle()),
                Text("تاريخ التوريد", style: getMediumStyle()),
                Text("اسم العميل", style: getMediumStyle()),
                Text("العنوان", style: getMediumStyle()),
                Text("الرقم الضريبي", style: getMediumStyle()),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("32121", style: getMediumStyle()),
                Text("32158615", style: getMediumStyle()),
                Text(Utils.slashFormat(DateTime.now()),
                    style: getMediumStyle()),
                Text("محمود هويدي", style: getMediumStyle()),
                Text("31 مكرم عبيد", style: getMediumStyle()),
                Text("313554651651", style: getMediumStyle()),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              child: Image.asset(
                AppIcons.openEye,
                height: 25,
              ),
              backgroundColor: ColorManager.lightGrey,
              radius: 30,
            ),
          ],
        ),
        const Divider(color: ColorManager.black, thickness: .75),
        const Spacer(),
        Text("برعاية المنصة الزراعية", style: getRegularStyle()),
        const Spacer(),
      ],
    );
  }
}
