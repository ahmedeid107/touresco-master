import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/trips_provider.dart';
import 'package:touresco/components/trips_list.dart';
import 'package:touresco/screens/main_nav/explore/components/role_status.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExploreBody extends StatelessWidget {
  const ExploreBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    WidgetsBinding.instance .addPostFrameCallback(
      (timeStamp) {
        String id = Provider.of<AuthProvider>(context, listen: false).user.id;

        Provider.of<TripsProvider>(context, listen: false)
            .syncAndFetchTrips(id);
      },
    );
    return Consumer<TripsProvider>(
      builder: (context, tripsProvider, child) {
        if (tripsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
             physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 50,),

                tripsProvider.trips.isEmpty
                    ? const RoleStatus()
                    : Column(
                        children: [
                          if (tripsProvider.searchedTrips.isNotEmpty)
                            TripsList(
                              title:
                                  '${lang!.youSearchedFor} "${tripsProvider.searchText}"',
                              trips: tripsProvider.searchedTrips,
                              refreshName: 'explore',
                            ),
                          TripsList(
                            title: lang!.availableTrips,
                            trips: tripsProvider.trips,
                            refreshName: 'explore',
                          )
                        ],
                      )
              ],
            ),
          ),
        );
      },
    );
  }
  void search(String value, BuildContext context) {
    Provider.of<TripsProvider>(context, listen: false).searchForTrips(value);
  }
}
