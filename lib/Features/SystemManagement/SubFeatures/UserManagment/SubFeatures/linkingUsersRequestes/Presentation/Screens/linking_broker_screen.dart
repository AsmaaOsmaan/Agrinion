import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/screens/brokers_item_builder.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/creation_linking_user_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/ViewLogic/linking_users_requests_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../App/GlobalWidgets/loading_view.dart';

class LinkingsBrokersScreen extends StatefulWidget {
  const LinkingsBrokersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LinkingsBrokersScreen> createState() => _LinkingsBrokersScreenState();
}

class _LinkingsBrokersScreenState extends State<LinkingsBrokersScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    context.read<LinkingUsersRequestsVL>().getBrokers();
    context.read<LinkingUsersRequestsVL>().getAllRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LinkingUsersRequestsVL>(
        builder: (context, linkingUsersRequestsVL, child) {
      return WillPopScope(
        onWillPop: () {
          linkingUsersRequestsVL.isSearch = false;
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              tr(LocaleKeys.send_request_to_broker),
            ),
            automaticallyImplyLeading: !linkingUsersRequestsVL.isSearch,
            actions: [
              Visibility(
                visible: linkingUsersRequestsVL.isSearch,
                child: Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    focusNode: _focusNode,
                    onChanged: (value) =>
                        linkingUsersRequestsVL.filterBrokers(value),
                    decoration: InputDecoration(
                      prefix: IconButton(
                        onPressed: () {
                          linkingUsersRequestsVL.changeSearchState();
                          linkingUsersRequestsVL.filterBrokers('');
                        },


                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                )),
              ),
              IconButton(
                onPressed: () {
                  _focusNode.requestFocus();
                  linkingUsersRequestsVL.changeSearchState();
                },
                icon: const Icon(Icons.search),
              ),
              const SizedBox(width: paddingDistance),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: linkingUsersRequestsVL.isLoading
                ? const LoadingView()
                : ListView.separated(
                    itemCount: linkingUsersRequestsVL.brokers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BrokerItemBuilder(
                        broker: linkingUsersRequestsVL.brokers[index],
                        visible: linkingUsersRequestsVL.checkIfSendRequest(
                            linkingUsersRequestsVL.brokers[index].id!),
                        titleButton: 'ارسال الطلب',
                        onTap: () {
                          linkingUsersRequestsVL.createLinkingUser(
                              CreateLinkingUser(
                                  userId: linkingUsersRequestsVL
                                      .brokers[index].id));
                        },
                      );
                    },
                    separatorBuilder: (ctx, index) => const Divider(),
                  ),
          ),
        ),
      );
    });
  }
}
