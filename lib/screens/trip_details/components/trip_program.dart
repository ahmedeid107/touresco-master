import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:touresco/models/trip_details_model.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class TripProgram extends StatefulWidget {
  TripProgram({Key? key, required this.vm, required this.isType})
      : super(key: key);
  bool? isType;
  final TripDetailsViewModel vm;

  @override
  State<TripProgram> createState() => _TripProgramState();
}

class _TripProgramState extends State<TripProgram> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1), () {
      if (widget.isType == true) {
        widget.vm.isExpandableTripProgram = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ExpandableItemDefault(
        mainTitle: lang!.tripProgram,
        isCurrentExpand: widget.vm.isExpandableTripProgram,
        reverseExpandableList: () {
          widget.vm.isExpandableTripProgram =
              !widget.vm.isExpandableTripProgram;
        },
        expandableWidget: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  for (int i = 0; i < widget.vm.trip.programs.length; i++)
                    _buildProgramItem(widget.vm.trip.programs[i], lang,
                        widget.vm.passengerLoader, widget.vm, (i + 1), context),
                  // _buildProgramItemVertical(lang, vm.passengerLoader, vm)
                ])
              ],
            ),
          ),
        ));
  }

/*
  Widget _buildProgramItemVertical(
      AppLocalizations lang, String loader, TripDetailsViewModel vm) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: lang.startPoint, style: textTitle(kPrimaryColor)),
                TextSpan(
                    text: vm.trip.programs[index].startPoint,
                    style: textTitle1(kTitleBlackTextColor)),
              ])),
              const SizedBox(width: 12),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: lang.endPoint, style: textTitle(kPrimaryColor)),
                TextSpan(
                    text: vm.trip.programs[index].endPoint,
                    style: textTitle1(kTitleBlackTextColor)),
              ])),
              const SizedBox(width: 12),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: lang.startTime, style: textTitle(kPrimaryColor)),
                TextSpan(
                    text: DateFormat.yMEd(
                                ServiceCollector.getInstance().currentLanguage)
                            .format(vm
                                .trip.programs[index].programDateUserDisplay) +
                        ' ' +
                        DateFormat.jm(
                                ServiceCollector.getInstance().currentLanguage)
                            .format(
                                vm.trip.programs[index].programDateUserDisplay),
                    style: textTitle1(kTitleBlackTextColor)),
              ])),
              const SizedBox(width: 12),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: vm.trip.programs.length);
  }*/
  Padding _buildProgramItem(
      SingleTripProgramData program,
      AppLocalizations lang,
      String loader,
      TripDetailsViewModel vm,
      int order,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4,
          ),

          Row(
            children: [
              loader == program.id
                  ? const SizedBox(
                      height: 24, width: 24, child: CircularProgressIndicator())
                  : SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                          value : program.status == '2',
                          onChanged :vm.trip.isOwner ? null : (value) async {
                             if (program.status == '2') {
                              return ;
                            }
                            if ( getTripStatusType(vm.trip.status,
                                    vm.currentTripSource) != // If trip on waiting user can't update data
                                TripStatusData.waitingDriverToTakeTrip ) {
                                  await vm.setSingleProgramToEnd(program.id, context);
                               }
                             },
                          ),
                    ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${lang.program} $order',
                style: textTitle(kPrimaryColor),
              ),
            ],
          ),

          // const Text('🔶 '),
          const SizedBox(
            height: 12,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: lang.startPoint, style: textTitle(kPrimaryColor)),
            TextSpan(
                text: program.startPoint,
                style: textTitle1(kTitleBlackTextColor)),
          ])),
          // const SizedBox(height: 12),
          // RichText(
          //     text: TextSpan(children: [
          //   TextSpan(text: lang.endPoint, style: textTitle(kPrimaryColor)),
          //   TextSpan(
          //       text: program.endPoint,
          //       style: textTitle1(kTitleBlackTextColor)),
          // ])),

          const SizedBox(height: 12),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: lang.startTime, style: textTitle(kPrimaryColor)),
            TextSpan(
                text: DateFormat.yMEd(
                            ServiceCollector.getInstance().currentLanguage)
                        .format(program.programDateUserDisplay) +
                    ' ' +
                    DateFormat.jm(
                        ServiceCollector.getInstance().currentLanguage)
                        .format(program.programDateUserDisplay),
                style: textTitle1(kTitleBlackTextColor)),
          ])),
          const SizedBox(height: 12),
          program.longitude == null || program.longitude == null
              ? Container()
              : Row(
                  children: [
                    const SizedBox(height: 4),

                    Text("${lang.location}: ", style: textTitle(kPrimaryColor)),
                    const SizedBox(width: 4),

                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        _launchMaps(
                          program.latitude ?? 0.0,
                          program.longitude ?? 0.0,
                        );
                      },
                      child: Row(
                        children: [
                          Text(program.endPoint, style: textTitle(Colors.black)),
                          const SizedBox(
                            width: 16,
                          ),

                          const Image(
                            image: AssetImage("assets/images/track.png"),
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(lang.viewLocations,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: kTitleBlackTextColor,
                                decoration: TextDecoration.underline,
                                decorationColor: kPrimaryColor,
                                decorationThickness: 2,
                              )),

                        ],
                      ),
                    )
                  ],
                ),
          const Divider(),
        ],
      ),
    );
  }

  _launchMaps(double lat, double long) async {
    String googleUrl =
        "https://www.google.com/maps/dir/?api=1&destination=$lat,$long&travelmode=driving";
    String appleUrl = 'https://maps.apple.com/?daddr=$lat,$long';

    // 'https://maps.apple.com/?daddr=32.068799,36.080657';
    if (defaultTargetPlatform == TargetPlatform.android) {
      await launchUrl(Uri.parse(googleUrl) );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      await launchUrl(Uri.parse(appleUrl));
    }
  }
}
