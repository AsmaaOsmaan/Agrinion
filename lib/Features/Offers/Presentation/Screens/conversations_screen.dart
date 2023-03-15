import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/GlobalWidgets/app_tab_bar.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Presentation/Screens/sales_returns_screen.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_small_button.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../Reports/Presentation/Widgets/export_invoices_sheet.dart';
import '../Widgets/conversation_widget.dart';
import '../Widgets/create_salse_return_widget.dart';
import '../Widgets/grouped_convs.dart';

class OrderConversations extends StatefulWidget {
  const OrderConversations({Key? key, required this.orderId}) : super(key: key);
  final int orderId;

  @override
  State<OrderConversations> createState() => _OrderConversationsState();
}

class _OrderConversationsState extends State<OrderConversations> {
  String? type;
  @override
  void initState() {
    type = CachHelper.getData(key: kType);
    type == "Merchant"
        ? context
            .read<OffersVL>()
            .getPendingGroupedConversations(widget.orderId)
        : context.read<OffersVL>().getPendingConversations(widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text(tr(LocaleKeys.offers))),
        body: Consumer<OffersVL>(
          builder: (context, vl, child) => Column(children: [
            AppTabBar(
                tabBar: TabBar(
              onTap: (index) {
                switch (index) {
                  case 0:
                    type == "Merchant"
                        ? vl.getPendingGroupedConversations(widget.orderId)
                        : vl.getPendingConversations(widget.orderId);

                    break;
                  case 1:
                    type == "Merchant"
                        ? vl.getAcceptedGroupedConversations(widget.orderId)
                        : vl.getAcceptedConversations(widget.orderId);
                    break;
                  default:
                    type == "Merchant"
                        ? vl.getRejectedGroupedConversations(widget.orderId)
                        : vl.getRejectedConversations(widget.orderId);
                }
              },
              tabs: [
                Tab(text: tr(LocaleKeys.pending)),
                Tab(text: tr(LocaleKeys.accepted)),
                Tab(text: tr(LocaleKeys.rejected)),
              ],
            )),
            Expanded(
              child: vl.isLoading
                  ? const LoadingView()
                  : TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: type == "Merchant"
                              ? vl.groupedConversations.length
                              : vl.pending.length,
                          itemBuilder: (BuildContext context, int index) {
                            return type == "Merchant"
                                ? GroupedConversationWidget(
                                    gcs: vl.groupedConversations[index],
                                    getAdditionContent: getAdditionContent(
                                      context,
                                      vl.pending[index],
                                      index,
                                    ),
                                  )
                                : ConversationWidget(
                                    conversation: vl.pending[index],
                                    index: index,
                                    additionContent: getAdditionContent(
                                        context, vl.pending[index], index),
                                  );
                          },
                        ),
                        Stack(
                          children: [
                            ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: type == "Merchant"
                                  ? vl.groupedConversations.length
                                  : vl.accepted.length,
                              itemBuilder: (BuildContext context, int index) {
                                return type == "Merchant"
                                    ? GroupedConversationWidget(
                                        gcs: vl.groupedConversations[index],
                                        getAdditionContent: getAdditionContent(
                                          context,
                                          vl.accepted[index],
                                          index,
                                        ),
                                      )
                                    : ConversationWidget(
                                        conversation: vl.accepted[index],
                                        index: index,
                                        additionContent: getAdditionContent(
                                          context,
                                          vl.accepted[index],
                                          index,
                                        ),
                                      );
                              },
                            ),
                            vl.unExportedconversations.isNotEmpty &&
                                    type == "Broker"
                                ? Positioned(
                                    bottom: paddingDistance,
                                    right: paddingDistance,
                                    left: paddingDistance,
                                    child: AppButton(
                                      title: tr(LocaleKeys.create_invoice),
                                      onTap: () => BottomSheetHelper(
                                        context: context,
                                        content: const ExportInvoicesSheet(),
                                      ).openSizedSheet(),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: type == "Merchant"
                              ? vl.groupedConversations.length
                              : vl.rejected.length,
                          itemBuilder: (BuildContext context, int index) {
                            return type == "Merchant"
                                ? GroupedConversationWidget(
                                    gcs: vl.groupedConversations[index],
                                    getAdditionContent: getAdditionContent(
                                      context,
                                      vl.rejected[index],
                                      index,
                                    ),
                                  )
                                : ConversationWidget(
                                    conversation: vl.rejected[index],
                                    index: index,
                                    additionContent: getAdditionContent(
                                      context,
                                      vl.rejected[index],
                                      index,
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget getAdditionContent(
      BuildContext context, Conversation conversation, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // conversation.invoiceId == null
        //     ? const SizedBox()
        //     : AppSmallButton(
        //         title: tr(LocaleKeys.download_invoice),
        //         onTap: () => context
        //             .read<OffersVL>()
        //             .showExportedInvoice(conversation.invoiceId!, context),
        //       ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                AppRoute().navigate(
                    context: context,
                    route: SalesReturnsScreen(
                      conversationId: conversation.id!,
                    ));
              },
              child: Text(
                  '${conversation.salesReturnsCount}${tr(LocaleKeys.sales_return)}',
                  style: getBoldStyle(fontColor: Colors.blue)),
            ),
            Column(
              children: [
                conversation.invoiceId == null
                    ? const SizedBox()
                    : AppSmallButton(
                        title: tr(LocaleKeys.download_invoice),
                        onTap: () => context
                            .read<OffersVL>()
                            .showExportedInvoice(
                                conversation.invoiceId!, context),
                      ),
                const SizedBox(
                  height: 10,
                ),
                conversation.status
                    == 'Approved'
                    ? const SizedBox()
                    : AppSmallButton(
                        title: tr(LocaleKeys.create_sales_returns),
                        onTap: () {
                          BottomSheetHelper(
                            context: context,
                            content: CreateSalesReturnScreen(
                              conversationId: conversation.id!,
                              index: index,
                              conversation: conversation,
                            ),
                          ).openSizedSheet(
                              height: SizeConfig.screenHeight! * .25);
                        }),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
