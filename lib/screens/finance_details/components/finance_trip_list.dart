import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/list_item_default.dart';
import 'package:intl/intl.dart';
import 'package:touresco/models/single_finance_trip_model.dart';
import 'package:touresco/providers/view_models/finance_details_view_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/light_trip_model.dart';

class FinanceTripList extends StatelessWidget {
  const FinanceTripList(
      {Key? key, required this.trips, required this.headerTxt, required this.filter})
      : super(key: key);

  final String headerTxt;
  final String filter;
  final List<SingleTripFinanceModel> trips;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: Row(children: [
              Text(
                headerTxt,
                style: textTitle(kNormalTextColor)
                    .copyWith(fontSize: ScreenConfig.getFontDynamic(20)),
              ),
            ])),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: trips.length,
          itemBuilder: (context, index) {
            return ListItemDefault(
                actionIcon: Icons.arrow_right,
                onPressed: () {
                  WidgetsBinding.instance .addPostFrameCallback((timeStamp) {
                    Navigator.of(context).pushNamed('/trip_details_screen',
                        arguments: {
                          'id': trips[index].id,
                          'path': trips[index].tripSource.index.toString()
                        }).then((value) {
                      Provider.of<FinanceDetailsViewModel>(context,
                              listen: false)
                          .clearFilteredTrips();
                      Provider.of<FinanceDetailsViewModel>(context,
                              listen: false)
                          .syncTrips(trips[index].tripSource == TripSource.oirginalSource
                          ?  "fromOffice"
                          :  "fromDriver" ,filter


                      );
                    });
                  });
                },
                leadingImg: 'assets/images/map.png',
                displayData: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${lang!.financialTripSourceId}${ trips[index].Trip_Unchangable_Id.isEmpty? trips[index].id : trips[index].Trip_Unchangable_Id }',
                      style: textSubtitle(kTitleBlackTextColor)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${lang.tripPriceDetails}${trips[index].totalTripPrice.toStringAsFixed(2)} ${lang.jd}',
                      style: textSubtitle(kTitleBlackTextColor),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${lang.expensesPriceDetails}${trips[index].totalExpenses.toStringAsFixed(2)} ${lang.jd}',
                      style: textSubtitle(kTitleBlackTextColor),
                    ),

                    const SizedBox(height: 5),
                    Text(
                      '${lang.totalAmountDues}${((trips[index].totalTripPrice - trips[index].totalCommission )+(trips[index].totalExpenses)).toStringAsFixed(2)} ${lang.jd}',
                      style: textSubtitle(kTitleBlackTextColor),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${lang.paymentDate}${DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage).format(trips[index].paymentDate)}',
                      style: textSubtitle(kTitleBlackTextColor),
                    ),
                  ],
                ));
          },
        )
      ],
    );
  }
}
