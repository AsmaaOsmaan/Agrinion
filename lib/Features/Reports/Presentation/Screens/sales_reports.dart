import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/client_entity.dart';
import 'package:agriunion/Features/Reports/Presentation/ViewLogic/reports_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../../App/constants/values.dart';
import '../../../../generated/translations.g.dart';
import '../../Domian/Entities/sales_reports_entity.dart';
import '../../Domian/Validator/sales_reports_validator.dart';

class GenerateSalesReports extends StatefulWidget {
  const GenerateSalesReports({
    Key? key,
  }) : super(key: key);

  @override
  State<GenerateSalesReports> createState() => _GenerateSalesReportsState();
}

class _GenerateSalesReportsState extends State<GenerateSalesReports> {
  final TextEditingController _fromDate = TextEditingController();
  final TextEditingController _toDate = TextEditingController();
  final TextEditingController _invoiceNumber = TextEditingController();
  final TextEditingController _clientNumber = TextEditingController();

  @override
  void initState() {
    context.read<ReportsVL>().getProducts();
    context.read<ReportsVL>().getClients();
    super.initState();
  }

  @override
  void dispose() {
    _fromDate.dispose();
    _toDate.dispose();
    _invoiceNumber.dispose();
    _clientNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportsVL>(builder: (context, vl, ch) {
      return WillPopScope(
        onWillPop: () {
          vl.setClient(null);
          vl.setProduct(null);
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(title: Text(tr('salesReports'))),
          body: Padding(
            padding: const EdgeInsets.all(paddingDistance),
            child: Column(
              children: [
                SelectionBottomSheet<Product>(
                  itemAsString: (u) => u.nameAr,
                  items: vl.products,
                  onChange: (value) => vl.setProduct(value),
                  selectedItem: vl.product,
                  hintText: tr(LocaleKeys.product),
                  onClearFn: () => vl.setProduct(null),
                ),
                const SizedBox(height: paddingDistance),
                SelectionBottomSheet<Client>(
                  itemAsString: (u) => u.profileName!,
                  items: vl.clients!,
                  onChange: (value) => vl.setClient(value),
                  selectedItem: vl.client,
                  hintText: tr(LocaleKeys.client),
                  onClearFn: () => vl.setClient(null),
                ),
                const SizedBox(height: paddingDistance),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: tr(LocaleKeys.phone),
                      labelStyle: getRegularStyle(fontColor: ColorManager.grey),
                      hintText: "55 - xxxx - xxx",
                      suffixText: "|  +966  ",
                      suffixStyle: getBoldStyle(fontColor: ColorManager.grey),
                      hintStyle: getSemiBoldStyle()),
                  style: getBoldStyle(),
                  controller: _clientNumber,
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: false),
                  inputFormatters: [
                    ...nonDecimalInputFormatter,
                    LengthLimitingTextInputFormatter(9)
                  ],
                  validator: (value) =>
                      SalesReportsValidator.validatePhone("0" + value!),
                ),
                const SizedBox(height: paddingDistance),
                TextFormField(
                  controller: _invoiceNumber,
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.invoice_number),
                  ),
                ),
                const SizedBox(height: paddingDistance),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _fromDate,
                        readOnly: true,
                        onTap: () => Utils.pickDate(
                            context, LocaleKeys.from_date, _fromDate),
                        decoration: InputDecoration(
                          hintText: tr(LocaleKeys.start_date),
                        ),
                      ),
                    ),
                    const SizedBox(width: paddingDistance),
                    Expanded(
                      child: TextFormField(
                        controller: _toDate,
                        readOnly: true,
                        onTap: () => Utils.pickDate(
                            context, LocaleKeys.to_date, _toDate),
                        decoration: InputDecoration(
                          hintText: tr(LocaleKeys.end_date),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  title: tr(LocaleKeys.submit),
                  onTap: () {
                    vl.report = SalesReportEntity(
                      clientId: vl.client?.id,
                      clientName: vl.client?.profileName,
                      clientNumber: _clientNumber.text,
                      fromDate: _fromDate.text,
                      invoiceNumber: _invoiceNumber.text,
                      productId: vl.product?.id,
                      toDate: _toDate.text,
                    );
                    return vl.exportSalesReport();
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
