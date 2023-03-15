import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_button.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/distances.dart';
import '../../../../generated/translations.g.dart';
import '../../../Offers/Presentation/ViewLogic/offers_vl.dart';
import '../../../Offers/Presentation/Widgets/conversation_widget.dart';

class ExportInvoicesSheet extends StatelessWidget {
  const ExportInvoicesSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<OffersVL>(builder: (context, vl, child) {
      return Padding(
        padding: const EdgeInsets.all(paddingDistance),
        child: Column(
          children: [
            Row(
              children: [
                Text(tr(LocaleKeys.create_invoice), style: getBoldStyle()),
                const Spacer(),
                Flexible(
                  child: Row(
                    children: [
                      Checkbox(
                        value: vl.isAllSelected,
                        onChanged: (value) => vl.selectAll(value!),
                      ),
                      Text(tr(LocaleKeys.select_all), style: getBoldStyle())
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: vl.unExportedconversations.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: vl
                            .unExportedconversations[index].selectedForInvoices,
                        onChanged: (value) {
                          vl.addToExport(value!, index);
                        },
                      ),
                      Expanded(
                        child: ConversationWidget(
                          conversation: vl.unExportedconversations[index],
                          index: index,
                          additionContent: const SizedBox(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            AppButton(
              title: tr(LocaleKeys.submit),
              onTap: () async {
                vl.manageExportInvoice(context);
              },
            ),
          ],
        ),
      );
    });
  }
}
