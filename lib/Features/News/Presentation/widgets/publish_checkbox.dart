import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';

class PublishCheckBox extends StatelessWidget {
  const PublishCheckBox({
    Key? key,
    required this.initValue,
    required this.onChange,
  }) : super(key: key);
  final bool initValue;
  final Function(bool? value) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: initValue,
          activeColor: ColorManager.primary,
          onChanged: (value) => onChange(value),
        ),
        Text(
          tr("published_news"),
          style: getBoldStyle(
            fontColor: ColorManager.grey,
          ),
        ),
      ],
    );
  }
}
