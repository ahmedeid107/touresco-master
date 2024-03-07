import 'package:flutter/material.dart';
import 'package:touresco/models/archive_model.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisplayChartSheet extends StatelessWidget {
  const DisplayChartSheet(
      {Key? key, required this.title, required this.chartResults})
      : super(key: key);

  final String title;
  final List<SingleArchivedDataResult> chartResults;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: ScreenConfig.getYByPercentScreen(0.4),
          child: Column(children: [
            const SizedBox(height: 12),
            Text(
              title,
              style: textTitle(kPrimaryColor),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            chartResults[index].name,
                            style: textTitle(kPrimaryColor),
                          ),
                        ),
                        Text(
                          chartResults[index].numberOfTrips.toString(),
                          style: textTitle(kNormalTextColor),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          lang!.trip,
                          style: textSubtitle(kNormalTextColor),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Divider();
                  },
                  itemCount: chartResults.length),
            ),
            const SizedBox(
              height: 12,
            ),
          ]),
        ),
      ),
    );
  }
}
