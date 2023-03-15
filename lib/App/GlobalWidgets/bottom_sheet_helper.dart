import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomSheetHelper {
  final BuildContext context;
  final Widget content;
  BottomSheetHelper({required this.context, required this.content});
  void openFullSheet() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.screenHeight! * .1),
            const CloseButton(),
            ...[content]
          ],
        ),
      ),
    );
  }

  void openSizedSheet({double? height}) {
    showMaterialModalBottomSheet(
      context: context,
      isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: radius8),
      builder: (ctx) => SizedBox(
        height: height ?? SizeConfig.screenHeight! * .65,
        child: content,
      ),
    );
  }
}
