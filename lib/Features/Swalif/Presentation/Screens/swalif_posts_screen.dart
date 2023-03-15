import 'package:agriunion/App/GlobalWidgets/app_fab.dart';
import 'package:agriunion/App/GlobalWidgets/app_tab_bar.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/Features/Swalif/Presentation/widgets/add_post_screen.dart';
import 'package:agriunion/Features/Swalif/Presentation/widgets/post_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/constants/keys.dart';

class SwalifPostsScreen extends StatefulWidget {
  const SwalifPostsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SwalifPostsScreen> createState() => _SwalifPostsScreenState();
}

class _SwalifPostsScreenState extends State<SwalifPostsScreen> {
  int? userId;
  @override
  void initState() {
    context.read<SwalifVL>().getAllSwalifPosts();
    userId = CachHelper.getData(key: kId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text(tr(LocaleKeys.swalif))),
        floatingActionButton: AppFAB(
          onTap: () => BottomSheetHelper(
            context: context,
            content: AddPostScreen(),
          ).openFullSheet(),
        ),
        body: Consumer<SwalifVL>(builder: (context, vl, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                AppTabBar(
                  tabBar: TabBar(
                    onTap: (index) {
                      switch (index) {
                        case 1:
                          vl.getMySwalifPosts();
                          break;

                        default:
                          vl.getAllSwalifPosts();
                      }
                    },
                    tabs: [
                      Tab(text: tr(LocaleKeys.swalif)),
                      Tab(text: tr(LocaleKeys.my_swalif)),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    vl.loading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.posts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PostWidget(
                                swalifPostModel: vl.posts[index],
                                userId: userId!,
                                deleteFunction:(){
                                  vl.deletePostWithoutNavigation(vl.posts[index],index);
                                },
                                index: index,
                              );
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                    vl.loading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.posts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PostWidget(
                                swalifPostModel: vl.posts[index],
                                userId: userId!,
                                deleteFunction:(){
                                  vl.deletePostWithoutNavigation(vl.posts[index], index);
                                },
                                index: index,
                              );
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                  ]),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
