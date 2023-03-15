import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/ad_sheet.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/Markets/Presentation/Widgets/single_container_grid.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFavoriteAds extends StatefulWidget {
  const MyFavoriteAds({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFavoriteAds> createState() => _MyFavoriteAdsState();
}

class _MyFavoriteAdsState extends State<MyFavoriteAds> {
  @override
  void initState() {
    context.read<AdsVL>().getAllFavoriteAds();
    context.read<AdsVL>().updateValueInFavoriteScreen(true);
    super.initState();
  }

  @override
  void deactivate() {
    context.read<AdsVL>().updateValueInFavoriteScreen(false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsVL>(builder: (context, ad, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(tr(LocaleKeys.favorite_ads)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView.builder(
            itemCount: ad.myFavoriteAds.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: SizeConfig.screenHeight! * .18,
                  child: InkWell(
                    onTap: () => BottomSheetHelper(
                      context: context,
                      content: AdSheet(ad: ad.myFavoriteAds[index]),
                    ).openSizedSheet(height: SizeConfig.screenHeight! * .85),
                    child: SingleGridContainer(
                        ad: ad.myFavoriteAds[index],
                        fromMyAds: false,
                        fromMyFavoriteAds: true),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
