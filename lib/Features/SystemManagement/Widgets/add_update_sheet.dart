import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Presentation/Logic/cities_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Presentation/Logic/markets_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/app_button.dart';
import '../../../../../../../App/Resources/text_themes.dart';

class AddUpdateSheet extends StatelessWidget {
  const AddUpdateSheet({
    Key? key,
    this.isUpdate = false,
    required this.onButtonTap,
    required this.nameArController,
    required this.nameEnController,
    this.isCity = false,
  }) : super(key: key);
  final bool isUpdate;
  final Function onButtonTap;
  final TextEditingController nameArController;
  final TextEditingController nameEnController;
  final bool isCity;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            isUpdate ? "تعديل" : "إضافة",
            style: getBoldStyle(size: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: nameArController,
            decoration: InputDecoration(
              hintText: "الإسم بالعربي",
              errorText: isCity
                  ? context.watch<CitiesVL>().addingCity?.errors?.nameAr
                  : context.watch<MarketsVL>().addingMarket?.errors?.nameAr,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: nameEnController,
            decoration: InputDecoration(
              hintText: "الإسم بالانجليزي",
              errorText: isCity
                  ? context.watch<CitiesVL>().addingCity?.errors?.nameEn
                  : context.watch<MarketsVL>().addingMarket?.errors?.nameEn,
            ),
          ),
          const Spacer(),
          AppButton(
            title: isUpdate ? "تعديل" : "إضافة",
            onTap: () async {
              await onButtonTap();
            },
          )
        ],
      ),
    );
  }
}
