import 'package:agriunion/App/GlobalWidgets/app_fab.dart';
import 'package:agriunion/App/GlobalWidgets/app_tile.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Presentation/Logic/unit_types_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Presentation/Widgets/update_unit_types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../App/GlobalWidgets/loading_view.dart';
import '../Widgets/add_unit_types.dart';

class UnitTypesManagement extends StatefulWidget {
  const UnitTypesManagement({
    Key? key,
  }) : super(key: key);

  @override
  State<UnitTypesManagement> createState() => _UnitTypesManagementState();
}

class _UnitTypesManagementState extends State<UnitTypesManagement> {
  @override
  void initState() {
    context.read<UnitTypesVL>().getUnitTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitTypesVL>(builder: (context, unitsVl, child) {
      return Scaffold(
        appBar: AppBar(title: const Text("إدارة الوحدات")),
        floatingActionButton: AppFAB(
          onTap: () => BottomSheetHelper(
            context: context,
            content: const AddUnitTypesSheet(),
          ).openFullSheet(),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: unitsVl.isLoading
              ? const LoadingView()
              : ListView.builder(
                  itemCount: unitsVl.unitTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AppTile(
                      title: unitsVl.unitTypes[index].nameAr,
                      onDelete: () => unitsVl.deleteUnitType(
                        unitsVl.unitTypes[index],
                      ),
                      onUdpate: () => BottomSheetHelper(
                        context: context,
                        content: UpdateUnitTypesSheet(
                          index: index,
                          unit: unitsVl.unitTypes[index],
                        ),
                      ).openFullSheet(),
                    );
                  },
                ),
        ),
      );
    });
  }
}
