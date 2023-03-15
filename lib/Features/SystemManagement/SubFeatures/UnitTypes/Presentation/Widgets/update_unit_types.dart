import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Presentation/Logic/unit_types_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUnitTypesSheet extends StatefulWidget {
  const UpdateUnitTypesSheet({
    Key? key,
    required this.unit,
    required this.index,
  }) : super(key: key);
  final UnitType unit;
  final int index;

  @override
  State<UpdateUnitTypesSheet> createState() => _UpdateUnitTypesSheetState();
}

class _UpdateUnitTypesSheetState extends State<UpdateUnitTypesSheet> {
  final TextEditingController _arName = TextEditingController();
  final TextEditingController _enName = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    _arName.text = widget.unit.nameAr;
    _enName.text = widget.unit.nameEn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              controller: _arName,
              decoration: const InputDecoration(hintText: "الإسم عربي"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _enName,
              decoration: const InputDecoration(hintText: "الإسم انجليزي"),
            ),
            const Spacer(),
            AppButton(
              title: "تعديل",
              onTap: () async {
                await context.read<UnitTypesVL>().editUnitType(
                      UnitType(
                        id: widget.unit.id,
                        nameAr: _arName.text,
                        nameEn: _enName.text,
                      ),
                      widget.index,
                    );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
