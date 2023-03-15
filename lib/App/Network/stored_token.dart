import 'package:agriunion/App/Utilities/globale_state.dart';

import '../Utilities/cache_helper.dart';

import '../constants/keys.dart';

String token = GlobalState.instance.get(kToken) ??
    CachHelper.getData(key: kToken) ??
    CachHelper.getData(key: kToken) ??
    "";

