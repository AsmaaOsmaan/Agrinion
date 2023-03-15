import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/loading_dialog.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/constants/distances.dart';
import '../../../../generated/translations.g.dart';

class OfferContainer extends StatefulWidget {
  const OfferContainer({
    Key? key,
    required this.onSendTap,
    required this.notes,
    required this.price,
    required this.qty,
    required this.negotiable,
  }) : super(key: key);

  final Function onSendTap;
  final TextEditingController notes;
  final TextEditingController price;
  final TextEditingController qty;
  final bool negotiable;

  @override
  State<OfferContainer> createState() => _OfferContainerState();
}

class _OfferContainerState extends State<OfferContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: paddingDistance,
        vertical: 5,
      ),
      height: SizeConfig.screenHeight! * .18,
      decoration: kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: ColorManager.primary,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(5),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: IconButton(
                onPressed: () => widget.onSendTap(),
                icon: const Icon(Icons.send, color: ColorManager.white),
              ),
            ),
          ),
          const SizedBox(width: paddingDistance),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => !widget.negotiable
                            ? LoadingDialog.showSimpleToast(el.tr("nonNegoMsg"))
                            : false,
                        child: TextField(
                          enabled: widget.negotiable,
                          controller: widget.price,
                          keyboardType: decimalKeyboardType,
                          inputFormatters: decimalInputFormatter,
                          decoration: InputDecoration(
                              hintText: el.tr(LocaleKeys.price)),
                        ),
                      ),
                    ),
                    const SizedBox(width: paddingDistance),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: widget.qty,
                        inputFormatters: nonDecimalInputFormatter,
                        decoration: InputDecoration(
                            hintText: el.tr(LocaleKeys.quantity)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: paddingDistance),
                TextField(
                  controller: widget.notes,
                  decoration:
                      InputDecoration(hintText: el.tr(LocaleKeys.notes)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
