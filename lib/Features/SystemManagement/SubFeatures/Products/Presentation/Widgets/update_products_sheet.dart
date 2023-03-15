import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
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
import 'categories_picker.dart';

class UpdateProductsSheet extends StatefulWidget {
  const UpdateProductsSheet({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);
  final Product product;
  final int index;
  @override
  State<UpdateProductsSheet> createState() => _UpdateProductsSheetState();
}

class _UpdateProductsSheetState extends State<UpdateProductsSheet> {
  final TextEditingController _selectCategory = TextEditingController();
  final TextEditingController _arName = TextEditingController();
  final TextEditingController _enName = TextEditingController();
  @override
  void initState() {
    context.read<AdsVL>().getCategories();
    context.read<ProductsVL>().priceable = widget.product.priceable!;
    _arName.text = widget.product.nameAr;
    _enName.text = widget.product.nameEn;

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
    return Consumer<ProductsVL>(builder: (context, productsVl, child) {
      return Expanded(
        child: Form(
          child: Column(
            children: [
              CategoriesPicker(selectCategory: _selectCategory),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => productsVl.setProductImage(),
                child: SizedBox(
                  height: SizeConfig.screenHeight! * .1,
                  child: DottedBorder(
                    color: ColorManager.lightGrey,
                    strokeCap: StrokeCap.round,
                    dashPattern: const [8, 8],
                    borderType: BorderType.Rect,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    child: productsVl.getProductImage(widget.product.image),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _arName,
                decoration: InputDecoration(hintText: tr(LocaleKeys.name_ar)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _enName,
                decoration: InputDecoration(hintText: tr(LocaleKeys.name_en)),
              ),
              Row(
                children: [
                  Text(tr(LocaleKeys.pricable)),
                  const SizedBox(width: paddingDistance),
                  Checkbox(
                    value: productsVl.priceable,
                    onChanged: (value) {
                      productsVl.changeproductStatus(value!);
                    },
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                title: "تعديل",
                onTap: () async {
                  await productsVl.editProduct(
                    Product(
                        id: widget.product.id,
                        nameAr: _arName.text,
                        nameEn: _enName.text,
                        categoryId: widget.product.categoryId,
                        priceable: productsVl.priceable),
                    widget.index,
                  );
                  productsVl.changeproductStatus(false);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
