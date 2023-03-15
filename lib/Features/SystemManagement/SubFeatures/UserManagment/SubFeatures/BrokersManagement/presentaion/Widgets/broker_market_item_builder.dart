import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/logic/broker_management_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrokerMarketItemBuilder extends StatelessWidget {
  final BrokerMarket brokerMarket;
  final int brokerId;
  final int index;
  const BrokerMarketItemBuilder({Key? key, required this.brokerMarket,required this.brokerId,required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.defaultSize! * 3,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ColorManager.lightGrey1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            " ${brokerMarket.city!.nameAr} /${brokerMarket.market!.nameAr}",
            overflow: TextOverflow.ellipsis,
          )),
           GestureDetector(
             onTap: (){
               context.read<BrokerManageVL>().unLinkRequests(brokerId, brokerMarket.market!.id!, index);
             },
             child:const Icon(
              Icons.cancel,
              color: Colors.red,
              
          ),
           )
        ],
      ),
    );
  }
}
