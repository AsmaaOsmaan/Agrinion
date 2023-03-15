import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/app_fab.dart';
import '../../../../App/GlobalWidgets/bottom_sheet_helper.dart';
import '../../../../App/GlobalWidgets/filter_bar.dart';
import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Utilities/size_config.dart';
import '../Widgets/store_list_item.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppFAB(onTap: () {
        BottomSheetHelper(
          content: Column(
            children: [
              const TextField(
                decoration: InputDecoration(hintText: 'إسم المخزن'),
              ),
              const SizedBox(height: 15),
              const TextField(
                decoration: InputDecoration(hintText: 'موقع المخزن'),
              ),
              const SizedBox(height: 15),
              BottomSheetTextField(
                hint: 'نوع المخزن',
                controller: TextEditingController(),
                data: const [],
              ),
              SizedBox(height: SizeConfig.screenHeight! * .5),
              AppButton(title: "إنشاء", onTap: () {}),
            ],
          ),
          context: context,
        ).openFullSheet();
      }),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FilterBar(
              title: "المخزن",
              onTap: () {},
              trailing: Image.asset(AppIcons.filtering, height: 25),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const StoreListItem();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
