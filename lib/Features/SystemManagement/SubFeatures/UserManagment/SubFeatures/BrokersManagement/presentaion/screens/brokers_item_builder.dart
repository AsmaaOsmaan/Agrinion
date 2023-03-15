import 'package:agriunion/App/GlobalWidgets/app_small_button.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../Domain/Entities/broker_entity.dart';

class BrokerItemBuilder extends StatelessWidget {
  const BrokerItemBuilder({
    Key? key,
    required this.broker,
    required this.onTap,
    required this.titleButton,
    this.visible = true,
  }) : super(key: key);
  final Broker broker;
  final Function onTap;
  final String titleButton;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: ColorManager.lightGrey1,
        child: Icon(Icons.person, color: ColorManager.grey),
      ),
      title: Text(broker.nameAr!),
      subtitle: Text(broker.mobile!),
      trailing: Visibility(
        visible: visible,
        child: AppSmallButton(
          title: titleButton,
          onTap: () => onTap(),
          color: ColorManager.secondary,
        ),
      ),
    );
  }
}
