import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Presentation/Logic/cities_vl.dart';
import 'package:agriunion/Features/SystemManagement/Widgets/add_update_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Domain/Entities/city_entity.dart';

class UpdateCity extends StatefulWidget {
  const UpdateCity({Key? key, required this.city, required this.index})
      : super(key: key);
  final Cities city;
  final int index;
  @override
  State<UpdateCity> createState() => _UpdateCityState();
}

class _UpdateCityState extends State<UpdateCity> {
  final nameArController = TextEditingController();
  final nameEnController = TextEditingController();
  @override
  void initState() {
    nameArController.text = widget.city.nameAr;
    nameEnController.text = widget.city.nameEn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AddUpdateSheet(
      isUpdate: true,
      onButtonTap: () async {
        await context.read<CitiesVL>().editCity(
              Cities(
                nameAr: nameArController.text,
                nameEn: nameEnController.text,
                id: widget.city.id,
              ),
              widget.index,
            );
        Navigator.pop(context);
      },
      nameArController: nameArController,
      nameEnController: nameEnController,
    );
  }
}
