import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  void navigate(
      {required BuildContext context,
      required Widget route,
      bool withReplace = false}) {
    if (withReplace) {

      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.leftToRightWithFade, child: route));
    } else {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRightWithFade, child: route));
    }
  }

  void navigateAndRemove({
    required BuildContext context,
    required Widget route,
  }) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade, child: route),
        (route) => false);
  }
}
