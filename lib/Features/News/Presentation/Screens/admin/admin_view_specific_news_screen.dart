import 'package:agriunion/Features/News/Domain/Entites/news_model.dart';
import 'package:flutter/material.dart';

import '../../../../../App/Resources/color_manager.dart';
import '../../../../../App/Utilities/size_config.dart';
import '../../widgets/admin_news_container.dart';

class AdminViewSpecificNewsScreen extends StatelessWidget {
  const AdminViewSpecificNewsScreen(this.newsModel, {Key? key})
      : super(key: key);
  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ]),
      body: Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.screenHeight! * 0.015,
          right: SizeConfig.screenHeight! * 0.012,
          left: SizeConfig.screenHeight! * 0.012,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorManager.lightGrey1,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              AdminNewsContainer(newsModel),
            ],
          ),
        ),
      ),
    );
  }
}
