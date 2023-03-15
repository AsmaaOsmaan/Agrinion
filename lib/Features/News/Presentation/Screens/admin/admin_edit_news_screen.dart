import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/News/Domain/Entites/news_model.dart';
import 'package:agriunion/Features/News/Presentation/ViewLogic/news_vl.dart';
import 'package:agriunion/Features/News/Presentation/widgets/news_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../App/Utilities/size_config.dart';
import '../../widgets/add_new_image_icon.dart';
import '../../widgets/image_border.dart';
import '../../widgets/publish_checkbox.dart';

class AdminEditNewsScreen extends StatefulWidget {
  const AdminEditNewsScreen(
      {Key? key,
      required this.index,
      required this.model,
      required this.newsImage})
      : super(key: key);

  final NewsModel model;
  final int index;
  final String? newsImage;

  @override
  State<AdminEditNewsScreen> createState() => _AdminEditNewsScreenState();
}

class _AdminEditNewsScreenState extends State<AdminEditNewsScreen> {
  final TextEditingController titleAr = TextEditingController();
  final TextEditingController titleEn = TextEditingController();
  final TextEditingController bodyAr = TextEditingController();
  final TextEditingController bodyEn = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    titleAr.text = widget.model.titleAr!;
    bodyAr.text = widget.model.bodyAr!;
    titleEn.text = widget.model.titleEn!;
    bodyEn.text = widget.model.bodyEn!;
    context.read<NewsVL>().editPublish = widget.model.published!;

    super.initState();
  }

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
        return Future.value(true);
      },
      child: Consumer<NewsVL>(builder: (context, newsVL, child) {
        return Expanded(
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (widget.model.newImage == null && newsVL.image == null)
                      ? ImageBorder(
                          content: const AddNewImageIcon(), vl: newsVL)
                      : InkWell(
                          onTap: () async => await newsVL.getNewsImage(),
                          child: ImageBorder(
                            content: Center(
                              child: newsVL.image != null
                                  ? NewsImage.file(image: newsVL.image!)
                                  : NewsImage.url(
                                      image: widget.model.newImage!),
                            ),
                            vl: newsVL,
                          ),
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
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  PublishCheckBox(
                    initValue: newsVL.editPublish,
                    onChange: (value) => newsVL.changeEditingPublish(value),
                  ),
                  AppButton(
                    title: tr("edit_news"),
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        NewsModel editedNews = NewsModel(
                          bodyAr: bodyAr.text,
                          bodyEn: bodyEn.text,
                          titleAr: titleAr.text,
                          titleEn: titleEn.text,
                          published: newsVL.editPublish,
                          id: widget.model.id,
                          image: newsVL.image,
                        );
                        await context
                            .read<NewsVL>()
                            .editNews(editedNews, widget.index);

                        Navigator.pop(context);
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
