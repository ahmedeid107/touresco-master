import 'package:flutter/material.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:touresco/models/trip_details_model.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';

class TripPassengers extends StatefulWidget {
    TripPassengers({Key? key,required this.vm, required this.isType}) : super(key: key);
  bool ? isType;
  final TripDetailsViewModel vm;

  @override
  State<TripPassengers> createState() => _TripPassengersState();
}

class _TripPassengersState extends State<TripPassengers> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1), () {
      if (widget.isType==true) {
        widget.vm.isExpandablePassenger = true;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final lang = AppLocalizations.of(context);
    return ExpandableItemDefault(
        mainTitle: lang!.tripPassengers,
        isCurrentExpand: widget.vm.isExpandablePassenger,
        reverseExpandableList: () {
          widget.vm.isExpandablePassenger = !widget.vm.isExpandablePassenger;
        },
        expandableWidget: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                   scrollDirection: Axis.horizontal,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (SinglePassengerData passenger
                            in widget.vm.trip.passengers)
                          _buildProgramItem(passenger, lang),
                      ]),
                )
              ],
            ),
          ),
        ));
  }

  Padding _buildProgramItem(
      SinglePassengerData passenger, AppLocalizations lang) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        children: [
          const Text('🔶 '),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: lang.name, style: textTitle(kPrimaryColor)),
            TextSpan(
                text: passenger.passengerName,
                style: textTitle1(kTitleBlackTextColor)),
          ])),
          const SizedBox(width: 12),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: lang.passport, style: textTitle(kPrimaryColor)),
            TextSpan(
                text: passenger.passengerPassport,
                style: textTitle1(kTitleBlackTextColor)),
          ])),
          const SizedBox(width: 12),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: lang.nationality, style: textTitle(kPrimaryColor)),
            TextSpan(
                text: ServiceCollector.getInstance().currentLanguage == 'en'
                    ? passenger.passengerNationalityEn
                    : passenger.passengerNationalityAr,
                style: textTitle1(kTitleBlackTextColor)),
          ])),
          const SizedBox(width: 12),
         passenger.passengerPhone!=null ?  RichText(
              text: TextSpan(children: [
                TextSpan(text: "${lang.phoneNumber} : ", style: textTitle(kPrimaryColor)),
                TextSpan(
                    text: ServiceCollector.getInstance().currentLanguage == 'en'
                        ? passenger.passengerPhone
                        : passenger.passengerPhone,
                    style: textTitle1(kTitleBlackTextColor)),
              ])):Container(),
        ],
      ),
    );
  }
}
