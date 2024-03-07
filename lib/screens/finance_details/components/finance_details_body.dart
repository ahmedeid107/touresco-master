import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/components/exbandable_item_default.dart';

import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/finance_details_view_model.dart';
import 'package:touresco/screens/finance_details/components/finance_trip_list.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FinanceDetailsBody extends StatelessWidget {
    FinanceDetailsBody({Key? key , required this.ownerType, required this.filter}) : super(key: key);
String ownerType;
String filter;
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<FinanceDetailsViewModel>(context, listen: false)
            .syncTrips(ownerType , filter);
      },
    );

    return Consumer<FinanceDetailsViewModel>(
      builder: (context, vm, child) {
        return vm.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : DefaultButton(
                                        buttonWidth: double.infinity,
                                        buttonText: lang.filter,
                                        onpressed: () {
                                          var owner = "";
                                          if(ownerType == "1" || ownerType == "2"){
                                            owner = ownerType;
                                          }else {
                                            if (ownerType == "fromOffice") {
                                              owner = "1";
                                            } else {
                                              owner = "2";
                                            }
                                          }
                                          vm.filterByDate(
                                              context,
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .user
                                                  .id ,
                                              owner,
                                              filter
                                          );
                                        }),
                              ]),
                        ),
                        reverseExpandableList: () {}),
                    if (vm.filteredTrips.isNotEmpty)
                      FinanceTripList(
                        headerTxt:
                            '${lang.filteredResult} ${vm.filteredTrips.length}',
                        trips: vm.filteredTrips,
                        filter: filter,
                      ),
                    FinanceTripList(
                      headerTxt: lang.unpaidTrips,
                      trips: vm.trips,
                      filter: filter,
                    ),
                  ],
                ),
              );
      },
    );
  }

  Row _buildSelectFromDate(
      FinanceDetailsViewModel vm, AppLocalizations lang, BuildContext context) {
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
      FinanceDetailsViewModel vm, AppLocalizations lang, BuildContext context) {
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
          ),
        )
      ],
    );
  }
}
