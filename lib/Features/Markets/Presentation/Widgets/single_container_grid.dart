import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_dialogs.dart';
import '../../../../App/GlobalWidgets/delete_confirmation_dialog.dart';
import '../../../../App/GlobalWidgets/favorite_icon.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../Ads/Domain/Models/ad_model.dart';
import '../../../Ads/Presentation/Widgets/ad_photo.dart';
import '../../../Ads/Presentation/view_logic/ad_vl.dart';
import 'grid_item_data.dart';

class SingleGridContainer extends StatelessWidget {
  const SingleGridContainer(
      {Key? key,
      required this.ad,
      this.fromMyAds = false,
      this.fromMyFavoriteAds})
      : super(key: key);
  final AdModel ad;
  final bool fromMyAds;
  final bool? fromMyFavoriteAds;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: .5),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdPhoto(image: ad.image, negotiable: ad.negotiable),
          const SizedBox(width: 10),
          ItemData(ad: ad, fromMyAds: fromMyAds),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FavoriteIcon(adModel: ad),
              fromMyAds
                  ? GestureDetector(
                      onTap: () => AppDialogs(context).showDelete(
                          content: DeleteConfirmationDialog(
                              onDelete: () =>
                                  context.read<AdsVL>().deleteAd(ad))),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: ColorManager.error),
                        child: const Center(
                          child: Icon(Icons.delete,
                              color: ColorManager.white, size: 15),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
