import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/global_ads_cart_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          AppIcons.cart,
          width: 26,
          height: 26,
          color: color,
        ),
        Positioned(
          top: 0,
          right: 8,
          child: Text(
            context.watch<GlobalAdsCartVL>().offers.length.toString(),
            style: getBoldStyle(size: 14, fontColor: color),
          ),
        ),
      ],
    );
  }
}
