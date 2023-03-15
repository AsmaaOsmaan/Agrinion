import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/app_dialogs.dart';
import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../Markets/Presentation/Widgets/negotiatable_container.dart';
import '../../Domain/Models/ad_model.dart';
import '../Widgets/info_content.dart';

class AdData extends StatelessWidget {
  const AdData({Key? key, required this.ad}) : super(key: key);
  final AdModel ad;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppDialogs(context).showContent(
        content: InfoContent(ad: ad),
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: ColorManager.grey.withOpacity(.09),
              border: Border.all(color: ColorManager.lightGrey.withOpacity(.2)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "المنتج:",
                            style: getBoldStyle(size: 12),
                          ),
                          Text(
                            "الوحدة:",
                            style: getBoldStyle(size: 12),
                          ),
                          Text(
                            "وزن الوحدة:",
                            style: getBoldStyle(size: 12),
                          ),
                          Text(
                            "الكمية:",
                            style: getBoldStyle(size: 12),
                          ),
                          Text(
                            "اسم المسوق:",
                            style: getBoldStyle(size: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ad.product.nameAr),
                        Text(ad.unitType!.nameAr),
                        Text("${ad.unitWeight}"),
                        Text("${ad.quantity}"),
                        const Text("السويلم"),
                      ],
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          AppIcons.reciept,
                          height: 40,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(thickness: 1),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "المباع:",
                      style:
                          getBoldStyle(fontColor: Colors.blueAccent, size: 14),
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 4,
                        child: Text(
                          "0.00",
                          style: getBoldStyle(
                              fontColor: Colors.blueAccent, size: 14),
                        )),
                  ],
                )
              ],
            ),
          ),
          const Positioned(
            bottom: 10,
            left: 10,
            child: NegotiatableContainer(fontSize: 14, padding: 8),
          ),
        ],
      ),
    );
  }
}
