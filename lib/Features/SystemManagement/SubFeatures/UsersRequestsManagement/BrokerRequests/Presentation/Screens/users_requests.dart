import 'package:agriunion/App/GlobalWidgets/app_tab_bar.dart';
import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/ViewLogic/brokers_to_market_requests_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/request_tile.dart';

class UserRequestsScreen extends StatefulWidget {
  const UserRequestsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserRequestsScreen> createState() => _UserRequestsScreenState();
}

class _UserRequestsScreenState extends State<UserRequestsScreen> {
  @override
  void initState() {
    context.read<BrokersToMarketRequestsVL>().getPendingRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(title: Text(tr(LocaleKeys.broker_market_requests))),
        body:
            Consumer<BrokersToMarketRequestsVL>(builder: (context, vl, child) {
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
                              .read<BrokersToMarketRequestsVL>()
                              .getApprovedRequests();

                          break;
                        case 2:
                          context
                              .read<BrokersToMarketRequestsVL>()
                              .getRejectedRequests();

                          break;
                        case 3:
                          context
                              .read<BrokersToMarketRequestsVL>()
                              .getUnlinkedRequests();
                          break;
                        default:
                          context
                              .read<BrokersToMarketRequestsVL>()
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
                              return RequestTile(
                                  request: vl.pendingRequests[index]);
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                    vl.isLoading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.approvedRequests.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RequestTile(
                                  request: vl.approvedRequests[index]);
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                    vl.isLoading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.rejectedRequests.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RequestTile(
                                  request: vl.rejectedRequests[index]);
                            },
                            separatorBuilder: (ctx, index) => const Divider(),
                          ),
                    vl.isLoading
                        ? const LoadingView()
                        : ListView.separated(
                            itemCount: vl.unlinkedRequests.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RequestTile(
                                  request: vl.unlinkedRequests[index]);
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
