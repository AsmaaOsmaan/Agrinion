import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Logic/categories_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    Key? key,
    this.categoryColor,
    this.index,
    required this.isCategoryGroup,
  }) : super(key: key);
  final Color? categoryColor;
  final int? index;
  final bool isCategoryGroup;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('اختر لون'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: categoryColor ?? ColorManager.primary,
          onColorChanged: (Color color) =>
              context.read<CategoriesVL>().setCategoryColor(color),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text(tr(LocaleKeys.save)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
