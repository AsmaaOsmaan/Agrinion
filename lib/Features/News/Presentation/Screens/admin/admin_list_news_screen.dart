import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/Features/News/Presentation/Screens/admin/admin_edit_news_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../App/GlobalWidgets/app_dialogs.dart';
import '../../../../../App/GlobalWidgets/app_fab.dart';
import '../../../../../App/GlobalWidgets/bottom_sheet_helper.dart';
import '../../../../../App/GlobalWidgets/delete_confirmation_dialog.dart';
import '../../../../../App/Utilities/size_config.dart';
import '../../../../../generated/translations.g.dart';
import '../../ViewLogic/news_vl.dart';
import '../../widgets/admin_news_container.dart';
import 'admin_create_news_screen.dart';
import 'admin_view_specific_news_screen.dart';

class AdminListNewsScreen extends StatefulWidget {
  const AdminListNewsScreen({Key? key}) : super(key: key);

  @override
  _AdminListNewsScreenState createState() => _AdminListNewsScreenState();
}

class _AdminListNewsScreenState extends State<AdminListNewsScreen> {
  @override
  void initState() {
    context.read<NewsVL>().listAllNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
          title: Text(tr(LocaleKeys.news)),
          backgroundColor: ColorManager.lightGrey1),
      floatingActionButton: AppFAB(
        onTap: () => BottomSheetHelper(
          context: context,
          content: const AdminCreateNewsScreen(),
        ).openFullSheet(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenHeight! * 0.012,
          vertical: SizeConfig.screenHeight! * 0.01,
        ),
        child: Consumer<NewsVL>(builder: (context, newsVL, child) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  AppRoute().navigate(
                      context: context,
                      route:
                          AdminViewSpecificNewsScreen(newsVL.newsList[index]));
                },
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight! * 0.01,
                  ),
                  margin: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight! * 0.02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorManager.lightGrey1,
                  ),
                  child: Column(
                    children: [
                      AdminNewsContainer(newsVL.newsList[index]),
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenHeight! * 0.03,
                          right: SizeConfig.screenHeight! * 0.03,
                          top: SizeConfig.screenHeight! * 0.03,
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: Text(tr(LocaleKeys.edit)),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorManager.green,
                                ),
                                onPressed: () {
                                  BottomSheetHelper(
                                    context: context,
                                    content: AdminEditNewsScreen(
                                      model: newsVL.newsList[index],
                                      index: index,
                                      newsImage:
                                          newsVL.newsList[index].newImage,
                                    ),
                                  ).openFullSheet();
                                },
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth! * 0.05,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                child: Text(
                                  tr(LocaleKeys.delete),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent,
                                ),
                                onPressed: () {
                                  AppDialogs(context).showDelete(
                                    content:
                                        DeleteConfirmationDialog(onDelete: () {
                                      newsVL.deleteNews(newsVL.newsList[index]);
                                    }),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: newsVL.newsList.length,
            padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.01),
          );
        }),
      ),
    );
  }
}
