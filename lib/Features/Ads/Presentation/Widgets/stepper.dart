import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/market_step_widget.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/product_details_step_widget.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/subcategory_stepper_body.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_button.dart';
import '../../../../App/Utilities/cache_helper.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/constants/keys.dart';
import '../view_logic/ad_vl.dart';
import 'ad_details_step.dart';
import 'ad_summary_step_widget.dart';
import 'add_product_item.dart';
import 'category_stepper_body.dart';
import 'city_step_widget.dart';

class StepperDemo extends StatefulWidget {
  const StepperDemo({Key? key}) : super(key: key);

  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  String? type;

  final TextEditingController _productMinCount = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productWeight = TextEditingController();
  final TextEditingController _productCount = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  final TextEditingController _carNo = TextEditingController();
  final TextEditingController _carPlate = TextEditingController();
  @override
  void initState() {
    type = CachHelper.getData(key: kType);

    super.initState();
  }

  @override
  void dispose() {
    _productMinCount.dispose();
    _productPrice.dispose();
    _productWeight.dispose();
    _productCount.dispose();
    _notes.dispose();
    _carNo.dispose();
    _carPlate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsVL>(builder: (ctx, vl, child) {
      return WillPopScope(
        onWillPop: () async => await _showExitDialog(vl),
        child: Scaffold(
          appBar: AppBar(title: Text(tr(LocaleKeys.add_product))),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                NumberStepper(
                  enableNextPreviousButtons: false,
                  numbers: List.generate(vl.steps.length, (index) => index + 1),
                  activeStep: vl.activeStep,
                  activeStepColor: ColorManager.primary,
                  numberStyle: getRegularStyle(fontColor: ColorManager.white),
                  stepColor: ColorManager.lightPrimary,
                  onStepReached: (index) => vl.moveStep(index),
                  stepRadius: 20,
                ),
                header(),
                getBody(ctx, vl),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getBody(BuildContext ctx, AdsVL vl) {
    switch (vl.activeStep) {
      case 1:
        return vl.category == null || vl.category!.isCategoryGroup
            ? SubCategoriesStepperBody(vl: vl)
            : CityStepWidget(cities: vl.cities);
      case 2:
        return CityStepWidget(cities: vl.cities);
      case 3:
        return MarketsStepWidget(markets: vl.markets, type: type);
      case 4:
        return AdDetailsStepWidget(
            type: type, carNo: _carNo, carPlate: _carPlate, vl: vl);
      case 5:
        return ProductDetailsStepWidget(
          productPrice: _productPrice,
          productWeight: _productWeight,
          productCount: _productCount,
          productMinCount: _productMinCount,
          notes: _notes,
        );
      case 6:
        return getProductsStepperBody(ctx, vl);
      case 7:
        return AdSummaryStepWidget(carNo: _carNo, carPlate: _carPlate, vl: vl);
      default:
        return CategoriesStepperBody(vl: vl);
    }
  }

  Future<bool> _showExitDialog(AdsVL vl) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: SizeConfig.screenHeight! * .2,
          padding: const EdgeInsets.all(paddingDistance * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tr("discardProgressMsg"), style: getBoldStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      tr(LocaleKeys.cancel1),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      vl.clearLastAdCreation();
                    },
                    child: Text(
                      tr(LocaleKeys.ok),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return result ?? false;
  }

  Widget getSubCategoriesStepperBody(BuildContext context, AdsVL vl) {
    return Expanded(
      child: vl.isLoading
          ? const LoadingView()
          : ListView.separated(
              itemCount: vl.subCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: vl.subCategories[index].isSelected
                      ? const Icon(Icons.check)
                      : const SizedBox(),
                  onTap: () {
                    vl.setSubCategory(index);
                    vl.getCities();
                  },
                  title: Text(
                    vl.subCategories[index].name,
                    style: getBoldStyle(),
                  ),
                  trailing: vl.subCategories[index].isCategoryGroup
                      ? const Icon(Icons.arrow_forward_ios, size: 15)
                      : const SizedBox(),
                );
              },
              separatorBuilder: (ctx, index) => const Divider(
                color: ColorManager.lightGrey,
                thickness: .8,
              ),
            ),
    );
  }

  Widget getProductsStepperBody(BuildContext context, AdsVL vl) {
    return Expanded(
        child: Column(
      children: [
        const SizedBox(height: paddingDistance),
        Wrap(
          children: List.generate(
            vl.adProducts.length,
            (index) => AdProductItem(product: vl.adProducts[index]),
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Flexible(
              child: AppButton(
                title: tr(LocaleKeys.add_products),
                onTap: () => vl.previousStep(),
              ),
            ),
            const SizedBox(width: paddingDistance),
            Flexible(
              child: AppButton(
                title: tr(LocaleKeys.adSummary),
                onTap: () => vl.moveToNextStep(),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String headerText() {
    switch (context.watch<AdsVL>().activeStep) {
      case 1:
        return tr("selectSubCategory");

      case 2:
        return tr(LocaleKeys.select_city);

      case 3:
        return tr(LocaleKeys.select_market);

      case 4:
        return tr(LocaleKeys.ad_details);

      case 5:
        return tr(LocaleKeys.add_product);

      case 6:
        return tr(LocaleKeys.products);
      case 7:
        return tr(LocaleKeys.adSummary);

      default:
        return tr(LocaleKeys.select_category);
    }
  }
}
