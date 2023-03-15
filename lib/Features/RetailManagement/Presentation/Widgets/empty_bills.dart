import 'package:flutter/material.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';

class EmptyBills extends StatelessWidget {
  const EmptyBills({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            AppImages.emptyBills,
            height: SizeConfig.screenHeight! * .2,
          ),
          Text(
            "لا توجد فواتير حالية",
            style: getBoldStyle(size: 24),
          ),
          const SizedBox(height: 20),
          Text(
            "يمكنك الاشتراك لمدة 14 يوماً وتجربة النظام والإستفادة من اصدار الفواتير بكل سهولة",
            style: getRegularStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}