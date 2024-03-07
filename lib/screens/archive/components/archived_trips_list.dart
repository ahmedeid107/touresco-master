import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:touresco/components/list_item_default.dart';
import 'package:touresco/models/archive_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArchivedTripsList extends StatelessWidget {
  const ArchivedTripsList(
      {Key? key, required this.archivedTrips, required this.title})
      : super(key: key);

  final String title;
  final List<SingleArchivedTrip> archivedTrips;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: textTitle(kNormalTextColor).copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: archivedTrips.length,
            itemBuilder: (context, index) {
              return ListItemDefault(
                  leadingImg: 'assets/images/map.png',
                  displayData: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${lang!.tripNumber}: ',
                            style: textTitle(kPrimaryColor),
                          ),
                          Text(
                            archivedTrips[index].Trip_Unchangable_Id.isEmpty?archivedTrips[index].id : archivedTrips[index].Trip_Unchangable_Id
                                 ,
                            style: textTitle(kNormalTextColor),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            lang.tripType,
                            style: textTitle(kPrimaryColor),
                          ),
                          Text(
                            archivedTrips[index].tripType,
                            style: textTitle(kTitleBlackTextColor),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            lang.payment,
                            style: textTitle(kPrimaryColor),
                          ),
                          Text(
                            DateFormat.yMEd(ServiceCollector.getInstance()
                                    .currentLanguage)
                                .format(archivedTrips[index].date),
                            style: textTitle(kTitleBlackTextColor),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            lang.price,
                            style: textTitle(kPrimaryColor),
                          ),
                          Text(
                            '${archivedTrips[index].price} ${lang.jd}',
                            style: textTitle(kTitleBlackTextColor),
                          )
                        ],
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/trip_details_screen', arguments: {
                      'id': archivedTrips[index].id,
                      'path': archivedTrips[index].tripSource.index.toString()
                    });
                  },
                  actionIcon: Icons.arrow_right);
            },
          )
        ],
      ),
    );
  }
}
