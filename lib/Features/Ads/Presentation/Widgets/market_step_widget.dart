import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import '../view_logic/ad_vl.dart';

class MarketsStepWidget extends StatelessWidget {
  const MarketsStepWidget({
    Key? key,
    required this.type,
    required this.markets,
  }) : super(key: key);

  final String? type;
  final List<Market> markets;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: markets.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: markets[index].isSelected
                ? const Icon(Icons.check)
                : const SizedBox(),
            onTap: () => context
                .read<AdsVL>()
                .changeMarketStep(markets[index], index, type!),
            title: Text(
              markets[index].nameAr,
              style: getBoldStyle(),
            ),
          );
        },
        separatorBuilder: (ctx, index) => const Divider(
          color: ColorManager.lightGrey,
          thickness: .8,
        ),
      ),
    );
  }
}
