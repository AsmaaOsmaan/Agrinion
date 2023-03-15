import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/floating_action_bar_widget.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/flex_grid.dart';
import '../Widgets/main_categories_list.dart';
import '../Widgets/search_bar.dart';

class WholesaleStores extends StatefulWidget {
  const WholesaleStores({Key? key}) : super(key: key);

  @override
  State<WholesaleStores> createState() => _WholesaleStoresState();
}

class _WholesaleStoresState extends State<WholesaleStores> {
  late AdsVL adsVL;
  String? type;
  @override
  void initState() {
    adsVL = context.read<AdsVL>();
    adsVL.getAds();
    if (mounted) {
      adsVL.getCategories();
    }
    type = CachHelper.getData(key: kType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: const [
              SearchBar(),
              Expanded(child: MainCategories()),
              Expanded(child: FlexGrid(), flex: 7),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: type == 'Admin' || type == 'Merchant'
              ? null
              : const FloatingAB()),
    );
  }
}
