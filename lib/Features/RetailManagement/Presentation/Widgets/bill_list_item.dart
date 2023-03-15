import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';
import '../Screens/bill_details.dart';
import '../Screens/discard_items.dart';

class BillListItem extends StatelessWidget {
  const BillListItem({
    Key? key,
    required this.isBuying,
  }) : super(key: key);
  final bool isBuying;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute().navigate(
        context: context,
        route: const BillDetails(),
      ),
      child: Container(
        height: SizeConfig.screenHeight! * .18,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        color: ColorManager.lightGrey1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "رقم الفاتورة",
              style: getBoldStyle(
                fontColor: ColorManager.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "التاريخ : ${Utils.slashFormat(DateTime.now())}",
              style: getMediumStyle(),
            ),
            Text(
              "الوقت : ${Utils.timeFormat(DateTime.now())}",
              style: getMediumStyle(),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorManager.error,
                    ),
                    onPressed: () => {},
                    child: Text(
                      "إيصال",
                      style: getBoldStyle(
                        fontColor: ColorManager.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: isBuying
                          ? ColorManager.green
                          : ColorManager.secondary,
                    ),
                    onPressed: () => AppRoute().navigate(
                        context: context, route: const DiscardItems()),
                    child: Text(
                      isBuying ? "مرتجع بيع" : "مرتجع شراء",
                      style: getBoldStyle(
                        fontColor: ColorManager.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
