import 'package:flutter/material.dart';
import 'package:touresco/screens/main_nav/trips/components/trips_body.dart';

class TripsNav extends StatelessWidget {
  const TripsNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: TripsBody());
  }
}
