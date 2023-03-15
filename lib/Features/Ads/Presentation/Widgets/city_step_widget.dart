import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import '../view_logic/ad_vl.dart';

class CityStepWidget extends StatelessWidget {
  const CityStepWidget({Key? key, required this.cities}) : super(key: key);
  final List<Cities> cities;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: cities[index].isSelected
                ? const Icon(Icons.check)
                : const SizedBox(),
            onTap: () =>
                context.read<AdsVL>().changeCityStep(cities[index], index),
            title: Text(
              cities[index].nameAr,
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
