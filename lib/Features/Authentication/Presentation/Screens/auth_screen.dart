import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../Widgets/auth_imports.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                // onTap: () => MyRoute().navigate(context: context, route: HomeScreen()),
                child: const Align(
                    alignment: Alignment.centerRight, child: Icon(Icons.close)),
              ),
              SizedBox(
                  height: SizeConfig.screenHeight! * .1,
                  child: Image.asset(AppImages.logo)),
              const SizedBox(height: 20),
              SizedBox(
                width: SizeConfig.screenWidth! * .8,
                child: TabBar(
                    unselectedLabelColor: ColorManager.secondary,
                    labelColor: Colors.white,
                    controller: tabController,
                    indicator: BoxDecoration(
                      color: ColorManager.green,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                    tabs: [
                      Tab(
                        text: tr("signin"),
                      ),
                      Tab(
                        text: tr("signup"),
                      ),
                    ]),
              ),
              Flexible(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
                    LoginContent(),
                    RegisterContent(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
