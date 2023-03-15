import 'package:agriunion/Features/News/Domain/Entites/news_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';

class AdminNewsContainer extends StatelessWidget {
  const AdminNewsContainer(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (_newsModel.published == true)
                  ? Text(
                      tr('published'),
                      style: getBoldStyle(
                          fontColor: ColorManager.primary, size: 20),
                    )
                  : Text(
                      tr("not_published"),
                      style:
                          getBoldStyle(fontColor: Colors.redAccent, size: 20),
                    ),
              SizedBox(
                child: Row(
                  children: [
                    Text(Utils.dateFormat(_newsModel.createdAt!)),
                    SizedBox(
                      width: SizeConfig.screenHeight! * 0.015,
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
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
          padding: EdgeInsets.only(
            right: SizeConfig.screenHeight! * 0.03,
            left: SizeConfig.screenHeight! * 0.03,
            top: SizeConfig.screenHeight! * 0.015,
          ),
          child: Text(
            _newsModel.bodyAr!,
            style: getRegularStyle(
              fontSize: 17,
              fontColor: ColorManager.grey,
            ),
          ),
        ),
        Divider(
          color: ColorManager.lightGrey,
          height: SizeConfig.screenHeight! * .09,
          thickness: 1.2,
          endIndent: SizeConfig.screenHeight! * .01,
          indent: SizeConfig.screenHeight! * .01,
        ),
        Container(
          padding: EdgeInsets.only(
            right: SizeConfig.screenHeight! * 0.03,
            left: SizeConfig.screenHeight! * 0.03,
          ),
          height: SizeConfig.screenHeight! * 0.05,
          child: Row(
            children: [
              Text(
                _newsModel.titleEn!,
                style:
                    getMediumStyle(fontSize: 20, fontColor: ColorManager.black),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            right: SizeConfig.screenHeight! * 0.03,
            left: SizeConfig.screenHeight! * 0.03,
            top: SizeConfig.screenHeight! * 0.015,
          ),
          child: Text(
            _newsModel.bodyEn!,
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
