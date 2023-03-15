import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ClientInfoWidget extends StatelessWidget {
  const ClientInfoWidget({Key? key,required this.invoicesModel}) : super(key: key);
  final InvoicesModel invoicesModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius:const BorderRadius.all(
            Radius.circular(10.0)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          columnItem(tr(LocaleKeys.supplier),invoicesModel.supplier!.profileName!),
          invoicesModel.supplier!.address!.isNotEmpty?
          columnItem(tr(LocaleKeys.address),invoicesModel.supplier!.address!):const SizedBox(),
          columnItem(tr(LocaleKeys.tax_number),invoicesModel.supplier!.taxNumber!),
         const Divider(),
          columnItem(tr(LocaleKeys.client),invoicesModel.client!.profileName!),
          invoicesModel.client!.address!.isNotEmpty?
          columnItem(tr(LocaleKeys.address),invoicesModel.client!.address!):const SizedBox(),
          columnItem(tr(LocaleKeys.tax_number),invoicesModel.client!.taxNumber!),

        ],
      ),
    );
  }
  Widget columnItem(String title,String content){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Text(title,style: getSemiBoldStyle(),),
        SizedBox(height: SizeConfig.defaultSize!*0.5,),
        Text(content,style: getBoldStyle())
      ],),
    );
  }
}
