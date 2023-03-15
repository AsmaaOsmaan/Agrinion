import 'package:agriunion/App/GlobalWidgets/app_small_button.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/sales_returns_entity.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/values.dart';

class SalesReturnWidget extends StatelessWidget {
  const SalesReturnWidget(
      {Key? key, required this.salesReturn, required this.index})
      : super(key: key);
  final SalesReturn salesReturn;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<OffersVL>(builder: (context, vl, child) {
      return Container(
        padding: const EdgeInsets.all(paddingDistance),
        height: SizeConfig.screenHeight! * .10,
        margin: const EdgeInsets.only(bottom: paddingDistance),
        decoration: BoxDecoration(
          borderRadius: radius8,
          border: Border.all(color: ColorManager.lightGrey),
          color: ColorManager.lightGrey1,
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${salesReturn.quantity} ${tr(LocaleKeys.sales_return)}'),
                Text(
                  salesReturn.conversation!.status!,
                  style: getBoldStyle(
                    size: 14,
                    fontColor: Utils.getColorBasedOnStatus(
                        salesReturn.conversation!.status!),
                  ),
                ),
              ],
            ),
          ),
          Text(
            Utils.dateFormat(salesReturn.createdAt!),
          ),
          const SizedBox(width: paddingDistance),
          salesReturn.conversation!.invoiceId!=null?
          AppSmallButton(
              title: salesReturn.invoiceGenerated!
                  ? tr(LocaleKeys.download_invoice)
                  : tr(LocaleKeys.create_invoice),
              onTap: () {
                salesReturn.invoiceGenerated!
                    ? vl.showExportedSalesReturnInvoice(salesReturn.invoiceId!)
                    : vl.exportSalesReturnInvoices(salesReturn.id!, index);
              }):const SizedBox(),
        ]),
      );
    });
  }
}
