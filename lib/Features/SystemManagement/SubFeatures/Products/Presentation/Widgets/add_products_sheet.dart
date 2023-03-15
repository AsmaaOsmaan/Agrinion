import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Presentation/Logic/products_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../App/Resources/color_manager.dart';
import '../../../../../../App/Utilities/size_config.dart';
import 'categories_picker.dart';

class AddProductsSheet extends StatefulWidget {
  const AddProductsSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductsSheet> createState() => _AddProductsSheetState();
}

class _AddProductsSheetState extends State<AddProductsSheet> {
  final TextEditingController _selectCategory = TextEditingController();
  final TextEditingController _arName = TextEditingController();
  final TextEditingController _enName = TextEditingController();
  @override
  void initState() {
    context.read<AdsVL>().getCategories();
    super.initState();
  }

  @override
  void deactivate() {
    context.read<ProductsVL>().image = null;
    super.deactivate();
  }

  @override
  void dispose() {
    _selectCategory.dispose();
    _arName.dispose();
    _enName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsVL>(builder: (context, productsVL, child) {
      return Expanded(
        child: Form(
          child: Column(
            children: [
              CategoriesPicker(selectCategory: _selectCategory),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => productsVL.setProductImage(),
                child: SizedBox(
                  height: SizeConfig.screenHeight! * .1,
                  child: DottedBorder(
                    color: ColorManager.lightGrey,
                    strokeCap: StrokeCap.round,
                    dashPattern: const [8, 8],
                    borderType: BorderType.Rect,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    child: productsVL.getProductImage(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _arName,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.name_ar),
                  errorText: productsVL.addingProduct?.errors?.nameAr!,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _enName,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.name_en),
                  errorText: productsVL.addingProduct?.errors?.nameEn,
                ),
              ),
              Row(
                children: [
                  Text(tr(LocaleKeys.pricable)),
                  const SizedBox(width: paddingDistance),
                  Checkbox(
                    value: productsVL.priceable,
                    onChanged: (value) {
                      productsVL.changeproductStatus(value!);
                    },
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                title: "إضافة",
                onTap: () async {
                  productsVL.addingProduct = Product(
                    nameAr: _arName.text,
                    nameEn: _enName.text,
                    categoryId: productsVL.category!.id!,
                    uploadImage: productsVL.image,
                    priceable: productsVL.priceable,
                  );
                  await productsVL.manageAddingProduct(context);
                  productsVL.changeproductStatus(false);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
