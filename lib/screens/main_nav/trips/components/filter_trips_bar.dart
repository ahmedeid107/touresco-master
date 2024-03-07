import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touresco/providers/trips_provider.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilerTripsBar extends StatelessWidget {
  const FilerTripsBar({Key? key, required this.vm}) : super(key: key);

  final TripsProvider vm;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    Map<int, Widget> filters = <int, Widget>{
      0: Row(
        children: [
          SizedBox(width: 2,),
          const Icon(
            Icons.local_activity_sharp,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: ScreenConfig.getXByPerecentScreen(0.012),
          ),
          Text(lang!.active),
         ],
      ),
      1: Row(
        children: [
          const SizedBox(width: 2,),
          const Icon(
            Icons.local_activity_sharp,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: ScreenConfig.getXByPerecentScreen(0.012),
          ),
          Text(lang.pending),

        ],
      ),
    };
    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: CupertinoSlidingSegmentedControl(
        groupValue: vm.filterIndex,
        children: filters,
        onValueChanged: (value) {
          vm.filterIndex = value;
        },
      ),
    );
  }
}
