import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/PricesList/Presentation/ViewLogic/price_list_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/price_cell.dart';
import '../Widgets/product_name_cell.dart';
import '../Widgets/table_header.dart';

class PriceListScreen extends StatelessWidget {
  PriceListScreen({Key? key}) : super(key: key);

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<PriceListVL>(builder: (context, vl, c) {
      return vl.isLoading
          ? const LoadingView()
          : WillPopScope(
              onWillPop: () {
                vl.isSearch = false;
                return Future.value(true);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: vl.isSearch ? null : Text(tr(LocaleKeys.price_list)),
                  automaticallyImplyLeading: !vl.isSearch,
                  actions: [
                    Visibility(
                      visible: vl.isSearch,
                      child: Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          focusNode: _focusNode,
                          onChanged: (value) => vl.filterPriceList(value),
                          decoration: InputDecoration(
                            prefix: IconButton(
                              onPressed: () => vl.changeSearchState(),
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ),
                      )),
                    ),
                    IconButton(
                      onPressed: () {
                        _focusNode.requestFocus();
                        vl.changeSearchState();
                      },
                      icon: const Icon(Icons.search),
                    ),
                    const SizedBox(width: paddingDistance),
                  ],
                ),
                body: Padding(
                    padding: const EdgeInsets.all(paddingDistance),
                    child: Column(
                      children: [
                        const TableHeader(),
                        const SizedBox(height: paddingDistance),
                        Flexible(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: vl.priceableList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: paddingDistance);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  ProductDetailsCell(
                                    model: vl.priceableList[index],
                                  ),
                                  const SizedBox(width: 1),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        PriceCell(
                                          state: tr(LocaleKeys.max),
                                          price:
                                              vl.priceableList[index].maxPrice!,
                                        ),
                                        const SizedBox(height: 1),
                                        PriceCell(
                                          state: tr(LocaleKeys.min),
                                          price:
                                              vl.priceableList[index].minPrice!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    )),
              ),
            );
    });
  }
}
