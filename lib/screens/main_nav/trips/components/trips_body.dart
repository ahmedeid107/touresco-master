import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/trips_list.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/trips_provider.dart';
import 'package:touresco/screens/main_nav/trips/components/filter_trips_bar.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/utils/screen_config.dart';

class TripsBody extends StatelessWidget {
  const TripsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    String userId = Provider.of<AuthProvider>(context, listen: false).user.id;

    return FutureBuilder(
      future: Provider.of<TripsProvider>(context, listen: false)
          .syncAndFetchUserTrips(userId, false),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<TripsProvider>(
            builder: (context, vm, child) {
              if (vm.isLoading) {}

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      FilerTripsBar(
                        vm: vm,
                      ),
                      vm.getTripsDependOnStatusChange.isEmpty
                          ? SizedBox(
                              height: ScreenConfig.screenDeviceHeight * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 300,
                                    width: 300,
                                    child: Lottie.asset(
                                        'assets/animations/lottie_empty2.json',
                                        repeat: false),
                                  ),
                                  Text(
                                    '${lang!.thereAreNo} ${vm.currentNamedStatusError}',
                                    style: textTitle(kPrimaryColor),
                                  ),
                                ],
                              ),
                            )
                          : Consumer<TripsProvider>(
                              builder: (context, value, child) {
                              return TripsList(
                                title: vm.currentNamedStatus,
                                trips: vm.getTripsDependOnStatusChange,
                                refreshName: 'trips',
                              );
                            })
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
