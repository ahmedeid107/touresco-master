import 'package:flutter/material.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArchiveAbstract extends StatelessWidget {
  const ArchiveAbstract(
      {Key? key, required this.archivedTripNo, required this.totalPrice})
      : super(key: key);

  final int archivedTripNo;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ExpandableItemDefault(
          mainTitle: lang!.abstract,
          isCurrentExpand: true,
          showExpandIcon: false,
          expandableWidget: Column(children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  lang.archivedTrips,
                  style: textTitle(kPrimaryColor),
                ),
                Text(
                  archivedTripNo.toString(),
                  style: textTitle(kTitleBlackTextColor),
                ),
                const SizedBox(width: 5),
                Text(
                  lang.trip,
                  style: textSubtitle(kTitleBlackTextColor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            /*
            Row(
              children: [
                Text(
                  lang.totalProfit,
                  style: textTitle(kPrimaryColor),
                ),
                Text(
                  '$totalPrice',
                  style: textTitle(kTitleBlackTextColor),
                ),
                const SizedBox(width: 5),
                Text(
                  lang.jd,
                  style: textSubtitle(kTitleBlackTextColor),
                ),
              ],
            ),
            const SizedBox(height: 10),*/
          ]),
          reverseExpandableList: () {}),
    );
  }
}
