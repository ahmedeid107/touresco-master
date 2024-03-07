import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:touresco/components/sliver_app_bar_main.dart';
import 'package:touresco/providers/trips_provider.dart';
import 'package:touresco/screens/main_nav/explore/components/explore_body.dart';
import '../../../providers/auth_provider.dart';

class ExploreNav extends StatelessWidget {
  const ExploreNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance .addPostFrameCallback(
          (timeStamp) {
        String id = Provider.of<AuthProvider>(context, listen: false).user.id;

        Provider.of<TripsProvider>(context, listen: false)
            .syncAndFetchTrips(id);
      },
    );
    return NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBarMain(onPressed: () => navigateToTakeRole(context)),
           ];
        },
        body: const ExploreBody());
  }

  void search(String value, BuildContext context) {
    Provider.of<TripsProvider>(context, listen: false).searchForTrips(value);
  }

  void navigateToTakeRole(BuildContext context) {
    //   Navigator.of(context).pushNamed('/take_role_screen');
  }
}
