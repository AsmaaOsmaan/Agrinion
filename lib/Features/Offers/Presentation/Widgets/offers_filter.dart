import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_text_field.dart';

class OffersFilter extends StatelessWidget {
  const OffersFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BottomSheetTextField(
            controller: TextEditingController(),
            data: const [],
            hint: tr(LocaleKeys.select_status),
            value: "",
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: BottomSheetTextField(
                  controller: TextEditingController(),
                  data: const [],
                  hint: tr(LocaleKeys.from_date),
                  value: "",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BottomSheetTextField(
                  controller: TextEditingController(),
                  data: const [],
                  hint: tr(LocaleKeys.to_date),
                  value: "",
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(onPressed: () {}, child: const Text("بحث"))
        ],
      ),
    );
  }
}
