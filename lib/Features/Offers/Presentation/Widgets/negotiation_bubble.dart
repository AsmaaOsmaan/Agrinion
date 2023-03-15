import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBubbles extends StatelessWidget {
  final bool isMe;
  final bool isLast;
  final Offer offer;
  const MessageBubbles({
    Key? key,
    required this.isMe,
    this.isLast = false,
    required this.offer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment:
            !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isLast && !isMe
              ? AcceptOrRejectButtons(offer: offer)
              : const SizedBox(),
          Container(
            margin: EdgeInsets.only(right: isMe ? 0 : paddingDistance),
            padding: const EdgeInsets.all(paddingDistance + 5),
            constraints: BoxConstraints(
                maxWidth: SizeConfig.screenWidth! * .5,
                minWidth: SizeConfig.screenWidth! * .2),
            decoration: BoxDecoration(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: isMe ? Colors.lightBlueAccent : ColorManager.lightGrey,
            ),
            child: Column(
              crossAxisAlignment:
                  !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                SizedBox(height: isMe ? 0 : paddingDistance),
                Container(
                  padding: const EdgeInsets.all(paddingDistance / 2),
                  margin: const EdgeInsets.all(paddingDistance / 2),
                  decoration: BoxDecoration(
                    borderRadius: radius8,
                    color: Colors.white30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(tr(LocaleKeys.price)),
                          Text(offer.price.toString()),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Column(
                        children: [
                          Text(tr(LocaleKeys.quantity)),
                          Text(offer.quantity.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
                offer.note == null
                    ? const SizedBox()
                    : Text(
                        '${offer.note}',
                        style: getBoldStyle(
                            fontColor: isMe ? Colors.white : Colors.black54),
                      ),
                Text(
                  Utils.calculateTheTime(offer.createdAt!),
                  style: getMediumStyle(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AcceptOrRejectButtons extends StatelessWidget {
  const AcceptOrRejectButtons({Key? key, required this.offer})
      : super(key: key);
  final Offer offer;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: ColorManager.error,
          child: IconButton(
            onPressed: () => context.read<OffersVL>().rejectOffer(offer),
            icon: const Icon(Icons.close, color: ColorManager.white),
          ),
        ),
        const SizedBox(width: paddingDistance),
        CircleAvatar(
          backgroundColor: ColorManager.green,
          child: IconButton(
            onPressed: () => context.read<OffersVL>().acceptOffer(offer),
            icon: const Icon(Icons.check, color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
