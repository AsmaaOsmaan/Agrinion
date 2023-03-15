import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/app_dialogs.dart';
import '../../../../App/Resources/assets_manager.dart';
import '../../Domain/Models/ad_model.dart';
import 'info_content.dart';

class BarCodeDetailsOffer extends StatelessWidget {
  const BarCodeDetailsOffer({
    Key? key,
    this.ad,
    this.dialog,
  }) : super(key: key);

  final AdModel? ad;
  final Widget? dialog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppDialogs(context).showContent(
        content: dialog ?? InfoContent(ad: ad!),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Image.asset(AppIcons.reciept, height: 35, width: 35),
      ),
    );
  }
}
