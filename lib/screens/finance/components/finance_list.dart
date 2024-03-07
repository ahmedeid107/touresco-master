import 'package:flutter/material.dart';import 'package:touresco/components/list_item_default.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/models/light_trip_model.dart';
import 'package:touresco/models/single_finance_model.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';

class FinanceList extends StatelessWidget {
  const FinanceList({Key? key, required this.finances, required this.title, required this.filter})
      : super(key: key);
  final List<SingleFinanceModel> finances;
  final String title;
  final String filter;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
            left: 10,
            bottom: 10,
          ),
          child: Text(
            title,
            style: textTitle(kTitleBlackTextColor)
                .copyWith(fontSize: ScreenConfig.getFontDynamic(18)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: finances.length,
            itemBuilder: (context, index) {
              return ListItemDefault(
                  actionIcon: Icons.arrow_right,
                  onPressed: () {
                    print("ASDASD ${finances[index].tripSource.index}");
                    Navigator.of(context)
                        .pushNamed('/finance_details_screen', arguments: {
                      'id': finances[index].id,
                      'title': finances[index].name,
                      'type':'',
                      "ownerType":finances[index].tripSource.index.toString(),
                      'tripSource': finances[index].tripSource.index.toString(),
                      "filter": filter
                    }).then((value) {

                    });
                  },
                  leadingImg: 'assets/images/img_finance.png',
                  displayData: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        finances[index].name,
                        style: textTitle(kPrimaryColor),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${lang!.totalTripsPrice}${finances[index].totalTripPrice.toStringAsFixed(2)}${lang.jd}',
                        style: textSubtitle(kTitleBlackTextColor),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${lang.totalExpenses}${finances[index].totalExpenses.toStringAsFixed(2)}${lang.jd}',
                        style: textSubtitle(kTitleBlackTextColor),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${lang.totalDues}${ ((finances[index].totalTripPrice - finances[index].totalCommission )+(finances[index].totalExpenses)).toStringAsFixed(2)}${lang.jd}',
                        style: textSubtitle(kTitleBlackTextColor),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        finances[index].tripSource == TripSource.oirginalSource
                            ? lang.fromOffice
                            : lang.fromDriver,
                        style: textSubtitle(kPrimaryColor)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
