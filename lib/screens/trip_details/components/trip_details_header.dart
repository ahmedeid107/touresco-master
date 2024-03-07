import 'package:flutter/material.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripDetailsHeader extends StatelessWidget {
  const TripDetailsHeader({
    Key? key,
    required this.vm,
    required this.onPressed,
  }) : super(key: key);

  final TripDetailsViewModel vm;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      height: ScreenConfig.getYByPercentScreen(0.23),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(46, 70, 135, 225),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3))
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.grey[200],)),
              Spacer(),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(46, 70, 135, 225),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Image.asset('assets/images/icon_world.png'),
                  ),
                  SizedBox(
                    width: ScreenConfig.getXByPerecentScreen(0.02),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${lang!.tripNumber} ${vm.trip.id ?? vm.trip.id}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        vm.trip.tripCompanyName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenConfig.getFontDynamic(25),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
