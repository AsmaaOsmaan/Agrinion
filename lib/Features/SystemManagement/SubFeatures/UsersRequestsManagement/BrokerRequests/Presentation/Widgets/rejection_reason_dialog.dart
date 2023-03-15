import 'package:agriunion/App/GlobalWidgets/app_text_button.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RejectionReasonDialog extends StatefulWidget {
  const RejectionReasonDialog({Key? key}) : super(key: key);

  @override
  _RejectionReasonDialogState createState() => _RejectionReasonDialogState();
}

class _RejectionReasonDialogState extends State<RejectionReasonDialog> {
  TextEditingController noteController = TextEditingController();

  var rejectionReasonFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          tr(LocaleKeys.add_rejection_reason),
          style: const TextStyle(color: ColorManager.primary),
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: rejectionReasonFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: noteController,
              ),

              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextButton(
                      text: tr(LocaleKeys.send),
                      color: ColorManager.primary,
                      onTap: () {
                        if (rejectionReasonFormKey.currentState!.validate() ) {
                          Navigator.pop(context, {
                            "send": true,
                            "reason": noteController.text
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.defaultSize! * 2,
                  ),
                  Expanded(
                      child: AppTextButton(
                    text: tr(LocaleKeys.cancel1),
                    color: ColorManager.favRed,
                    onTap: () {
                      Navigator.pop(context, {"send": false});
                    },
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}
