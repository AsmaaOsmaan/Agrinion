import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/app_fab.dart';
import '../../../../App/GlobalWidgets/app_tab_bar.dart';
import '../../../../App/GlobalWidgets/filter_bar.dart';
import '../Widgets/bill_list_item.dart';
import 'add_bills_screen.dart';
import 'stores_screen.dart';

class RetailManagement extends StatefulWidget {
  const RetailManagement({Key? key}) : super(key: key);

  @override
  State<RetailManagement> createState() => _RetailManagementState();
}

class _RetailManagementState extends State<RetailManagement>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: AppFAB(onTap: () {
          if (_controller!.index == 0) {
            AppRoute().navigate(context: context, route: const AddBillScreen());
          } else {
            AppRoute().navigate(context: context, route: const StoresScreen());
          }
        }),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * .05),
              FilterBar(
                onTap: () => print,
                title: "الفواتير",
                trailing: Image.asset(AppIcons.filtering),
              ),
              AppTabBar(
                tabBar: TabBar(
                  controller: _controller,
                  tabs: const [
                    Tab(text: "المبيعات"),
                    Tab(text: "المشتريات"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: TabBarView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) =>
                          const BillListItem(isBuying: true),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) =>
                          const BillListItem(isBuying: false),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
