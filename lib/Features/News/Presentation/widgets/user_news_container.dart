import 'package:agriunion/Features/News/Domain/Entites/news_model.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';

class UserNewsContainer extends StatelessWidget {
  const UserNewsContainer(
    this._newsModel, {
    Key? key,
  }) : super(key: key);

  final NewsModel _newsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: SizeConfig.screenHeight! * .25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(_newsModel.newImage!, fit: BoxFit.cover),
        ),
        Padding(
          padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(Utils.dateFormat(_newsModel.createdAt!)),
              SizedBox(
                width: SizeConfig.screenHeight! * 0.015,
              ),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenHeight! * 0.03,
          ),
          height: SizeConfig.screenHeight! * 0.05,
          child: Row(
            children: [
              Text(
                _newsModel.titleAr!,
                style:
                    getMediumStyle(fontSize: 20, fontColor: ColorManager.black),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenHeight! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.015,
          ),
          child: Text(
            _newsModel.bodyAr!,
            style: getRegularStyle(
              fontSize: 17,
              fontColor: ColorManager.grey,
            ),
          ),
        ),
      ],
    );
  }
}
