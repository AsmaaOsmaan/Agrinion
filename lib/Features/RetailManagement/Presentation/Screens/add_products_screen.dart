import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_text_field.dart';
import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../../../SystemManagement/SubFeatures/Products/Presentation/Screens/products_management_screen.dart';
import 'store_screen.dart';

class AddProductsScreen extends StatelessWidget {
  const AddProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة منتجات"),
        actions: [
          InkWell(
            onTap: () => AppRoute().navigate(
              context: context,
              route: const ProductsManagementScreen(),
            ),
            child: Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.all(10),
              child: Image.asset(
                AppIcons.edit,
                color: ColorManager.black,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                color: ColorManager.lightPrimary.withOpacity(.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("بيانات المورد", style: getBoldStyle(size: 14)),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: BottomSheetTextField(
                            controller: TextEditingController(),
                            onTap: () {},
                            data: const ["hello", "hello"],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          AppIcons.add,
                          color: ColorManager.primary,
                          height: 22,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text("خيارات الدفع", style: getBoldStyle(size: 14)),
                    SizedBox(
                      width: SizeConfig.screenWidth! * .8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          PaymentType(type: "نقدي"),
                          PaymentType(type: "تحويل"),
                          PaymentType(type: "بطاقة"),
                        ],
                      ),
                    ),
                    Text("حدد القسم", style: getBoldStyle(size: 14)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: const [
                              StoreProductsTiles(),
                              StoreProductsTiles(),
                              StoreProductsTiles(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          AppIcons.add,
                          color: ColorManager.primary,
                          height: 22,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AppButton(
                title: "التالي",
                onTap: () => AppRoute().navigate(
                  context: context,
                  route: const ProductsDetailsScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsDetailsScreen extends StatelessWidget {
  const ProductsDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class PaymentType extends StatefulWidget {
  const PaymentType({
    Key? key,
    required this.type,
  }) : super(key: key);
  final String type;

  @override
  State<PaymentType> createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
  String select = "false";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: widget.type,
          groupValue: widget.type,
          onChanged: (value) {
            setState(() {});
          },
        ),
        Text(
          widget.type,
          style: getRegularStyle(fontSize: 12),
        ),
      ],
    );
  }
}
