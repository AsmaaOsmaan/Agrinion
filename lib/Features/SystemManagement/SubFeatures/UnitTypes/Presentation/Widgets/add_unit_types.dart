import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Presentation/Logic/unit_types_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUnitTypesSheet extends StatefulWidget {
  const AddUnitTypesSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddUnitTypesSheet> createState() => _AddUnitTypesSheetState();
}

class _AddUnitTypesSheetState extends State<AddUnitTypesSheet> {
  final TextEditingController _arName = TextEditingController();
  final TextEditingController _enName = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitTypesVL>(builder: (context, vl, _) {
      return Expanded(
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _arName,
                decoration: InputDecoration(
                  hintText: "الإسم عربي",
                  errorText: vl.addingUnitType?.error?.nameAr,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _enName,
                decoration: InputDecoration(
                  hintText: "الإسم انجليزي",
                  errorText: vl.addingUnitType?.error?.nameEn,
                ),
              ),
              const Spacer(),
              AppButton(
                title: "إضافة",
                onTap: () async {
                  vl.addingUnitType = UnitType(
                    nameAr: _arName.text,
                    nameEn: _enName.text,
                  );
                  await vl.manageAddingProduct(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
