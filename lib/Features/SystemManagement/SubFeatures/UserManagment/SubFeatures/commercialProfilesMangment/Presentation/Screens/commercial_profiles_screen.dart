import 'package:agriunion/App/GlobalWidgets/app_fab.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Presentation/Widgets/update_commercial_profile.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Logic/user_managment_vl.dart';
import '../Widgets/add_commercial_profile.dart';
import '../Widgets/commercial_profile_item_builder.dart';

class CommercialProfilesScreen extends StatefulWidget {
  const CommercialProfilesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CommercialProfilesScreen> createState() =>
      _CommercialProfilesScreenState();
}

class _CommercialProfilesScreenState extends State<CommercialProfilesScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    context.read<UserManagementVL>().getCommercialProfiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagementVL>(
        builder: (context, userManagementVl, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(tr(LocaleKeys.commercial_profiles)),
          automaticallyImplyLeading: !userManagementVl.isSearch,
          actions: [
            Visibility(
              visible: userManagementVl.isSearch,
              child: Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: _focusNode,
                  onChanged: (value) =>
                      userManagementVl.filterCommercialProfile(value),
                  decoration: InputDecoration(
                    prefix: IconButton(
                      onPressed: () {
                        userManagementVl.changeSearchState();
                        userManagementVl.filterCommercialProfile('');
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
                userManagementVl.changeSearchState();
              },
              icon: const Icon(Icons.search),
            ),
            const SizedBox(width: paddingDistance),
          ],
        ),
        floatingActionButton: AppFAB(
          onTap: () => BottomSheetHelper(
            context: context,
            content: const AddCommercialProfileSheet(),
          ).openFullSheet(),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: userManagementVl.isLoading
              ? const LoadingView()
              : ListView.separated(
                  itemCount: userManagementVl.commercialProfiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemBuilderCP(
                      title: userManagementVl
                          .commercialProfiles[index].profileName!,
                      subTitle:
                          tr(userManagementVl.commercialProfiles[index].type!),
                      onDelete: () => userManagementVl.deleteCommercialProfile(
                        userManagementVl.commercialProfiles[index],
                      ),
                      onUdpate: () => BottomSheetHelper(
                        context: context,
                        content: UpdateCommercialProfileSheet(
                          index: index,
                          commercialProfileModel:
                              userManagementVl.commercialProfiles[index],
                        ),
                      ).openFullSheet(),
                    );
                  },
                  separatorBuilder: (ctx, index) => const Divider(),
                ),
        ),
      );
    });
  }

}
