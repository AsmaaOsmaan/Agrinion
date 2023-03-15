import 'package:agriunion/App/GlobalWidgets/filter_bar.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/Markets/Presentation/Widgets/single_container_grid.dart';
import 'package:agriunion/Features/cart/Presention/screens/my_cart_screen.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_helper.dart';
import '../../../Ads/Presentation/Widgets/ad_sheet.dart';
import '../../../Ads/Presentation/Widgets/filter_ads_sheet.dart';

class ManageMyAds extends StatefulWidget {
  const ManageMyAds({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageMyAds> createState() => _ManageMyAdsState();
}

class _ManageMyAdsState extends State<ManageMyAds> {
  @override
  void initState() {
    context.read<AdsVL>().getMyAds();
    fillFilter();
    super.initState();
  }

  final TextEditingController _searchKey = TextEditingController();
  final TextEditingController _fromPrice = TextEditingController();
  final TextEditingController _toPrice = TextEditingController();
  final TextEditingController _fromDate = TextEditingController();
  final TextEditingController _toDate = TextEditingController();

  void fillFilter() {
    if (context.read<AdsVL>().filter != null) {
      _searchKey.text = context.read<AdsVL>().filter!.productSearchKey ?? "";
      _fromPrice.text = context.read<AdsVL>().filter!.fromPrice ?? "";
      _toPrice.text = context.read<AdsVL>().filter!.toPrice ?? "";
      _fromDate.text = context.read<AdsVL>().filter!.fromDate ?? "";
      _toDate.text = context.read<AdsVL>().filter!.toDate ?? "";
    }
  }

  clearFilters() {
    context.read<AdsVL>().clearFiltersData();
    _searchKey.clear();
    _fromDate.clear();
    _toDate.clear();
    _fromPrice.clear();
    _toPrice.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsVL>(builder: (context, ad, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(tr("sellingAds")),
          actions: [
            IconButton(
              onPressed: () => AppRoute()
                  .navigate(context: context, route: const MyCartScreen()),
              icon: const Icon(Icons.shopping_cart_outlined),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // FilterBar(
                //   title: tr(LocaleKeys.search_filter),
                //   onTap: () => BottomSheetHelper(
                //     context: context,
                //     content: FilterAdsSheet(
                //       searchKey: _searchKey,
                //       fromDate: _fromDate,
                //       fromPrice: _fromPrice,
                //       toDate: _toDate,
                //       toPrice: _toPrice,
                //       onClear: () => clearFilters(),
                //     ),
                //   ).openFullSheet(),
                // ),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: ad.myAds.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: SizeConfig.screenHeight! * .18,
                        child: InkWell(
                            onTap: () => BottomSheetHelper(
                                  context: context,
                                  content: AdSheet(
                                    ad: ad.myAds[index],
                                    fromMyAds: true,
                                  ),
                                ).openSizedSheet(
                                    height: SizeConfig.screenHeight! * .85),
                            child: SingleGridContainer(
                                ad: ad.myAds[index], fromMyAds: true)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
