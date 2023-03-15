import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../generated/translations.g.dart';
import '../../Domain/product_entity.dart';
import '../view_logic/ad_vl.dart';

class AdProductItem extends StatelessWidget {
  const AdProductItem({Key? key, required this.product}) : super(key: key);
  final AdProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, bottom: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: product.isDone
              ? ColorManager.green
              : ColorManager.lightGrey.withOpacity(.7),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: getRegularStyle(fontSize: 12),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "${tr(LocaleKeys.quantity)} ${product.unitCount}",
                    style: getRegularStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${tr(LocaleKeys.price)} ${product.price}",
                    style: getRegularStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => context.read<AdsVL>().removeFromProducts(product),
            child: Container(
                decoration: const BoxDecoration(
                  color: ColorManager.error,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: ColorManager.white,
                )),
          ),
        ],
      ),
    );
  }
}
