import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Logic/categories_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameTheItems extends StatelessWidget {
  const NameTheItems({
    Key? key,
    required this.arController,
    required this.enController,
  }) : super(key: key);
  final TextEditingController arController;
  final TextEditingController enController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: arController,
            validator: (value) => Validator().validateEmpty(value!),
            decoration: InputDecoration(
              hintText: "الإسم عربي",
              errorText:
                  context.watch<CategoriesVL>().addingCategory?.errors?.nameAr,
            ),
            onChanged: (val) {
              Provider.of<CategoriesVL>(context, listen: false).restNameArVal();
            },
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: TextFormField(
            validator: (value) => Validator().validateEmpty(value!),
            controller: enController,
            decoration: const InputDecoration(
              hintText: "الإسم انجليزي",
            ),
          ),
        ),
      ],
    );
  }
}
