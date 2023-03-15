import 'package:flutter/services.dart';

import 'color_manager.dart';

class StatusBarSync {
  void syncStatusBarWithGenAppBar() {
    return SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
        systemNavigationBarColor: ColorManager.black,
        systemNavigationBarDividerColor: ColorManager.black,
        // statusBarBrightness: Brightness.dark,
        // statusBarIconBrightness: Brightness.dark,
        // systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }
}
