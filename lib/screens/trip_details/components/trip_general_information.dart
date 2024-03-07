import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:touresco/components/loading_progress_default.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripGeneralInformation extends StatefulWidget {
  TripGeneralInformation({Key? key, required this.vm, required this.isType})
      : super(key: key);
  bool? isType;
  final TripDetailsViewModel vm;

  @override
  State<TripGeneralInformation> createState() => _TripGeneralInformationState();
}

class _TripGeneralInformationState extends State<TripGeneralInformation> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1), () {
      if (widget.isType == true) {
        widget.vm.isExpandableGeneralInformation = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ExpandableItemDefault(
        mainTitle: lang!.generalInformation,
        isCurrentExpand: widget.vm.isExpandableGeneralInformation,
        reverseExpandableList: () {
          widget.vm.isExpandableGeneralInformation =
              !widget.vm.isExpandableGeneralInformation;
        },
        expandableWidget: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: lang.tripPrice, style: textTitle(kPrimaryColor)),
                  TextSpan(
                      text: '${widget.vm.trip.tripPrice.toString()} ${lang.jd}',
                      style: textTitle1(kTitleBlackTextColor)),
                ])),
                const SizedBox(height: 12),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: lang.phonenum, style: textTitle(kPrimaryColor)),
                  TextSpan(
                      text: widget.vm.trip.contactPhoneNumber,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.vm.callNumber();
                        },
                      style: textTitle1(kTitleBlackTextColor)),
                ])),
                const SizedBox(height: 12),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: lang.tripOwner, style: textTitle(kPrimaryColor)),
                  TextSpan(
                      text: widget.vm.trip.tripCompanyName,
                      style: textTitle1(kTitleBlackTextColor)),
                ])),
                const SizedBox(height: 12),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: lang.commission, style: textTitle(kPrimaryColor)),
                  TextSpan(
                      text: '${widget.vm.trip.tripCommission} ${lang.jd}',
                      style: textTitle1(kTitleBlackTextColor)),
                ])),
                const SizedBox(height: 12),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: lang.tripStartDate,
                          style: textTitle(kPrimaryColor)),
                      TextSpan(
                          text: widget.vm.trip.programs.isEmpty
                              ? ''
                              : DateFormat.yMEd(ServiceCollector.getInstance()
                                      .currentLanguage)
                                  .format(widget.vm.trip.programs[0]
                                      .programDateUserDisplay),
                          style: textTitle1(kTitleBlackTextColor)),
                    ])),
                    const Spacer(),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: widget.vm.trip.programs.isEmpty
                              ? ''
                              : DateFormat.jm(ServiceCollector.getInstance()
                                      .currentLanguage)
                                  .format(widget.vm.trip.programs[0]
                                      .programDateUserDisplay),
                          style: textTitle1(kTitleBlackTextColor)),
                    ])),
                  ],
                ),
                const SizedBox(height: 12),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: lang.paymentDate, style: textTitle(kPrimaryColor)),
                  TextSpan(
                      text: DateFormat.yMEd(
                              ServiceCollector.getInstance().currentLanguage)
                          .format(
                              DateTime.parse(widget.vm.trip.tripPaymentDate)),
                      style: textTitle1(kTitleBlackTextColor)),
                ])),
                if (widget.vm.trip.flightNumber != '0')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: lang.flightNumber,
                            style: textTitle(kPrimaryColor)),
                        TextSpan(
                            text: widget.vm.trip.flightNumber,
                            style: textTitle1(kTitleBlackTextColor)),
                      ])),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: lang.signName,
                                  style: textTitle(kPrimaryColor)),
                              TextSpan(
                                  text: widget.vm.trip.signName ?? lang.none,
                                  style: textTitle1(kTitleBlackTextColor)),
                            ])),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return LoadingProgressDefault(
                                        processText: lang.preparingTheFile,
                                        action: widget.vm.showPassengerSignn(),
                                      );
                                    });
                              },
                              child: Text(
                                lang.print,
                                style: textTitle(kPrimaryColor),
                              )),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      )
                    ],
                  ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ));
  }
}
