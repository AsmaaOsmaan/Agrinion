import 'package:agriunion/App/GlobalWidgets/app_fab.dart';
import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../Widgets/store_item.dart';
import 'add_products_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إسم المخزن")),
      floatingActionButton: AppFAB(
        onTap: () => AppRoute().navigate(
          context: context,
          route: const AddProductsScreen(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const StoreItem(inList: false),
              SizedBox(
                height: 35,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) =>
                      const StoreProductsTiles(),
                ),
              ),
              const SizedBox(height: 15),
              ...List.generate(5, (index) => const StorageItemDetails()),
            ],
          ),
        ),
      ),
    );
  }
}

class StorageItemDetails extends StatelessWidget {
  const StorageItemDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * .3,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: ColorManager.lightGrey1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "موز (كيلو)",
                style: getBoldStyle(),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("تحويل"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SellBuyRemain.sell(),
              SellBuyRemain.buy(),
              SellBuyRemain.remain(),
            ],
          )
        ],
      ),
    );
  }
}

class SellBuyRemain extends StatelessWidget {
  const SellBuyRemain._({
    Key? key,
    this.color = ColorManager.secondary,
    this.title = "شراء",
    this.count = 10,
  }) : super(key: key);
  const SellBuyRemain.buy({
    Key? key,
    String title = "بيع",
    Color color = ColorManager.secondary,
    int count = 10,
  }) : this._(color: color, count: count, title: title, key: key);
  const SellBuyRemain.sell({
    Key? key,
    String title = "شراء",
    Color color = ColorManager.green,
    int count = 10,
  }) : this._(color: color, count: count, title: title, key: key);
  const SellBuyRemain.remain({
    Key? key,
    String title = "متبقي",
    Color color = ColorManager.error,
    int count = 10,
  }) : this._(color: color, count: count, title: title, key: key);
  final Color color;
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * .15,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(color: ColorManager.lightGrey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AppIcons.arrowDown,
            height: 25,
          ),
          Text(
            title,
            style: getMediumStyle(fontSize: 12),
          ),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "$count",
                style: getBoldStyle(fontColor: ColorManager.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StoreProductsTiles extends StatelessWidget {
  const StoreProductsTiles({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 35,
      decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.white,
          border: Border.all(
            color: ColorManager.lightGrey,
          ),
          borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Text(
          "فواكه",
          style: getRegularStyle(
            fontColor: isSelected ? ColorManager.white : ColorManager.black,
          ),
        ),
      ),
    );
  }
}
