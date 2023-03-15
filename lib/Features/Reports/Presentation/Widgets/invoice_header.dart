import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InvoiceHeader extends StatelessWidget {
  const InvoiceHeader({Key? key, required this.invoicesModel})
      : super(key: key);
  final InvoicesModel invoicesModel;

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            invoicesModel.invoiceNumber!,
            style: getBoldStyle(),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    tr(LocaleKeys.invoice_created_date),
                    style: getSemiBoldStyle(),
                  ),
                  const SizedBox(
                    height: paddingDistance,
                  ),
                  Text(
                    Utils.dateFormat(invoicesModel.createdAt!),
                    style: getBoldStyle(),
                  )
                ],
              ),
              Column(
                children: [
                  Text(tr(LocaleKeys.supply_date), style: getSemiBoldStyle()),
                  const SizedBox(
                    height: paddingDistance,
                  ),
                  Text(
                    Utils.dateFormat(invoicesModel.supplyDate!),
                    style: getBoldStyle(),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
