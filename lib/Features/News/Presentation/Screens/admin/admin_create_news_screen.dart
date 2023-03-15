import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/News/Domain/Entites/news_model.dart';
import 'package:agriunion/Features/News/Presentation/ViewLogic/news_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../App/GlobalWidgets/loading_dialog.dart';
import '../../../../../App/Utilities/size_config.dart';
import '../../widgets/add_new_image_icon.dart';
import '../../widgets/image_border.dart';
import '../../widgets/news_image.dart';
import '../../widgets/publish_checkbox.dart';

class AdminCreateNewsScreen extends StatefulWidget {
  const AdminCreateNewsScreen({Key? key}) : super(key: key);

  @override
  State<AdminCreateNewsScreen> createState() => _AdminCreateNewsScreenState();
}

class _AdminCreateNewsScreenState extends State<AdminCreateNewsScreen> {
  final TextEditingController titleAr = TextEditingController();
  final TextEditingController titleEn = TextEditingController();
  final TextEditingController bodyAr = TextEditingController();
  final TextEditingController bodyEn = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleAr.dispose();
    titleEn.dispose();
    bodyAr.dispose();
    bodyEn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<NewsVL>().image = null;
        context.read<NewsVL>().createPublish = false;
        return Future.value(true);
      },
      child: Consumer<NewsVL>(builder: (context, newsVL, child) {
        return Expanded(
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  newsVL.image == null
                      ? ImageBorder(
                          content: const AddNewImageIcon(), vl: newsVL)
                      : ImageBorder(
                          content: NewsImage.file(image: newsVL.image!),
                          vl: newsVL,
                        ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                  TextFormField(
                    controller: titleAr,
                    decoration: InputDecoration(
                      hintText: tr("title_in_arabic"),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => Validator().validateEmpty(value!),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                  TextFormField(
                    controller: bodyAr,
                    decoration: InputDecoration(
                      hintText: tr("news_in_arabic"),
                    ),
                    maxLines: 6,
                    validator: (value) => Validator().validateEmpty(value!),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                  TextFormField(
                    controller: titleEn,
                    decoration: InputDecoration(
                      hintText: tr("title_in_english"),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) => Validator().validateEmpty(value!),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                  TextFormField(
                    controller: bodyEn,
                    decoration: InputDecoration(
                      hintText: tr("news_in_english"),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 6,
                    validator: (value) => Validator().validateEmpty(value!),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                  PublishCheckBox(
                    initValue: newsVL.createPublish,
                    onChange: (value) => newsVL.changeCreatePublish(value),
                  ),
                  AppButton(
                    title: tr("add_news"),
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        if (context.read<NewsVL>().image == null) {
                          LoadingDialog.showSimpleToast(
                              tr("Please_select_an_image"));
                        } else {
                          await context.read<NewsVL>().createNews(
                                NewsModel(
                                  bodyEn: bodyEn.text,
                                  bodyAr: bodyAr.text,
                                  titleEn: titleEn.text,
                                  titleAr: titleAr.text,
                                  published: newsVL.createPublish,
                                  image: newsVL.image,
                                ),
                              );

                          Navigator.pop(context);
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
