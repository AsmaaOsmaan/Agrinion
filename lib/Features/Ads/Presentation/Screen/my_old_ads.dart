import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/Markets/Presentation/Widgets/single_container_grid.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOldAds extends StatefulWidget {
  const MyOldAds({
    Key? key,
  }) : super(key: key);

  @override
  State<MyOldAds> createState() => _MyOldAdsState();
}

class _MyOldAdsState extends State<MyOldAds> {
  @override
  void initState() {
    context.read<AdsVL>().getMyAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.my_ads))),
      body: Consumer<AdsVL>(builder: (context, vl, child) {
        return vl.isLoading
            ? const LoadingView()
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: paddingDistance),
                itemCount: vl.myAds.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () =>
                        vl.cloneFromPreviousApp(vl.myAds[index], context),
                    child: Padding(
                        padding: const EdgeInsets.all(paddingDistance),
                        child: SingleGridContainer(ad: vl.myAds[index])),
                  );
                },
              );
      }),
    );
  }
}
