import 'package:agriunion/Features/News/Domain/Entites/news_model.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../App/GenericBloC/generic_cubit.dart';
import '../../../../App/GlobalWidgets/BottomNavBar/bottom_tab_model.dart';
import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../../App/constants/values.dart';
import '../../../News/Presentation/Screens/user/user_list_news_screen.dart';
import '../../../News/Presentation/Screens/user/user_view_specific_news_screen.dart';
import '../../../News/Presentation/ViewLogic/news_vl.dart';

part 'circle_container.dart';
part 'home_container.dart';
part 'home_data.dart';
part 'home_news.dart';
part 'news_container.dart';
