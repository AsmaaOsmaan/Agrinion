import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/News/Presentation/Screens/user/user_view_specific_news_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../App/Utilities/app_route.dart';
import '../../../../../App/Utilities/size_config.dart';
import '../../../../../generated/translations.g.dart';
import '../../ViewLogic/news_vl.dart';
import '../../widgets/user_news_container.dart';

class UserListNewsScreen extends StatefulWidget {
  const UserListNewsScreen({Key? key}) : super(key: key);

  @override
  _UserListNewsScreenState createState() => _UserListNewsScreenState();
}

class _UserListNewsScreenState extends State<UserListNewsScreen> {
  @override
  void initState() {
    context.read<NewsVL>().homeListAllNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
          title: Text(tr(LocaleKeys.news)),
          backgroundColor: ColorManager.lightGrey1),
      body: Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.screenHeight! * 0.01,
          right: SizeConfig.screenHeight! * 0.015,
          left: SizeConfig.screenHeight! * 0.015,
        ),
        child: Consumer<NewsVL>(builder: (context, newsVL, child) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  AppRoute().navigate(
                    context: context,
                    route: UserViewSpecificNewsScreen(newsVL.newsList[index]),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight! * 0.02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorManager.lightGrey1,
                  ),
                  child: Column(
                    children: [
                      UserNewsContainer(newsVL.newsList[index]),
                    ],
                  ),
                ),
              );
            },
            itemCount: newsVL.newsList.length,
          );
        }),
      ),
    );
  }
}
