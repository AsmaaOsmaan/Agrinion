import 'package:agriunion/Features/Ads/Domain/Validation/ad_validatior.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/app_button.dart';
import '../../../../App/GlobalWidgets/bottom_sheet_text_field.dart';
import '../../../../App/constants/distances.dart';
import '../../../../generated/translations.g.dart';
import '../view_logic/ad_vl.dart';
import 'broker_selection.dart';
import 'farmer_selection.dart';

class AdDetailsStepWidget extends StatefulWidget {
  const AdDetailsStepWidget({
    Key? key,
    required this.type,
    required TextEditingController carNo,
    required TextEditingController carPlate,
    required this.vl,
  })  : _carNo = carNo,
        _carPlate = carPlate,
        super(key: key);

  final String? type;
  final TextEditingController _carNo;
  final TextEditingController _carPlate;
  final AdsVL vl;

  @override
  State<AdDetailsStepWidget> createState() => _AdDetailsStepWidgetState();
}

class _AdDetailsStepWidgetState extends State<AdDetailsStepWidget> {
  final GlobalKey<FormState> _adDetailsFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.vl.clonedAd != null) {
      widget._carNo.text = widget.vl.clonedAd!.carNumber!;
      widget._carPlate.text = widget.vl.clonedAd!.carPlate!;
      widget.vl.negotiable = widget.vl.clonedAd!.negotiable;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _adDetailsFormKey,
          child: ListView(
            children: [
              widget.type == 'Broker'
                  ? FarmerSelection(vl: widget.vl)
                  : BrokerSelection(vl: widget.vl),
              const SizedBox(height: paddingDistance),
              widget.type != 'Broker'
                  ? const SizedBox()
                  : BrokerSelection(vl: widget.vl),
              const SizedBox(height: paddingDistance),
              BottomSheetTextField<String>(
                hint: tr(LocaleKeys.car_number),
                controller: widget._carNo,
                data: List.generate(
                    15, (index) => '${tr(LocaleKeys.car_number)} ${index + 1}'),
                onTap: () => {},
                itemAsString: (item) => item!,
                value: widget._carNo.text,
                validator: (value) =>
                    AdValidator.carValidation(value!, widget.vl.farmer),
              ),
              const SizedBox(height: paddingDistance),
              TextFormField(
                controller: widget._carPlate,
                decoration:
                    InputDecoration(hintText: tr(LocaleKeys.plate_number)),
                validator: (value) =>
                    AdValidator.carValidation(value!, widget.vl.farmer),
              ),
              const SizedBox(height: paddingDistance),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tr(LocaleKeys.nego)),
                  Switch.adaptive(
                    value: widget.vl.negotiable,
                    onChanged: (value) => widget.vl.adNegotiable(value),
                  ),
                ],
              ),
              const SizedBox(height: paddingDistance),
              AppButton(
                title: tr(LocaleKeys.submit),
                onTap: () {
                  if (_adDetailsFormKey.currentState!.validate()) {
                    widget.vl.moveToNextStep();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
