import 'package:agriunion/Features/Ads/Domain/Models/ad_model.dart';
import 'package:agriunion/Features/cart/Domain/validation/cart_validation.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/global_ads_cart_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/my_ads_cart_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_button.dart';
import '../../../../App/GlobalWidgets/loading_dialog.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/values.dart';
import '../../../../generated/translations.g.dart';
import '../../../cart/Domain/Entities/cart_item_entity.dart';

class AddingToCartWidget extends StatefulWidget {
  const AddingToCartWidget(
      {Key? key, required this.ad, required this.fromMyAds})
      : super(key: key);
  final AdModel ad;
  final bool fromMyAds;
  @override
  State<AddingToCartWidget> createState() => _AddingToCartWidgetState();
}

class _AddingToCartWidgetState extends State<AddingToCartWidget> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    _priceController.text = '${widget.ad.price ?? 0}';
    _quantityController.text = '${widget.ad.minimalOfferableQuantity ?? 1}';
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    validator: (value) => CartValidator.validateQty(value),
                    inputFormatters: nonDecimalInputFormatter,
                    decoration: InputDecoration(
                      hintText: tr(LocaleKeys.quantity),
                      label: Text(tr(LocaleKeys.quantity)),
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.screenWidth! * .025),
                Expanded(
                  child: GestureDetector(
                    onTap: () => !widget.ad.negotiable
                        ? LoadingDialog.showSimpleToast(tr("nonNegoMsg"))
                        : false,
                    child: TextFormField(
                      controller: _priceController,
                      validator: (value) => CartValidator.validatePrice(value),
                      keyboardType: decimalKeyboardType,
                      inputFormatters: decimalInputFormatter,
                      decoration: InputDecoration(
                        hintText: tr(LocaleKeys.price),
                        label: Text(tr(LocaleKeys.price)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppButton(
              title: tr(LocaleKeys.add_to_basket),
              color: ColorManager.black,
              onTap: () {
                if (_key.currentState!.validate()) {
                  CartItemEntity cartItem = CartItemEntity(
                    image: widget.ad.image,
                    productNameAr: widget.ad.product.nameAr,
                    quantity: double.parse(_quantityController.text),
                    price: double.parse(_priceController.text),
                    adId: widget.ad.id,
                    minQty: widget.ad.minimalOfferableQuantity,
                  );

                  widget.fromMyAds
                      ? context.read<MyAdsCartVL>().addToCart(cartItem)
                      : context.read<GlobalAdsCartVL>().addToCart(cartItem);
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
