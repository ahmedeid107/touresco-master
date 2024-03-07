import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:touresco/components/list_item_default.dart';
import 'package:touresco/models/light_trip_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/transferred_trips_view_model.dart';

import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransferredTripsList extends StatelessWidget {
  const TransferredTripsList({Key? key, required this.trips , required this.vm}) : super(key: key);

  final List<LightTripModel> trips;
  final TransferredTripsViewModel vm;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Provider.of<TransferredTripsViewModel>(context, listen: false)
            .isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : trips.isEmpty
            ? Expanded(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Lottie.asset(
                          'assets/animations/lottie_empty2.json',
                          repeat: false)),
                  Text(
                    lang!.thereAreNoData,
                    style: textTitle(kPrimaryColor),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ))
            : SizedBox(
                height: ScreenConfig.getYByPercentScreen(0.7),
                child: ListView.builder(
                  //   physics: const BouncingScrollPhysics(),
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    return TransferredListItem(
                      lang: lang!,
                      trip: trips[index],
                      vm: vm,
                    );
                  },
                ),
              );
  }
}

class TransferredListItem extends StatelessWidget {
  const TransferredListItem({
    Key? key,
    required this.lang,
    required this.trip,
    required this.vm,
  }) : super(key: key);

  final AppLocalizations lang;
  final LightTripModel trip;
  final TransferredTripsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ListItemDefault(
          leadingImg: 'assets/images/map.png',
          displayData: Column(children: [
            Row(
              children: [
                Text(
                  '${lang.tripNumber}: ',
                  style: textTitle(kPrimaryColor),
                ),
                Text(
                  trip.Trip_Unchangable_Id.isEmpty?trip.id : trip.Trip_Unchangable_Id,
                  style: textTitle1(kNormalTextColor),
                )
              ],
            ),
            const SizedBox(height: 10),
            if (trip.tripType.typeName.isNotEmpty)
              Row(
                children: [
                  Text(
                    lang.tripType,
                    style: textTitle(kPrimaryColor),
                  ),
                  Text(
                    trip.tripType.typeName,
                    style: textTitle1(kNormalTextColor),
                  )
                ],
              ),
            if (trip.tripType.typeName.isNotEmpty) const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  lang.tripPrice,
                  style: textTitle(kPrimaryColor),
                ),
                Text(
                  '${trip.price} ${lang.jd}',
                  style: textTitle1(kNormalTextColor),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  lang.passedOn,
                  style: textTitle(kPrimaryColor),
                ),
                Expanded(
                  child: Text(
                    trip.Trip_Time_In_System,
                    style: TextStyle(
                        color: kNormalTextColor,
                     ),
                  ),
                )
              ],
            ),
           if(trip.driverName.isNotEmpty) const SizedBox(height: 10),

           if(trip.driverName.isNotEmpty) Row(
              children: [
                Text(
                  lang.driverName +": ",
                  style: textTitle(kPrimaryColor),
                ),
                Expanded(
                  child: Text(
                    trip.driverName,
                    style: TextStyle(
                        color: kNormalTextColor,
                     ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 10),
            if (trip.tripOwner.isNotEmpty) Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: lang.tripOwner, style: textTitle(kPrimaryColor)),
                      TextSpan(
                          text: trip.tripOwner,
                          style: textTitle1(kNormalTextColor)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  lang.tripClassification,
                  style: textTitle(kPrimaryColor),
                ),
                Text(
                  trip.getTripClassicifcationAsText,
                  style: textTitle1(kNormalTextColor),
                )
              ],
            ),

          ]),
          onPressed: () {

            Navigator.of(context).pushNamed('/trip_details_screen', arguments: {
              'id': trip.id,
              'path': trip.tripSource.index.toString(),
              "type":vm.filter =="pending" || vm.filter =="canceldByDriver" ?"Abed":""
            }).then((value) {
              Provider.of<TransferredTripsViewModel>(context, listen: false)
                  .syncTrips(
                      Provider.of<AuthProvider>(context, listen: false).user.id,
                      false);
            });
          },
          actionIcon: Icons.arrow_right),
    );
  }
}
