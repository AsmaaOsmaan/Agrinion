import 'package:agriunion/App/GlobalWidgets/app_small_button.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoiceItemBuilder extends StatelessWidget {
  const InvoiceItemBuilder({Key? key, required this.invoicesModel})
      : super(key: key);
  final InvoicesModel invoicesModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(width: 10, color: Colors.green),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: const Icon(
                      Icons.casino_outlined,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: SizeConfig.defaultSize!,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${tr(LocaleKeys.invoice_number)} :${invoicesModel.invoiceNumber}"),
                    Text(
                        "${tr(LocaleKeys.order_number)} :${invoicesModel.invoiceNumber}"),
                    Text(
                        "${tr(LocaleKeys.remaining)} :${invoicesModel.remainingTotal}"),
                    (CachHelper.getData(key: kId) != invoicesModel.creatorId)
                        ? Text(
                            "${tr(LocaleKeys.seller)}${invoicesModel.supplier!.profileName}")
                        : Text(
                            "${tr(LocaleKeys.buyer)} ${invoicesModel.client!.profileName}"),
                  ],
                )
              ],
            ),
            AppSmallButton(
              title: tr(LocaleKeys.show_invoice),
              onTap: () {
                context
                    .read<OffersVL>()
                    .showExportedInvoice(invoicesModel.invoiceId!, context);
              },
              color: ColorManager.grey,
            ),
          ],
        ));
  }
}
