import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/models/trip_details_model.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/auth_provider.dart';

class TripStatus extends StatelessWidget {
  const TripStatus({Key? key, required this.vm}) : super(key: key);

  final TripDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 20, horizontal: ScreenConfig.getXByPerecentScreen(0.02)),
      child: Column(
        children: [
          if (getTripStatusType(vm.trip.status, vm.currentTripSource) ==
                  TripStatusData.waitingDriverToTakeTrip &&
              !vm.trip.isOwner)
            _agreeOrCancelTripStatus(context, vm, lang),
          if (getTripStatusType(vm.trip.status, vm.currentTripSource) ==
                  TripStatusData.waitingDriverToTakeTrip &&
              vm.trip.isOwner)
            _ownerWantToCancelTrip(context, vm, lang),
          if (getTripStatusType(vm.trip.status, vm.currentTripSource) ==
              TripStatusData.ownerWantToCancelTrip)
            _ownerWantToCancelTrip(context, vm, lang),
          //0000000000000
          if (getTripStatusType(vm.trip.status, vm.currentTripSource) ==
                  TripStatusData.driverTakeTripButNotFinsihIt &&
              !vm.trip.isOwner)
            _endTrip(vm, context, lang),
          if (getTripStatusType(vm.trip.status, vm.currentTripSource) ==
                  TripStatusData.driverFinishTripButNotGetPaid &&
              !vm.trip.isOwner)
            _getPaid(vm, context, lang),
          if ((getTripStatusType(vm.trip.status, vm.currentTripSource) ==
                  TripStatusData.driverFinishTripAndGetPaid) &&
              vm.trip.tripArchivedDate.isNotEmpty)
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (c) {
                        return AlertDialog(
                          title: Text(lang.askArchive),
                          content: Text(lang.learnArchive),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                vm.getPaidForAllTrip(context, true);
                              },
                              child: Text(lang.yes),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                vm.getPaidForAllTrip(context, false);
                              },
                              child: Text(lang.no),
                            ),
                          ],
                        );
                      });
                },
                child: Text(
                    '${lang.tripIsEnd} ${DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage).format(DateTime.parse(vm.trip.tripArchivedDate))}',
                    style: textTitle(kPrimaryColor))),

          if ((getTripStatusType(vm.trip.status, vm.currentTripSource) ==
                  TripStatusData.tirpOwner) &&
              vm.trip.isOwner)
            DefaultButton(
              buttonWidth: double.infinity,
              buttonText: lang.cancel,
              onpressed: () {
                print("ADSASDASDDSA");
                vm.cancelTrip(context, "can");
              },
              backgroundColor: Colors.white,
              textColor: kTitleBlackTextColor,
            ),
          if ((getTripStatusType(vm.trip.status, vm.currentTripSource) ==
                  TripStatusData.tirpOwner) &&
              !vm.trip.isOwner)
            DefaultButton(
              buttonWidth: double.infinity,
              buttonText: lang.takeTrip,
              onpressed: () {
                print("#######################");
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        titlePadding: EdgeInsets.zero,
                        shadowColor: Colors.grey[500],
                        title: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  topLeft: Radius.circular(16)),
                              color: kPrimaryColor),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            lang.alert,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        content: Text(lang.advise),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(8)),
                                child: TextButton(
                                  onPressed: () {

                                    vm.takeGeneralRole(Provider.of<AuthProvider>(context, listen: false).user.id);

                                    vm.agreeToThisTrip(context);
                                    Navigator.pop(context);

                                  },
                                  child: Text(
                                    lang.takeTrip,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(8)),
                                child: TextButton(
                                  onPressed: () {
                                    vm.agreeToThisTrip(context);
                                    Navigator.pop(context);

                                    },
                                  child: Text(
                                    lang.no,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    });
                //
              },
            ),
        ],
      ),
    );
  }

  Column _agreeOrCancelTripStatus(
      BuildContext context, TripDetailsViewModel vm, AppLocalizations? lang) {
    return Column(
      children: [
        if (vm.trip.status != '22')
          DefaultButton(
            buttonWidth: double.infinity,
            buttonText: lang!.cancel,
            onpressed: () {
              vm.cancelTrip(context, "reject");
            },
            backgroundColor: Colors.white,
            textColor: kTitleBlackTextColor,
          ),
        const SizedBox(height: 10),
        DefaultButton(
          buttonWidth: double.infinity,
          buttonText: lang!.takeTrip,
          onpressed: () {
            print("#######################");

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    titlePadding: EdgeInsets.zero,
                    shadowColor: Colors.grey[500],

                    title: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16)),
                          color: kPrimaryColor),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        lang.alert,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    content: Text(lang.advise),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(.7),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextButton(
                              onPressed: () {
                                vm.takeGeneralRole(Provider.of<AuthProvider>(context, listen: false).user.id);

                                vm.agreeToThisTrip(context);

 Navigator.pop(context);
                              },
                              child: Text(
                                lang.takeTrip,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(.7),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextButton(
                              onPressed: () {
                                vm.agreeToThisTrip(context);
                                Navigator.pop(context);


                                },
                              child: Text(
                                lang.no,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                });

            // vm.agreeToThisTrip(context);
          },
        ),
      ],
    );
  }

  Column _ownerWantToCancelTrip(
      BuildContext context, TripDetailsViewModel vm, AppLocalizations? lang) {
    return Column(
      children: [
        DefaultButton(
          buttonWidth: double.infinity,
          buttonText: lang!.cancelTrip,
          onpressed: () {
            vm.cancelTrip(context, "can");
          },
        ),
      ],
    );
  }

  Column _endTrip(
      TripDetailsViewModel vm, BuildContext context, AppLocalizations? lang) {
    return Column(
      children: [
        const SizedBox(height: 10),
        DefaultButton(
          buttonWidth: double.infinity,
          buttonText: lang!.endTrip,
          onpressed: () {
            vm.endTrip(context);
          },
        ),
      ],
    );
  }

  Column _getPaid(
      TripDetailsViewModel vm, BuildContext context, AppLocalizations? lang) {
    return Column(
      children: [
        const SizedBox(height: 10),
        DefaultButton(
          buttonWidth: double.infinity,
          buttonText: lang!.getPaid,
          onpressed: () {
            showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: Text(lang.askArchive),
                  content: Text(lang.learnArchive),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        vm.getPaidForAllTrip(context, true);
                      },
                      child: Text(lang.yes),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        vm.getPaidForAllTrip(context, false);
                      },
                      child: Text(lang.no),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
