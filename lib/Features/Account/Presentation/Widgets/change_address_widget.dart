import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangeAddressWidget extends StatefulWidget {
  const ChangeAddressWidget(
      {Key? key,
      required this.address,
      required this.city,
      required this.street,
      required this.neighbourhood,
      required this.postalCode})
      : super(key: key);
  final TextEditingController address;
  final TextEditingController city;
  final TextEditingController neighbourhood;
  final TextEditingController street;
  final TextEditingController postalCode;
  @override
  State<ChangeAddressWidget> createState() => _ChangeAddressWidgetState();
}

class _ChangeAddressWidgetState extends State<ChangeAddressWidget> {
  bool showDetails = false;

  @override
  void initState() {
    setAddressValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.address,
          readOnly: true,
          decoration: InputDecoration(
            hintText: tr(LocaleKeys.address),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  showDetails = !showDetails;
                });
              },
              child: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: showDetails,
          maintainAnimation: true,
          maintainState: true,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    controller: widget.city,
                    decoration: InputDecoration(hintText: tr(LocaleKeys.city)),
                    onChanged: (value) {
                      setAddressValue();
                    },
                  )),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      controller: widget.neighbourhood,
                      decoration: InputDecoration(
                          hintText: tr(LocaleKeys.neighbourhood)),
                      onChanged: (value) {
                        setAddressValue();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    controller: widget.street,
                    decoration:
                        InputDecoration(hintText: tr(LocaleKeys.street_name)),
                    onChanged: (value) {
                      setAddressValue();
                    },
                  )),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      controller: widget.postalCode,
                      decoration:
                          InputDecoration(hintText: tr(LocaleKeys.postal_code)),
                      onChanged: (value) {
                        setAddressValue();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  setAddressValue() {
    widget.address.text = (widget.city.text +
            " " +
            widget.neighbourhood.text +
            " " +
            widget.street.text +
            "   " +
            widget.postalCode.text)
        .trim();
  }
}
