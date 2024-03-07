import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/transferred_trips_view_model.dart';

import 'package:touresco/screens/main_nav/transferred_trips_nav/components/transferred_trips_body.dart';

class TransferredTripsNav extends StatelessWidget {
  const TransferredTripsNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TransferredTripsViewModel(),
      child: const TransferredTripsBody(),
    );
  }
}
