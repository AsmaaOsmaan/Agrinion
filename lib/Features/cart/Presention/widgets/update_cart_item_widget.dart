import 'package:agriunion/Features/cart/Domain/Entities/cart_item_entity.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/global_ads_cart_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/my_ads_cart_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_button.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/validator.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/values.dart';
import '../../../../generated/translations.g.dart';

class UpdateCartItemWidget extends StatefulWidget {
  const UpdateCartItemWidget(
      {Key? key,
      required this.offer,
      required this.index,
      required this.fromMyAds})
      : super(key: key);
  final CartItemEntity offer;
  final int index;
  final bool fromMyAds;
  @override
  State<UpdateCartItemWidget> createState() => _UpdateCartItemWidgetState();
}

class _UpdateCartItemWidgetState extends State<UpdateCartItemWidget> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    _priceController.text = '${widget.offer.price ?? 0}';
    _quantityController.text = '${widget.offer.quantity}';
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: radius8,
        ),
        padding: const EdgeInsets.all(paddingDistance),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  validator: (value) => Validator().validateEmpty(value!),
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.quantity),
                    label: Text(tr(LocaleKeys.quantity)),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight! * .025),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) => Validator().validateEmpty(value!),
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.price),
                    label: Text(tr(LocaleKeys.price)),
                  ),
                ),
              ],
            ),
            AppButton(
              title: tr(LocaleKeys.edit),
              color: ColorManager.black,
              onTap: () {
                if (_key.currentState!.validate()) {
                  widget.fromMyAds
                      ? context.read<MyAdsCartVL>().updateOffer(
                          widget.index,
                          double.parse(_quantityController.text),
                          double.parse(_priceController.text))
                      : context.read<GlobalAdsCartVL>().updateOffer(
                          widget.index,
                          double.parse(_quantityController.text),
                          double.parse(_priceController.text));
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
