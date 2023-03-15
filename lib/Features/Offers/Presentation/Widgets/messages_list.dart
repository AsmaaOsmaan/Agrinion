import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Domain/Entities/offers_entity.dart';
import 'negotiation_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    Key? key,
    required this.controller,
    required this.offers,
  }) : super(key: key);
  final ScrollController controller;
  final List<Offer> offers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == offers.length) {
            return Container(height: 70);
          }
          return MessageBubbles(
            isMe: !context.read<OffersVL>().showForSender(index),
            isLast: offers.length - 1 == index,
            offer: offers[index],
          );
        },
        itemCount: offers.length + 1,
        controller: controller,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      ),
    );
  }
}
