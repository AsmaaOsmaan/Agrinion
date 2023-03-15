import 'package:agriunion/App/GlobalWidgets/app_dialogs.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/GlobalWidgets/delete_confirmation_dialog.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/cart/Domain/Entities/cart_item_entity.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/global_ads_cart_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/my_ads_cart_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/distances.dart';
import '../../../../generated/translations.g.dart';
import '../../../Ads/Presentation/Widgets/ad_photo.dart';
import 'quantity_control.dart';
import 'update_cart_item_widget.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(
      {Key? key,
      required this.offer,
      required this.index,
      required this.fromMyAds})
      : super(key: key);
  final CartItemEntity offer;
  final int index;
  final bool fromMyAds;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * .15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdPhoto(image: offer.image, negotiable: false),
          const SizedBox(width: paddingDistance / 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offer.productNameAr!,
                style: getBoldStyle(),
              ),
              Text(
                '${offer.price} ${tr(LocaleKeys.riyal)}',
                style: getBoldStyle(fontColor: ColorManager.grey),
              ),
              Row(
                children: [
                  offer.quantity == 1
                      ? ControlAmountButtons.delete(
                          onTap: () => fromMyAds
                              ? context
                                  .read<MyAdsCartVL>()
                                  .deleteFromCart(offer)
                              : context
                                  .read<GlobalAdsCartVL>()
                                  .deleteFromCart(offer),
                        )
                      : ControlAmountButtons.minus(
                          onTap: () => fromMyAds
                              ? context
                                  .read<MyAdsCartVL>()
                                  .decrementQuantity(index)
                              : context
                                  .read<GlobalAdsCartVL>()
                                  .decrementQuantity(index),
                        ),
                  const SizedBox(width: 20),
                  Text(
                    '${offer.quantity}',
                    style: getBoldStyle(size: 20),
                  ),
                  const SizedBox(width: 20),
                  ControlAmountButtons.plus(
                    onTap: () => fromMyAds
                        ? context.read<MyAdsCartVL>().incrementQuantity(index)
                        : context
                            .read<GlobalAdsCartVL>()
                            .incrementQuantity(index),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => BottomSheetHelper(
                      context: context,
                      content: UpdateCartItemWidget(
                        offer: offer,
                        index: index,
                        fromMyAds: fromMyAds,
                      ),
                    ).openSizedSheet(height: SizeConfig.screenHeight! * .40),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorManager.primary,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.edit, color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(width: paddingDistance),
                  InkWell(
                    onTap: () {
                      AppDialogs(context).showDelete(
                          content: DeleteConfirmationDialog(
                              onDelete: () => fromMyAds
                                  ? context
                                      .read<MyAdsCartVL>()
                                      .deleteFromCart(offer)
                                  : context
                                      .read<GlobalAdsCartVL>()
                                      .deleteFromCart(offer)));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorManager.error,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(5),
                      child:
                          const Icon(Icons.delete, color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              offer.isDone
                  ? const SizedBox()
                  : const Icon(Icons.warning, color: ColorManager.error),
            ],
          ),
        ],
      ),
    );
  }
}
