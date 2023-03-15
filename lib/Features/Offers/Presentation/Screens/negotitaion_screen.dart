import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Utilities/size_config.dart';
import '../../Domain/Entities/offers_entity.dart';
import '../Widgets/dimming_container.dart';
import '../Widgets/make_offer_widget.dart';
import '../Widgets/messages_list.dart';

class NegotiationScreen extends StatefulWidget {
  const NegotiationScreen({
    Key? key,
    required this.conversationId,
  }) : super(key: key);
  final int conversationId;

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    context.read<OffersVL>().getConversationOffers(widget.conversationId);

    super.initState();
  }

  _send() {
    context.read<OffersVL>().manageAddingOffer(context, widget.conversationId);
    _qtyController.clear();
    _priceController.clear();
    _notesController.clear();
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.fastOutSlowIn);
  }

  String _getScreenTitle(Conversation conversation) {
    return ' ${conversation.ad!.product.nameAr}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OffersVL>(builder: (context, vl, child) {
      return vl.isLoading
          ? const LoadingView()
          : WillPopScope(
              onWillPop: () {
                // TODO : enhance
                vl.getPendingConversations(vl.conversation!.orderId!);
                return Future.value(true);
              },
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar:
                      AppBar(title: Text(_getScreenTitle(vl.conversation!))),
                  body: Stack(
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            MessageList(
                                controller: _controller, offers: vl.offers),
                            Stack(
                              children: [
                                OfferContainer(
                                  onSendTap: () async {
                                    vl.addingOffer = Offer(
                                      price:
                                          double.parse(_priceController.text),
                                      quantity:
                                          double.parse(_qtyController.text),
                                      note: _notesController.text,
                                      conversationId: vl.conversation!.id,
                                      previousOfferId:
                                          vl.conversation!.offers!.last.id,
                                      minimalOfferableQuantity: vl
                                          .offers.last.minimalOfferableQuantity,
                                      remainingQty: vl.offers.last.remainingQty,
                                    );
                                    await _send();
                                  },
                                  notes: _notesController,
                                  price: _priceController,
                                  qty: _qtyController,
                                  negotiable: vl.conversation!.ad!.negotiable,
                                ),
                                !vl.showOfferBox()
                                    ? const DimmingContainer()
                                    : const SizedBox()
                              ],
                            ),
                          ],
                        ),
                      ),
                      vl.conversation!.status == "pending"
                          ? const SizedBox()
                          : Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorManager.black.withOpacity(.7),
                              ),
                              child: Center(
                                child: Text(
                                  '${vl.conversation!.status}',
                                  style: getBoldStyle(
                                    fontColor: ColorManager.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  )),
            );
    });
  }
}
