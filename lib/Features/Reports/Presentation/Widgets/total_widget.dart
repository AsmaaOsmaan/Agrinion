import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/Features/Payment/Domain/Entities/payment.dart';
import 'package:agriunion/Features/Payment/Presentation/ViewLogic/payment_vl.dart';
import 'package:agriunion/Features/Payment/Presentation/screens/payments_screen.dart';
import 'package:agriunion/Features/Payment/payment_validator.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalWidget extends StatelessWidget {
  TotalWidget({Key? key, required this.invoicesModel}) : super(key: key);
  final TextEditingController _paymentAmountKey = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final InvoicesModel invoicesModel;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          itemRow(
              tr(LocaleKeys.total_discount_amount), invoicesModel.discount!,tr(LocaleKeys.riyal)),
          itemRow(tr(LocaleKeys.total_after_tax), "${invoicesModel.totalAfterTax!}",tr(LocaleKeys.riyal)),
          itemRow(
              tr(LocaleKeys.total_tax_amount),"${ invoicesModel.totalTaxAmount!}",tr(LocaleKeys.riyal)),
          itemRow(
              tr(LocaleKeys.tax_rate), "${invoicesModel.taxRate!}","%"),
          Visibility(
            visible: checkVisablity(invoicesModel),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) =>
                                PaymentValidator().validatePayment(value!,invoicesModel.remainingTotal!),
                            controller: _paymentAmountKey,
                            keyboardType: decimalKeyboardType,
                            inputFormatters: decimalInputFormatter,
                            decoration: InputDecoration(
                              hintText: tr(LocaleKeys.payment_amount),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 100,
                          child: AppButton(
                              title: tr(LocaleKeys.pay),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<PaymentVL>()
                                      .createPaymentOnInvoice(
                                          Payment(
                                              paymentAmount: double.parse(
                                                  _paymentAmountKey.text)),
                                          invoicesModel.invoiceId!);
                                  _paymentAmountKey.clear();
                                }
                              },
                              color: Colors.red),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize! * 4,
          ),
          Row(
            children: [
              Expanded(
                child: AppButton(
                    title: tr(LocaleKeys.download_invoice2),
                    onTap: () {
                      context
                          .read<OffersVL>()
                          .showExportedInvoicePdf(invoicesModel.id!);
                    }),
              ),
              const SizedBox(
                width: paddingDistance,
              ),
              Visibility(
                visible: checkVisablity(invoicesModel),
                child: Expanded(
                  child: AppButton(
                      title: tr(LocaleKeys.payments),
                      onTap: () {
                        AppRoute().navigate(
                            context: context,
                            route: PaymentsScreen(
                              invoiceId: invoicesModel.id!,
                            ));
                      }),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget itemRow(String title, String value,String unit) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text("$value " + unit)],
    ),
  );
}

bool checkVisablity(InvoicesModel invoicesModel,) {
  return (invoicesModel.paymentMethod == 'card' ||
      invoicesModel.paymentMethod == 'cash')&&CachHelper.getData(key: kId)!=invoicesModel.creatorId;
}


