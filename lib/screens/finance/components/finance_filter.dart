import 'package:flutter/material.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FinanceFilter extends StatelessWidget {
  const FinanceFilter(
      {Key? key,
      required this.value,
      required this.items,
      required this.onChanged})
      : super(key: key);

  final String value;
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ExpandableItemDefault(
        mainTitle: lang!.filter,
        isCurrentExpand: true,
        expandableWidget: Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownButton(
              underline: Container(),

              isExpanded: true,
              value: value,
              items: items,
              onChanged: onChanged),
        ),
        reverseExpandableList: () {});
  }
}
