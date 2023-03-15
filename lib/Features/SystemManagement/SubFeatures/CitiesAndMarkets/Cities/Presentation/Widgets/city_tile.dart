import 'package:agriunion/App/GlobalWidgets/app_dialogs.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Presentation/Logic/cities_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Presentation/Widgets/update_city.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/delete_confirmation_dialog.dart';
import '../../../../../../../App/Resources/text_themes.dart';
import '../../../../../../../App/Utilities/app_route.dart';
import '../../../../../Widgets/management_large_tile.dart';
import '../../../Markets/Presentation/Screens/markets_managements.dart';

class CityTile extends StatelessWidget {
  CityTile({
    Key? key,
    required this.city,
    required this.index,
  }) : super(key: key);
  final Cities city;
  final int index;

  final TextEditingController nameArController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ManagementLargeTile(
      content: Text(city.nameAr, style: getBoldStyle()),
      onTap: () => AppRoute().navigate(
        context: context,
        route: MarketsManagementScreen(city: city, index: index),
      ),
      sheetContent: UpdateCity(city: city, index: index),
      onDelete: () => AppDialogs(context).showDelete(
        content: DeleteConfirmationDialog(
          onDelete: () => context.read<CitiesVL>().deleteCity(city),
        ),
      ),
    );
  }
}
