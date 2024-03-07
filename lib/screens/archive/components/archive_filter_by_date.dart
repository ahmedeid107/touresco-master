import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/archive_view_model.dart';
import 'package:touresco/screens/archive/components/archived_trips_list.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';

class ArchiveFilterByDate extends StatelessWidget {
  const ArchiveFilterByDate({Key? key, required this.vm}) : super(key: key);

  final ArchiveViewModel vm;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Column(
      children: [
        ExpandableItemDefault(
            mainTitle: lang!.filtering,
            isCurrentExpand: true,
            expandableWidget: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSelectFromDate(vm, lang, context),
                    const SizedBox(height: 10),
                    _buildSelectToDate(vm, lang, context),
                    const SizedBox(height: 10),
                    vm.isFiltering
                        ? const Center(child: CircularProgressIndicator())
                        : DefaultButton(
                            buttonWidth: double.infinity,
                            buttonText: lang.filter,
                            onpressed: () {
                              vm.filterByDate(
                                  context,
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .user
                                      .id);
                            }),
                  ]),
            ),
            reverseExpandableList: () {}),
        if (vm.filteredTrips.isNotEmpty)
          ArchivedTripsList(
              title: lang.filteredResult, archivedTrips: vm.filteredTrips)
      ],
    );
  }

  Row _buildSelectFromDate(
      ArchiveViewModel vm, AppLocalizations lang, BuildContext context) {
    return Row(
      children: [
        Text(
          lang.fromDate,
          style: textTitle(kPrimaryColor),
        ),
        Expanded(
          child: Text(
            vm.fromDateTxt,
            style: textTitle(kNormalTextColor),
          ),
        ),
        Material(
          child: InkWell(
            onTap: () {
              vm.setFromDate(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                lang.select,
                style: textTitle(kPrimaryColor),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row _buildSelectToDate(
      ArchiveViewModel vm, AppLocalizations lang, BuildContext context) {
    return Row(
      children: [
        Text(
          lang.toDate,
          style: textTitle(kPrimaryColor),
        ),
        Expanded(
          child: Text(
            vm.toDateTxt,
            style: textTitle(kNormalTextColor),
          ),
        ),
        Material(
            child: InkWell(
          onTap: () {
            vm.setToDate(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              lang.select,
              style: textTitle(kPrimaryColor),
            ),
          ),
        ))
      ],
    );
  }
}
