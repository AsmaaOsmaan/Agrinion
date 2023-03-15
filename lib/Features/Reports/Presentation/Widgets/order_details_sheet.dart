import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_selection.dart';

class OrderDetailsSheet extends StatefulWidget {
  const OrderDetailsSheet({Key? key}) : super(key: key);

  @override
  State<OrderDetailsSheet> createState() => _OrderDetailsSheetState();
}

class _OrderDetailsSheetState extends State<OrderDetailsSheet> {
  final TextEditingController _discountKey = TextEditingController();
  final TextEditingController _supplyDateKey = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? date;
  @override
  Widget build(BuildContext context) {
    return Consumer<OffersVL>(
      builder: (context, vl, child) {
        return Padding(
          padding: const EdgeInsets.all(paddingDistance),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                SelectionBottomSheet<PaymentMethods>(
                  itemAsString: (value) => tr(value.name),
                  items: PaymentMethods.values,
                  onChange: (PaymentMethods? value) =>
                      vl.setPaymentMethod(value!.index),
                  selectedItem: PaymentMethods.card,
                  hintText: tr(LocaleKeys.payment_method),
                  onClearFn: () => vl.setPaymentMethod(0),
                ),
                const SizedBox(height: paddingDistance),
                TextFormField(
                  validator: (value) => Validator().validateEmpty(value!),
                  controller: _supplyDateKey,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.supply_date),
                  ),
                  onTap: () => Utils.pickDate(
                      context, LocaleKeys.to_date, _supplyDateKey),
                ),
                const SizedBox(height: paddingDistance),
                TextFormField(
                  controller: _discountKey,
                  keyboardType: decimalKeyboardType,
                  inputFormatters: decimalInputFormatter,
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.discount),
                  ),
                ),
                const SizedBox(height: paddingDistance),
                Row(
                  children: [
                    Text(tr(LocaleKeys.taxable)),
                    const SizedBox(width: paddingDistance),
                    Checkbox(
                      value: vl.taxValue,
                      onChanged: (value) {
                        vl.changeTaxValue(value!);
                      },
                    ),
                  ],
                ),
                AppButton(
                  title: tr(LocaleKeys.send),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await vl.exportInvoices(
                          _supplyDateKey.text, _discountKey.text, context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum PaymentMethods { cash, card, bankTransfer }
