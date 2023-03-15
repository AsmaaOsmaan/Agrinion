import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TableHeaderContainer(title: tr(LocaleKeys.product_name)),
        const SizedBox(width: 1),
        TableHeaderContainer(title: tr(LocaleKeys.today_price)),
      ],
    );
  }
}

class TableHeaderContainer extends StatelessWidget {
  const TableHeaderContainer({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: SizeConfig.screenHeight! * .06,
      color: ColorManager.primary,
      child: Center(
        child: Text(
          title,
          style: getRegularStyle(fontColor: ColorManager.white),
        ),
      ),
    ));
  }
}
