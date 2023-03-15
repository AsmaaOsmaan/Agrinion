import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/sales_returns_entity.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/Features/Offers/sales_return_validator.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSalesReturnScreen extends StatelessWidget {
  CreateSalesReturnScreen(
      {Key? key,
      required this.conversationId,
      required this.index,
      required this.conversation})
      : super(key: key);
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final int conversationId;
  final int index;
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: nonDecimalInputFormatter,
                validator: (value) => SalesReturnValidator()
                    .validateCreateSalesReturn(
                        value!, conversation.lastOffer!.quantity!),
                controller: _contentController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    hintText: tr(LocaleKeys.quantity)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              child: AppButton(
                  title: tr(LocaleKeys.create_sales_returns),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<OffersVL>().createSalesReturn(
                          SalesReturn(
                              conversationId: conversationId,
                              quantity: int.parse(_contentController.text)),
                          context,
                          conversationId,
                          index);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
