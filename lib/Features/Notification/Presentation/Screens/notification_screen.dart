import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/Features/Notification/Presentation/ViewLogic/notification_vl.dart';
import 'package:agriunion/Features/Notification/Presentation/widgets/notification_item_builder.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    context.read<NotificationVL>().getNotification();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<NotificationVL>().managePagination();
      }
    });
    super.initState();
  }

  @override
  void deactivate() {
    context.read<NotificationVL>().restValues();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tr(LocaleKeys.notifications)),
        ),
        body: Consumer<NotificationVL>(builder: (context, vl, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              controller: scrollController,
              itemCount: vl.isLoadMore
                  ? vl.notifications.length + 1
                  : vl.notifications.length,
              itemBuilder: (BuildContext context, int index) {
                if (index >= vl.notifications.length) {
                  return const LoadingView();
                } else {
                  return NotificationItemBuilder(
                    notificationModel: vl.notifications[index],
                    index: index,
                  );
                }
              },
            ),
          );
        }));
  }
}
