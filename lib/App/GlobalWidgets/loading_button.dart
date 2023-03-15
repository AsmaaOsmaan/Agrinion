import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'custom_button_animation.dart';

class LoadingButton extends StatelessWidget {
  final GlobalKey<CustomButtonState>? btnKey;
  final String title;
  final Function() onTap;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final GlobalKey? buttonKey;

  const LoadingButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderColor,
    this.width,
    this.buttonKey,
    this.btnKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color border = color ?? ColorManager.primary;
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          CustomButtonAnimation(
            key: btnKey,
            onTap: onTap,
            width: width ?? MediaQuery.of(context).size.width,
            minWidth: 45,
            height: 45,
            color: color ?? ColorManager.primary,
            borderRadius: borderRadius ?? 10,
            borderSide: BorderSide(color: borderColor ?? border, width: 1),
            child: Text(
              title,
              style: getRegularStyle(),
            ),
            loader: Container(
              padding: const EdgeInsets.all(10),
              child: const SpinKitRotatingCircle(
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
