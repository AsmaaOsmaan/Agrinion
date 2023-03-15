import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Presentation/Widgets/update_market.dart';
import 'package:flutter/material.dart';

import '../../../../../../../App/GlobalWidgets/app_tile.dart';
import '../../../../../../../App/GlobalWidgets/bottom_sheet_helper.dart';
import '../Logic/markets_vl.dart';

class MarketsList extends StatefulWidget {
  const MarketsList({
    Key? key,
    required this.city,
    required this.marketVl,
  }) : super(key: key);
  final Cities city;
  final MarketsVL marketVl;
  @override
  State<MarketsList> createState() => _MarketsListState();
}

class _MarketsListState extends State<MarketsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.marketVl.markets.length,
      itemBuilder: (BuildContext context, int index) {
        return AppTile(
          title: widget.marketVl.markets[index].nameAr,
          onDelete: () => widget.marketVl.deleteMarket(
            widget.marketVl.markets[index],
            widget.city.id!,
          ),
          onUdpate: () => BottomSheetHelper(
                  content: UpdateMarket(
                    market: Market(
                      id: widget.marketVl.markets[index].id,
                      nameAr: widget.marketVl.markets[index].nameAr,
                      nameEn: widget.marketVl.markets[index].nameEn,
                    ),
                    index: index,
                    cityId: widget.city.id!,
                  ),
                  context: context)
              .openFullSheet(),
        );
      },
    );
  }
}
