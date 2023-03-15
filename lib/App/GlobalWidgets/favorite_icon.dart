import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_model.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resources/assets_manager.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({
    Key? key,
    this.size = 18,
    required this.adModel,
  }) : super(key: key);
  final double size;
  final AdModel adModel;
  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  String? type;

  @override
  void initState() {
    type = CachHelper.getData(key: kType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsVL>(builder: (context, ad, _) {
      return Visibility(
        visible: type == 'Admin' ? false : true,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            ad.manageFavoriteAd(widget.adModel.id!, widget.adModel.isFav!);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: widget.adModel.isFav!
                  ? ColorManager.transparentRed
                  : Colors.white.withOpacity(.8),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              widget.adModel.isFav!
                  ? AppIcons.favorite
                  : AppIcons.blackFavorite,
              height: widget.size,
            ),
          ),
        ),
      );
    });
  }
}
