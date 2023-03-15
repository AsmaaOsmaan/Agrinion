import 'package:agriunion/App/GlobalWidgets/bottom_sheet_text_field.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../Widgets/qr_scanner.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الفواتير")),
      body: Column(
        children: [
          const QrScanner(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BottomSheetTextField(
                    controller: TextEditingController(),
                    data: const [],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: BottomSheetTextField(
                          controller: TextEditingController(),
                          data: const [],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(child: TextField()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: BottomSheetTextField(
                          controller: TextEditingController(),
                          data: const [],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(child: TextField()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Expanded(child: TextField()),
                      SizedBox(width: 10),
                      Expanded(child: Icon(Icons.calculate)),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: const Text("إضافة منتج آخر"),
                          style: ElevatedButton.styleFrom(
                            primary: ColorManager.green,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          child: const Text("إصدار الفاتورة"),
                          style: ElevatedButton.styleFrom(
                              // primary: ColorManager.green,
                              ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
