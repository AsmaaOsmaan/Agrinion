import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Authentication/Presentation/ViewLogic/auth_view_logic.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_text_field.dart';
import '../../../../App/GlobalWidgets/custom_button_animation.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../Domain/Models/user_request_model.dart';
import '../Screens/forget_password.dart';

part 'login_content.dart';
part 'register_content.dart';
