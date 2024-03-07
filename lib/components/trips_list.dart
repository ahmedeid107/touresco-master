import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/trip_item_default.dart';
import 'package:touresco/models/light_trip_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/trips_provider.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
//asd -- asd --
class TripsList extends StatelessWidget {
  const TripsList(
      {Key? key,
      required this.title,
      required this.trips,
      required this.refreshName})
      : super(key: key);

  final String title;
  final List<LightTripModel> trips;
  final String refreshName;

  @override
  Widget build(BuildContext context) {
    // trips.sort((a, b) => a.d.compareTo(b.someProperty))
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top:   ScreenConfig.getYByPercentScreen(0.061),
        right: ScreenConfig.getXByPerecentScreen(0.05),
        left:  ScreenConfig.getXByPerecentScreen(0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTitle(kTitleBlackTextColor)
                .copyWith(fontSize: ScreenConfig.getFontDynamic(18)),
          ),
          const SizedBox(height: 16,),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              return TripItemDefault(
                currentLanguage: ServiceCollector.getInstance().currentLanguage,
                trip: trips[index],
                onPressed: (value) {
                  Navigator.of(context).pushNamed('/trip_details_screen',
                      arguments: {
                        'id':   value,
                        'path': trips[index].tripSource.index.toString(),
                        "type": '',
                        "details": trips[index].getTripClassicifcationAsText,
                      },).then((_) {
                    if (refreshName == 'explore') {
                      WidgetsBinding.instance
                          .addPostFrameCallback((timeStamp) {
                        Provider.of<TripsProvider>(context, listen: false)
                            .syncAndFetchTrips(Provider.of<AuthProvider>(
                                    context,
                                    listen: false)
                                .user
                                .id,
                        );
                      });
                    } else if (refreshName == 'trips') {
                      Provider.of<TripsProvider>(context, listen: false).syncAndFetchUserTrips(Provider.of<AuthProvider>(context,listen:false ).user.id,false);
                    }
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
