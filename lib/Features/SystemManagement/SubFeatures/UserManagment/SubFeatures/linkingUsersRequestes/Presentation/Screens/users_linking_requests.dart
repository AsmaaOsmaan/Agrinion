import 'package:agriunion/App/GlobalWidgets/app_tab_bar.dart';
import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/ViewLogic/linking_users_requests_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/linking_user_request_tile.dart';

class UsersLinkingRequestsScreen extends StatefulWidget {
  const UsersLinkingRequestsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UsersLinkingRequestsScreen> createState() =>
      _UsersLinkingRequestsScreenState();
}

class _UsersLinkingRequestsScreenState
    extends State<UsersLinkingRequestsScreen> {
  bool? parent;
  bool? hasParent;
  int? id;
  @override
  void initState() {
    id = CachHelper.getData(key: kId);
    context.read<LinkingUsersRequestsVL>().getPendingRequests();
    context.read<LinkingUsersRequestsVL>().getBrokerStatus();
    super.initState();
  }

  @override
  void deactivate() {
    context.read<LinkingUsersRequestsVL>().getBrokerStatus();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(title: Text(tr(LocaleKeys.linking_users_requests))),
        body: Consumer<LinkingUsersRequestsVL>(builder: (context, vl, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                AppTabBar(
                  tabBar: TabBar(
                    onTap: (index) {
                      switch (index) {
                        case 1:
                          context
                              .read<LinkingUsersRequestsVL>()
                              .getApprovedRequests();

                          break;
                        case 2:
                          context
                              .read<LinkingUsersRequestsVL>()
                              .getRejectedRequests();

                          break;
                        case 3:
                          context
                              .read<LinkingUsersRequestsVL>()
                              .getExpiredRequests();

                          break;
                        default:
                          context
                              .read<LinkingUsersRequestsVL>()
                              .getPendingRequests();
                      }
                    },
                    tabs: [
                      Tab(text: tr(LocaleKeys.pending)),
                      Tab(text: tr(LocaleKeys.accepted)),
                      Tab(text: tr(LocaleKeys.rejected)),
                      Tab(text: tr(LocaleKeys.unlinked)),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    vl.isLoading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.pendingRequests.length,
                            itemBuilder: (BuildContext context, int index) {
                              return LinkingUserRequestTile(
                                request: vl.pendingRequests[index],
                                parent: vl.brokerStatus!.parent!,
                                id: id,
                                hasParent: vl.brokerStatus!.hasParent!,
                              );
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                    vl.isLoading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.approvedRequests.length,
                            itemBuilder: (BuildContext context, int index) {
                              return LinkingUserRequestTile(
                                request: vl.approvedRequests[index],
                                parent: vl.brokerStatus!.parent!,
                                id: id,
                                hasParent: vl.brokerStatus!.hasParent!,
                              );
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                    vl.isLoading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.rejectedRequests.length,
                            itemBuilder: (BuildContext context, int index) {
                              return LinkingUserRequestTile(
                                request: vl.rejectedRequests[index],
                                parent: vl.brokerStatus!.parent!,
                                id: id,
                                hasParent: vl.brokerStatus!.hasParent!,
                              );
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                    vl.isLoading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.expiredRequests.length,
                            itemBuilder: (BuildContext context, int index) {
                              return LinkingUserRequestTile(
                                request: vl.expiredRequests[index],
                                parent: vl.brokerStatus!.parent!,
                                id: id,
                                hasParent: vl.brokerStatus!.hasParent!,
                              );
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                  ]),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
