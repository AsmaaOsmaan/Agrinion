import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Presentation/Logic/markets_vl.dart';
import 'package:agriunion/Features/SystemManagement/Widgets/add_update_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateMarket extends StatefulWidget {
  const UpdateMarket(
      {Key? key,
      required this.market,
      required this.index,
      required this.cityId})
      : super(key: key);
  final Market market;
  final int cityId;
  final int index;
  @override
  State<UpdateMarket> createState() => _UpdateMarketState();
}

class _UpdateMarketState extends State<UpdateMarket> {
  final nameArController = TextEditingController();
  final nameEnController = TextEditingController();
  @override
  void initState() {
    nameArController.text = widget.market.nameAr;
    nameEnController.text = widget.market.nameEn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AddUpdateSheet(
      isUpdate: true,
      onButtonTap: () async {
        await context.read<MarketsVL>().editMarket(
              Market(
                id: widget.market.id,
                nameAr: nameArController.text,
                nameEn: nameEnController.text,
              ),
              widget.cityId,
              widget.index,
            );
        Navigator.pop(context);
      },
      nameArController: nameArController,
      nameEnController: nameEnController,
    );
  }
}
