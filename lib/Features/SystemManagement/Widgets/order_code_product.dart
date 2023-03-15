import 'package:flutter/material.dart';

class UnitsCode extends StatelessWidget {
  const UnitsCode({
    Key? key,
    required this.codeArController,
    required this.codeEnController,
  }) : super(key: key);
  final TextEditingController codeArController;
  final TextEditingController codeEnController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: codeArController,
                decoration: const InputDecoration(hintText: "كود المنتج عربي"),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextFormField(
                controller: codeEnController,
                decoration:
                    const InputDecoration(hintText: "كود المنتج انجليزي"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
