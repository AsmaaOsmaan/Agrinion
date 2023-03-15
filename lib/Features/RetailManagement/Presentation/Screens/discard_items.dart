import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/custom_check_box.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../../App/constants/values.dart';
import '../../../Ads/Presentation/Widgets/bar_code_offer_details.dart';
import '../Widgets/discard_item_dialog.dart';

class DiscardItems extends StatelessWidget {
  const DiscardItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مرتجعات'),
        actions: const [
          BarCodeDetailsOffer(dialog: DiscardItemDialog()),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: ExpansionPanelList(
                  elevation: 0,
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: false,
                      backgroundColor: ColorManager.lightGrey1,
                      headerBuilder: (context, isExpanded) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomCheckbox(
                            iconSize: 20,
                            size: 25,
                          ),
                          Text("طماطم"),
                          Text("2 كيلو"),
                          Text("10 ر.س"),
                        ],
                      ),
                      body: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: radius20,
                              ),
                              child: const Center(child: Text("الكمية")),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: ElevatedButton(
                            child: const Text("تحديث"),
                            onPressed: () {},
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(SizeConfig.screenWidth! * .9, 35),
              ),
              onPressed: () => AppRoute().navigate(
                  context: context,
                  route: Scaffold(
                    appBar: AppBar(
                      title: const Text("دائن"),
                    ),
                    body: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: ColorManager.lightGrey1,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorManager.lightGrey),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                child: Icon(
                                  Icons.bookmark_border,
                                  color: ColorManager.white,
                                ),
                                backgroundColor: ColorManager.black,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "رقم الإشعار: 16546213245",
                                    style: getBoldStyle(size: 14),
                                  ),
                                  Text(
                                      "تاريخ الإنشاء: ${Utils.slashFormat(DateTime.now())}"),
                                ],
                              ),
                              const Spacer(),
                              ElevatedButton(
                                child: Text(
                                  "إستعراض",
                                  style: getBoldStyle(
                                    fontColor: ColorManager.white,
                                    size: 10,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorManager.grey,
                                  fixedSize:
                                      Size(SizeConfig.screenWidth! * .20, 15),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )),
              child: const Text("حفظ"),
            ),
          )
        ],
      ),
    );
  }
}
