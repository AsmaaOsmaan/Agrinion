
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddOfferWidget extends StatelessWidget {
  const AddOfferWidget({Key? key,  required this.qtyController, required this.priceController, required this.notesController, required this.ad}) : super(key: key);

  final TextEditingController qtyController;
  final TextEditingController priceController;
  final TextEditingController notesController;
  final AdModel ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [



        Text(
          "اسم المنتج: ${ad.product.nameAr}",
          style: getBoldStyle(),
        ),
        SizedBox(height: SizeConfig.screenHeight! * .02),
        // BottomSheetTextField(
        //   controller: TextEditingController(),
        //   data: const [],
        //   hint: "احسب حساب العميل",
        // ),
        SizedBox(height: SizeConfig.screenHeight! * .013),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                validator: (value) => Validator().validateEmpty(value!),
                decoration: const InputDecoration(hintText: "حدد الكمية"),

              ),
            ),
            SizedBox(width: SizeConfig.screenWidth! * .025),
            Expanded(
              child: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                validator: (value) => Validator().validateEmpty(value!),
                decoration:
                const InputDecoration(hintText: "حدد السعر"),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: ColorManager.yellow.withOpacity(.3),
            borderRadius: radius8,
          ),
          child: Text(
              "الحد الأدنى للطلب : ${ad.minimalOfferableQuantity}"),
        ),
        Text(
          "إضافة ملاحظة",
          style: getBoldStyle(),
        ),
        const SizedBox(height: 15),
        TextField(
          maxLines: 3,
          controller: notesController,
          decoration: InputDecoration(
            hintText: tr("add_note"),
          ),
        ),
        SizedBox(height: SizeConfig.defaultSize! * 2),



      ],
    );
  }
}
