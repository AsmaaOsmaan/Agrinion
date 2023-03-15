import 'package:flutter/material.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../../App/constants/values.dart';
import '../../../Ads/Presentation/Widgets/bar_code_offer_details.dart';
import '../Widgets/bill_dialog.dart';

class BillDetails extends StatelessWidget {
  const BillDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الفاتورة"),
        actions: const [
          BarCodeDetailsOffer(dialog: BillDialog()),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("رقم الفاتورة: #5465134681", style: getBoldStyle()),
                const SizedBox(height: 10),
                Text(
                  " التاريخ: ${Utils.slashFormat(DateTime.now())}",
                  style: getRegularStyle(),
                ),
              ],
            ),
          ),
          const Divider(color: ColorManager.lightGrey),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الخصم", style: getBoldStyle()),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "خيارات الدفع",
                              style: getBoldStyle(size: 14),
                            ),
                            const Spacer(),
                            Image.asset(
                              AppIcons.visa,
                              height: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "الدفع بإستخدام فيزا",
                              style: getMediumStyle(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: ColorManager.lightGrey),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("تفاصيل الطلب"),
                        ...List.generate(
                          5,
                          (index) => Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin:
                                    const EdgeInsets.only(bottom: 10, left: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorManager.lightGrey,
                                  ),
                                  borderRadius: radius8,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("1 x موز"),
                                  SizedBox(height: 5),
                                  Text("14.50 ر.س"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: ColorManager.lightGrey1),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("المجموع الفرعي:"),
                                Text("قسمة الخصم:"),
                                Text("مصاريف الشحن:"),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("30 ر.س"),
                                const Text("10 ر.س"),
                                Text("مجانا",
                                    style: getMediumStyle(
                                      fontColor: ColorManager.green,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    color: ColorManager.lightGrey1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "المجموع",
                              style: getBoldStyle(),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "شامل ضريبة القيمة المضافة",
                              style: getMediumStyle(
                                fontColor: ColorManager.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "40 ر.س",
                          style: getBoldStyle(size: 18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
