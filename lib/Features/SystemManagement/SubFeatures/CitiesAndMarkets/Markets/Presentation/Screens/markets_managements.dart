import 'package:agriunion/App/GlobalWidgets/app_fab.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Presentation/Widgets/update_city.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Presentation/Logic/markets_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/loading_view.dart';
import '../../../../../Widgets/add_update_sheet.dart';
import '../../Domain/Entities/market_entity.dart';
import '../Widgets/markets_list.dart';

class MarketsManagementScreen extends StatefulWidget {
  const MarketsManagementScreen(
      {Key? key, required this.city, required this.index})
      : super(key: key);
  final Cities city;
  final int index;

  @override
  State<MarketsManagementScreen> createState() =>
      _MarketsManagementScreenState();
}

class _MarketsManagementScreenState extends State<MarketsManagementScreen> {
  final TextEditingController _addArController = TextEditingController();
  final TextEditingController _addEnController = TextEditingController();

  @override
  void initState() {
    context.read<MarketsVL>().getMarkets(widget.city.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketsVL>(builder: (context, marketsVl, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.city.nameAr),
          actions: [
            IconButton(
              onPressed: () => BottomSheetHelper(
                      content: UpdateCity(
                        city: Cities(
                          id: widget.city.id,
                          nameAr: widget.city.nameAr,
                          nameEn: widget.city.nameEn,
                        ),
                        index: widget.index,
                      ),
                      context: context)
                  .openFullSheet(),
              icon: Image.asset(AppIcons.edit, color: ColorManager.black),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: marketsVl.isLoading
              ? const LoadingView()
              : MarketsList(city: widget.city, marketVl: marketsVl),
        ),
        floatingActionButton: AppFAB(
          onTap: () => BottomSheetHelper(
            context: context,
            content: AddUpdateSheet(
              nameArController: _addArController,
              nameEnController: _addEnController,
              isCity: false,
              onButtonTap: () {
                marketsVl.addingMarket = Market(
                  nameAr: _addArController.text,
                  nameEn: _addEnController.text,
                );
                return marketsVl.manageAddingMarket(context, widget.city.id!);
              },
            ),
          ).openFullSheet(),
        ),
      );
    });
  }
}
