import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Presentation/Logic/cities_vl.dart';
import 'package:agriunion/Features/SystemManagement/Widgets/add_update_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/app_fab.dart';
import '../../../../../../../App/GlobalWidgets/loading_view.dart';
import '../../Domain/Entities/city_entity.dart';
import '../Widgets/city_tile.dart';

class CitiesManagementScreen extends StatefulWidget {
  const CitiesManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CitiesManagementScreen> createState() => _CitiesManagementScreenState();
}

class _CitiesManagementScreenState extends State<CitiesManagementScreen> {
  final TextEditingController nameArController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();
  @override
  void initState() {
    context.read<CitiesVL>().getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CitiesVL>(builder: (context, cityVl, child) {
      return Scaffold(
        appBar: AppBar(title: const Text("إدارة المدن والأسواق")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: cityVl.isLoading
              ? const LoadingView()
              : ListView.builder(
                  itemCount: cityVl.cities.length,
                  itemBuilder: (BuildContext context, int index) =>
                      CityTile(city: cityVl.cities[index], index: index),
                ),
        ),
        floatingActionButton: AppFAB(
          onTap: () => BottomSheetHelper(
            context: context,
            content: AddUpdateSheet(
              nameArController: nameArController,
              nameEnController: nameEnController,
              isCity: true,
              onButtonTap: () {
                cityVl.addingCity = Cities(
                  nameAr: nameArController.text,
                  nameEn: nameEnController.text,
                );
                cityVl.manageAddingCity(context);
              },
            ),
          ).openFullSheet(),
        ),
      );
    });
  }
}
