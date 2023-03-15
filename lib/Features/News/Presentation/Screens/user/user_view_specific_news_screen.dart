import 'package:flutter/material.dart';

import '../../../../../App/Resources/color_manager.dart';
import '../../../../../App/Utilities/size_config.dart';
import '../../../Domain/Entites/news_model.dart';
import '../../widgets/user_news_container.dart';

class UserViewSpecificNewsScreen extends StatelessWidget {
  const UserViewSpecificNewsScreen(this.model, {Key? key}) : super(key: key);

  final NewsModel model;

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
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * 0.015,
          horizontal: SizeConfig.screenHeight! * 0.012,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorManager.lightGrey1,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              UserNewsContainer(model),
            ],
          ),
        ),
      ),
    );
  }
}
