import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touresco/providers/view_models/groups_view_model.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupsFilter extends StatelessWidget {
  const GroupsFilter({Key? key, required this.vm}) : super(key: key);

  final GroupsViewModel vm;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    Map<int, Widget> filters = <int, Widget>{
      0: Row(
        children: [
          const Icon(
            Icons.local_activity_sharp,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: ScreenConfig.getXByPerecentScreen(0.01),
          ),
          Text(lang!.myGroups)
        ],
      ),
      1: Row(
        children: [
          const Icon(
            Icons.local_activity_sharp,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: ScreenConfig.getXByPerecentScreen(0.01),
          ),
          Text(lang.otherGroups)
        ],
      ),
    };
    return Container(
      margin: const EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: CupertinoSlidingSegmentedControl(
        groupValue: vm.selectedFilter,
        children: filters,
        onValueChanged: (value) {
           vm.selectedFilter = value;
        },
      ),
    );
  }
}
