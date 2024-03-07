import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:touresco/models/light_trip_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripItemDefault extends StatelessWidget {
  const TripItemDefault(
      {Key? key,
      required this.trip,
      required this.onPressed,
      required this.currentLanguage})
      : super(key: key);

  final String currentLanguage;
  final LightTripModel trip;
  final Function(String value) onPressed;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5, left: 0, bottom: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(46, 70, 135, 225),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //#id and image
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 33,
                    height: 33,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '${lang!.trip} ${trip.Trip_Unchangable_Id.isEmpty ? trip.id : trip.Trip_Unchangable_Id}',
                      style: textTitle(kLightGreyColor),
                    ),
                  ),
                  const Spacer(),
                  Text(trip.getTripClassicifcationAsText,
                      style: textSubtitle(kNormalTextColor)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    trip.getTripClassicifcationAsIcon,
                    style: textSubtitle(kNormalTextColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(height: 14),

/*
              //Trip Classification
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: lang!.tripClassification,
                        style: textTitle(kPrimaryColor)),
                    TextSpan(
                        text: trip.getTripClassicifcationAsText,
                        style: textTitle(kNormalTextColor)),
                  ],
                ),
              ),

              const SizedBox(height: 10),*/

              //TripOwner
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: lang.tripOwner, style: textTitle(kPrimaryColor)),
                    TextSpan(
                        text: trip.tripOwner,
                        style: textTitle1(kNormalTextColor)),
                  ],
                ),
              ),
              if (trip.tripType.typeName.isNotEmpty) const SizedBox(height: 10),

              //trip type
              if (trip.tripType.typeName.isNotEmpty)
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: lang.tripType, style: textTitle(kPrimaryColor)),
                  TextSpan(
                      text: currentLanguage == 'en'
                          ? trip.tripType.typeNameEn
                          : trip.tripType.typeNameAr,
                      style: textTitle1(kNormalTextColor)),
                ])),

              const SizedBox(height: 10),
              //Price
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: lang.price, style: textTitle(kPrimaryColor)),
                    TextSpan(
                        text: '${trip.price} ${lang.jd}',
                        style: textTitle1(kNormalTextColor)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              trip.Trip_Time_Diff.isNotEmpty
                  ? RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: lang.startAt,
                              style: textTitle(kPrimaryColor)),
                          TextSpan(
                              text: '${trip.Trip_Time_Diff}',
                              style: textTitle1(kNormalTextColor)),
                        ],
                      ),
                    )
                  : Container(),
              trip.Trip_Time_Diff.isNotEmpty
                  ? const SizedBox(height: 10)
                  : Container(),

              //payment date
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: lang.paymentDate,
                        style: textTitle(kPrimaryColor)),
                    TextSpan(
                        text: DateFormat.yMEd(
                                ServiceCollector.getInstance().currentLanguage)
                            .format(DateTime.parse(trip.paymentDate)),
                        style: textTitle1(kNormalTextColor)),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              //Start At
              if (trip.tripExpirationTime.isNotEmpty)
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: lang.startAt,
                              style: textTitle(kPrimaryColor)),
                          TextSpan(
                              text: trip.getResponseTimeForUserDisplay,
                              style: textTitle1(kNormalTextColor)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),

//Commission
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: lang.commission, style: textTitle(kPrimaryColor)),
                    TextSpan(
                        text: '${trip.commission} ${lang.jd}',
                        style: textTitle1(kNormalTextColor)),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // trip Passengers

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: lang.numberOfPassengers,
                        style: textTitle(kPrimaryColor)),
                    TextSpan(
                        text: trip.numberOfPassenger,
                        style: textTitle1(kNormalTextColor)),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // trip days

              if (!(trip.numberOfDays == '' || trip.numberOfDays == '0'))
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: lang.numberOfDays,
                              style: textTitle(kPrimaryColor)),
                          TextSpan(
                              text: trip.numberOfDays,
                              style: textTitle1(kNormalTextColor)),
                        ],
                      ),
                    ),
                  ],
                ),
            ]),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => onPressed(trip.id),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Center(
                  child: Text(
                lang.showDetails,
                style: textTitle(Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
