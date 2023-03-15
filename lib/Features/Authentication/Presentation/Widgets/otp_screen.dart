import 'dart:async';

import 'package:agriunion/Features/Authentication/Presentation/ViewLogic/auth_view_logic.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({
    Key? key,
    this.role,
    this.id,
  }) : super(key: key);
  final String? role;
  final int? id;
  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final _controller = TextEditingController();
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);
  int myTime = 60;
  void checkUser(BuildContext context, String code) {
    context.read<AuthVL>().manageOTPRoute(
          code,
          context,
          widget.role,
          widget.id,
        );
  }

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.text.length == 6) {
        checkUser(context, _controller.text);
      }
    });
    startTimer();
    super.initState();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void setCountDown() {
    ticks++;
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        myTime = myTime - reduceSecondsBy;
        if (myTime <= 0) {
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: myTime);
        }
      });
    }
  }

  int ticks = 0;
  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                child: const Align(
                    alignment: Alignment.centerRight, child: Icon(Icons.close)),
              ),
              SizedBox(
                  height: SizeConfig.screenHeight! * .15,
                  child: Image.asset(AppImages.logoSplash)),
              const SizedBox(height: 20),
              Text(
                tr(LocaleKeys.enterOTP),
                style: getBoldStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                style: getBoldStyle(),
                decoration: InputDecoration(
                    hintText: tr(LocaleKeys.enter_code_here),
                    labelStyle: getBoldStyle()),
              ),
              const Spacer(),
              Text(
                tr(LocaleKeys.time_to_reserve_code),
                textAlign: TextAlign.center,
                style: getBoldStyle(),
              ),
              const SizedBox(height: 15),
              Text(
                "$myTime",
                textAlign: TextAlign.center,
                style: getBoldStyle(fontColor: ColorManager.primary, size: 70),
              ),
              Text(
                tr(LocaleKeys.seconds),
                textAlign: TextAlign.center,
                style: getBoldStyle(),
              ),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: countdownTimer!.isActive
                        ? ColorManager.lightGrey
                        : ColorManager.primary,
                  ),
                  onPressed: () {
                    myTime = ticks < 3 ? 60 : 300;
                    countdownTimer = Timer.periodic(
                        const Duration(seconds: 1), (_) => setCountDown());
                  },
                  child: Text(tr("resend_sms")))
            ],
          ),
        ),
      ),
    );
  }
}
