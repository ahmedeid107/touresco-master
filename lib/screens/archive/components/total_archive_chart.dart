//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:touresco/models/archive_model.dart';
import 'package:touresco/screens/sheets/display_chart_sheet.dart';
 import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//archivedTrips
class TotalArchiveChart extends StatelessWidget {
  const TotalArchiveChart(
      {Key? key, required this.chartResults, required this.allResults})
      : super(key: key);

  final List<SingleArchivedDataResult> chartResults;
  final List<SingleArchivedDataResult> allResults;

  @override
  Widget build(BuildContext context) {

    final lang = AppLocalizations.of(context);
    // List<charts.Series<SingleArchivedDataResult, String>> series = [
    //   charts.Series(
    //     id: 'Totals',
    //     data: chartResults,
    //     domainFn: (SingleArchivedDataResult s, _) => s.name,
    //     measureFn: (SingleArchivedDataResult s, _) => s.numberOfTrips,
    //     labelAccessorFn: (SingleArchivedDataResult s, _) =>
    //         s.numberOfTrips.toString(),
    //   ),
    // ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ExpandableItemDefault(
          mainTitle: lang!.totalResult,
          showExpandIcon: false,
          isCurrentExpand: true,
          expandableWidget: Column(
            children: [
              // SizedBox(
              //     height: ScreenConfig.getYByPercentScreen(0.4),
              //     child: charts.PieChart<String>(
              //       series,
              //       animate: true,
              //       behaviors: [
              //         charts.DatumLegend(
              //             horizontalFirst: false,
              //             desiredMaxRows: 2,
              //             outsideJustification:
              //                 charts.OutsideJustification.endDrawArea)
              //       ],
              //       defaultRenderer: charts.ArcRendererConfig(
              //         arcWidth: 60,
              //         arcRendererDecorators: [charts.ArcLabelDecorator()],
              //       ),
              //     )),
              if (chartResults.any((element) => element.id == 'anasanis#@27'))
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: DefaultButton(
                      buttonWidth: double.infinity,
                      buttonText: lang.displayAll,
                      onpressed: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return DisplayChartSheet(
                                title: lang.allData,
                                chartResults: allResults,
                              );
                            });
                      }),
                )
            ],
          ),
          reverseExpandableList: () {}),
    );
  }
}
