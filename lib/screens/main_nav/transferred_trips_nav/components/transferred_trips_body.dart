import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/transferred_trips_view_model.dart';
import 'package:touresco/screens/main_nav/transferred_trips_nav/components/transferred_trips_filter.dart';
import 'package:touresco/screens/main_nav/transferred_trips_nav/components/transferred_trips_list.dart';

class TransferredTripsBody extends StatelessWidget {
  const TransferredTripsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<AuthProvider>(context, listen: false).user.id;

    return FutureBuilder(
      future: Provider.of<TransferredTripsViewModel>(context, listen: false)
          .syncTrips(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<TransferredTripsViewModel>(
            builder: (context, vm, child) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [

                        const SizedBox(height: 16),
                        TransferredTripsFilter(
                          value: vm.filter,
                          items: vm.menuItems,
                          onChanged: (value) {
                            vm.filter = value ;
                           },
                          vm: vm,
                        ),

                        const SizedBox(height: 10),
                        if (vm.filter != 'select')
                          TransferredTripsList(
                            trips: vm.getTripsDependOnAppliedFilter,
                            vm: vm,
                          ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}
