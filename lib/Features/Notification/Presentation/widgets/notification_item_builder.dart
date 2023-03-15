import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_data_model.dart';
import 'package:agriunion/Features/Notification/Presentation/ViewLogic/notification_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationItemBuilder extends StatelessWidget {
  const NotificationItemBuilder(
      {Key? key, required this.notificationModel, required this.index})
      : super(key: key);
  final NotificationDataModel notificationModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NotificationVL>().readNotification(
            notificationModel.id!, index, notificationModel, context);
      },
      child: Container(
          height: SizeConfig.screenHeight! * .15,
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              border: Border.all(color: ColorManager.lightGrey.withOpacity(.6)),
              color: notificationModel.read!
                  ? ColorManager.lightGrey.withOpacity(.05)
                  : ColorManager.lightGrey,
              borderRadius: radius20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "اعلان منتجات مفضله",
                style: getBoldStyle(fontColor: Colors.blueAccent, size: 16),
              ),
              Text(
                Utils.calculateTheTime(notificationModel.createdAt!),
                style: getMediumStyle(),
              ),
              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              Text(
                notificationModel.message!,
                style: getBoldStyle(),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
    );
  }
}
