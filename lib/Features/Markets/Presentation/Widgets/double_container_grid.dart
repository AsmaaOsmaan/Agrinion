import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/favorite_icon.dart';
import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../../App/constants/values.dart';
import '../../../Ads/Domain/Models/ad_model.dart';
import 'grid_item_data.dart';
import 'negotiatable_container.dart';

class TwoGridContainer extends StatelessWidget {
  const TwoGridContainer({
    Key? key,
    required this.ad,
  }) : super(key: key);
  final AdModel ad;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: .5),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: SizeConfig.screenHeight! * .15,
                width: double.maxFinite,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ad.image != null
                    ? Image.network(ad.image!, fit: BoxFit.cover)
                    : Image.asset(AppImages.logo),
              ),
              Container(
                height: SizeConfig.screenHeight! * .15,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: bottomUpLinearGradient,
                ),
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    Utils.slashFormat(DateTime.now()),
                    style: getRegularStyle(fontColor: Colors.white),
                  ),
                ),
              ),
              Positioned(left: 10, top: 10, child: FavoriteIcon(adModel: ad)),
              ad.negotiable
                  ? const Positioned(
                      bottom: -8, left: 10, child: NegotiatableContainer())
                  : const SizedBox()
            ],
          ),
          const SizedBox(height: 10),
          ItemData(ad: ad)
        ],
      ),
    );
  }
}
