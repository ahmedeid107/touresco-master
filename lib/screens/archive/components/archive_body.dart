import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/archive_view_model.dart';
import 'package:touresco/screens/archive/components/archived_trips_list.dart';
import 'package:touresco/screens/archive/components/total_archive_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';

import 'archive_abstract.dart';
import 'archive_filter_by_date.dart';

class ArchiveBody extends StatelessWidget {
  const ArchiveBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final String userId =
        Provider.of<AuthProvider>(context, listen: false).user.id;
    Map<int, Widget> filters = <int, Widget>{
      0: Row(
        children: [
          SizedBox(
            width: 2,
          ),
          const Icon(
            Icons.local_activity_sharp,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: ScreenConfig.getXByPerecentScreen(0.012),
          ),
          Text(lang!.driverASD),
        ],
      ),
      1: Row(
        children: [
          const SizedBox(
            width: 2,
          ),
          const Icon(
            Icons.local_activity_sharp,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: ScreenConfig.getXByPerecentScreen(0.012),
          ),
          Text(lang.canceledFlight2),
        ],
      ),
    };

    return FutureBuilder(
      future: Provider.of<ArchiveViewModel>(context, listen: false)
          .syncData(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Consumer<ArchiveViewModel>(
              builder: (context, vm, child) {
                return vm.endedTrips.isEmpty &&  vm.mol2ah.isEmpty
                    ? SizedBox(
                        height: ScreenConfig.getYByPercentScreen(0.7),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: Lottie.asset(
                                  'assets/animations/lottie_empty2.json',
                                  repeat: false),
                            ),
                            Text(
                              lang.thereIsNoArchive,
                              style: textTitle(kPrimaryColor),
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            child: CupertinoSlidingSegmentedControl(
                              groupValue: vm.filterIndex,
                              children: filters,
                              onValueChanged: (value) {
                                vm.filterIndex = value;
                                },
                            ),
                          ),
                          const SizedBox(height: 16),
                          ArchiveFilterByDate(vm: vm),
                          const SizedBox(
                            height: 20,
                          ),
                          vm.filterIndex == 0
                              ? ArchiveAbstract(
                                  archivedTripNo: vm.endedTrips.length,
                                  totalPrice: vm.totalPriceOfAllTrips,
                                )
                              : ArchiveAbstract(
                                  archivedTripNo: vm.mol2ah.length,
                                  totalPrice: vm.totalPriceOfAllTrips,
                                ),
                          const SizedBox(
                            height: 30,
                          ),
                          if (vm.chartResult.isNotEmpty)
                            TotalArchiveChart(
                              chartResults: vm.chartResult,
                              allResults: vm.allResult,
                            ),
                          if ((vm.endedTrips.isNotEmpty&& vm.filterIndex==0))
                            ArchivedTripsList(
                              title: lang.archivedTrips,
                              archivedTrips: vm.endedTrips,
                            ),
                          if ((vm.mol2ah.isNotEmpty&& vm.filterIndex==1))
                            ArchivedTripsList(
                              title: lang.archivedTrips,
                              archivedTrips: vm.mol2ah,
                            )

                        ],
                      );
              },
            ),
          );
        }
      },
    );
  }
}
