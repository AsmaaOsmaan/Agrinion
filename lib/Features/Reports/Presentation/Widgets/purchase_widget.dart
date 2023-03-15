import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PurchaseWidget extends StatelessWidget {
  const PurchaseWidget({Key? key, required this.sales}) : super(key: key);
  final List<Sales> sales;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10.0) //
            ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.Purchase),
            style: getBoldStyle(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(child: Text("اسم")),
              Expanded(child: Text("الوحدة")),
              Expanded(child: Text("سعر")),
              Expanded(child: Text("كمية")),
              Expanded(child: Text("اجمالي")),
            ],
          ),
          const Divider(thickness: 1.5),
          SizedBox(
            height: SizeConfig.screenHeight! * .2,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Expanded(child: Text(sales[index].product!.nameAr)),
                      const SizedBox(width: 10),
                      Expanded(child: Text(sales[index].productUnitType!.nameAr)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(sales[index].unitPrice!.toStringAsFixed(2)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text("${sales[index].quantity}")),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                            "${sales[index].totalPrice!.toStringAsFixed(2)} ${tr(LocaleKeys.riyal)}"),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: sales.length,
            ),
          ),
        ],
      ),
    );
  }
}
