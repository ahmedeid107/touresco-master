import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/info_box_default.dart';
import 'package:touresco/models/trip_details_model.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/components/loading_progress_default.dart';
import 'package:touresco/screens/trip_details/components/trip_expenses.dart';
import 'package:touresco/screens/trip_details/components/trip_general_information.dart';
import 'package:touresco/screens/trip_details/components/trip_notes.dart';
import 'package:touresco/screens/trip_details/components/trip_passengers.dart';
import 'package:touresco/screens/trip_details/components/trip_program.dart';
import 'package:touresco/screens/trip_details/components/trip_status.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/utils/constants.dart';
import '../../../components/default_button.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/view_models/take_role_view_model.dart';
import '../../TableCalendarScreen.dart';
import '../../trip_trasfer/trip_transfer_screen.dart';

class TripDetailsBody extends StatefulWidget {
  TripDetailsBody({Key? key, required this.vm, required this.type})
      : super(key: key);

  final TripDetailsViewModel vm;
  final String? type;

  @override
  State<TripDetailsBody> createState() => _TripDetailsBodyState();
}

class _TripDetailsBodyState extends State<TripDetailsBody> {
  var scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (widget.type?.isNotEmpty == true) {
          scroll.animateTo(scroll.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }
      },
    );
    return SafeArea(
      child: SingleChildScrollView(
        controller: scroll,
        child: Column(
          children: [
            //  TripDetailsHeader(
            //     vm: widget.vm,
            //     onPressed: () {
            //        widget.vm.navigateBack(context);
            //     },
            //   ),
            if (
                getTripStatusType(widget.vm.trip.status, widget.vm.currentTripSource) != TripStatusData.waitingDriverToTakeTrip
                // !(DateTime.now().isAfter(DateTime.parse(widget.vm.trip.programs[0].date).add(const Duration(days: 1)))) &&
                //!(widget.vm.trip.programs[0].status == "2")
                )
              _buildTipsHandler(widget.vm, context), // build top print box

            const SizedBox(height: 20),
            TripGeneralInformation(
              vm: widget.vm,
              isType: widget.type == 'information',
            ),
            const SizedBox(height: 20),
            TripProgram(
              vm: widget.vm,
              isType: widget.type == 'program',
            ),
            const SizedBox(height: 20),
            TripExpenses(
              vm: widget.vm,
              isType: widget.type == 'expenses',
            ),
            const SizedBox(height: 20),
            TripPassengers(
              vm: widget.vm,
              isType: widget.type == 'passengers',
            ),
            const SizedBox(height: 20),
            TripNotes(
              vm: widget.vm,
              isType: widget.type == 'note',
            ),
            const SizedBox(height: 20),
            if (getTripStatusType(
                    widget.vm.trip.status, widget.vm.currentTripSource) ==
                TripStatusData.waitingDriverToTakeTrip)
              _buildDateConflictTips(widget.vm, context,lang),
            TripStatus(vm: widget.vm),

            widget.type =="Abed"?  Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: DefaultButton(
                buttonWidth: double.infinity,
                buttonText: lang .transferTrip,
                onpressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripTransferScreen(
                            source: widget.vm.trip.sourceId??"",
                            isOwner: widget.vm.trip.isOwner,
                            status: widget.vm.trip.status,
                            tripPaymentDate: widget.vm.trip.tripPaymentDate),
                      ));
                },
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }

  Column _buildTipsHandler(TripDetailsViewModel vm, BuildContext context) {
    String lang = ServiceCollector.getInstance().currentLanguage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vm.trip.motionRequestStatus != MotionRequestStatus.none)
          const SizedBox(height: 20),
        if (vm.trip.motionRequestStatus ==
            MotionRequestStatus.userNotRequestMotionRequestYet &&
            vm.currentTripSource != '3')
          InfoBoxDefault(
              icon: Icons.info,
              text: lang == 'en'
                  ? 'You have to request a trip from your office first'
                  : 'هل ترغب بارسال الحركة لمالك المركبة؟',
              buttonText: lang == 'en' ? 'Request' : 'ارسل الحركة',
              withAction: true,
              onPressed: () {
                vm.requestMovemntRequest(context);
              },
              color: kPrimaryColor),
        if (vm.trip.motionRequestStatus == MotionRequestStatus.userWaitingMotionRequestAnswer &&
            vm.currentTripSource != '3')
          InfoBoxDefault(
              icon: Icons.info,
              text: lang == 'en'
                  ? 'Pending until your office accept request'
                  : 'طلب الحركة معلق بانتظار موافقة مكتبك الخاص',
              buttonText: lang == 'en' ? 'Request' : 'طلب حركة',
              withAction: false,
              color: Colors.grey),
        if (vm.trip.motionRequestStatus ==
            MotionRequestStatus.driverIsNotAccpetedYetByOffice &&
            vm.currentTripSource != '3')
          InfoBoxDefault(
              icon: Icons.info,
              text: lang == 'en'
                  ? 'Waiting office to accept you as a driver'
                  : 'بانتظار موافقة المكتب مالك المركبة',
              buttonText: lang == 'en' ? 'Request' : 'طلب حركة',
              withAction: false,
              color: Colors.grey),
        if (vm.trip.motionRequestStatus ==
            MotionRequestStatus.driverIsBlockedFromOffice &&
            vm.currentTripSource != '3')
          InfoBoxDefault(
              icon: Icons.info,
              text: lang == 'en'
                  ? 'You are blocked, please contact with your office for more details'
                  : 'قام المكتب مالك المركبة بحظرك، يرجى مراجعته',
              buttonText: lang == 'en' ? 'Request' : 'طلب حركة',
              withAction: false,
              color: Colors.red),
        if (vm.trip.motionRequestStatus ==
            MotionRequestStatus.userMotionRequestRefused &&
            vm.currentTripSource != '3')
          InfoBoxDefault(
              icon: Icons.info,
              text: lang == 'en'
                  ? 'The Office refused your movent request'
                  : 'المكتب رفض طلب الحركة الخاص بك',
              buttonText: lang == 'en' ? 'Request' : 'طلب حركة',
              withAction: false,
              color: Colors.red),
        if (vm.trip.motionRequestStatus ==
            MotionRequestStatus.userMotionRequestApproved &&
            vm.currentTripSource != '3')
          InfoBoxDefault(
              icon: Icons.star,
              text: lang == 'en'
                  ? 'The motion request has been approved,press the button to view'
                  : 'المكتب وافق على طلب الحركة اضغط على الزر للعرض',
              buttonText: lang == 'en' ? 'view' : 'طباعة',
              withAction: true,
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return LoadingProgressDefault(
                        processText: lang == 'en'
                            ? 'Preparing the file ...'
                            : 'جاري تحضير الملف...',
                        action: vm.showMovementRequest(context),
                      );
                    });
              },
              color: kPrimaryColor),
        if (vm.trip.motionRequestStatus ==
            MotionRequestStatus.userNotRegisterInOffice &&
            vm.currentTripSource != '3')
          InfoBoxDefault(
              icon: Icons.info,
              text: lang == 'en'
                  ? 'You are not register in office, No motion request available for you'
                  : 'انت غير مسجل في مكتب ، لايوجد طلب حركة متاح لك',
              buttonText: lang == 'en' ? 'Request' : 'طلب حركة',
              withAction: false,
              color: Colors.grey),
      ],
    );
  }

  Widget _buildDateConflictTips(TripDetailsViewModel vm, BuildContext context , lango) {
    String lang = ServiceCollector.getInstance().currentLanguage;
    return (vm.trip.tripDateConflictStatus == '0')
        ? const SizedBox()
        : InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  var id =
                    Provider.of<AuthProvider>(
                        context,
                        listen: false)
                        .user
                        .id;
                  Provider.of<TakeRoleViewModel>(
                      context,
                      listen: false)
                      .syncEvents(1, id, lango);
                  return TableCalendarScreen(
                    title:
                        ServiceCollector.getInstance().currentLanguage == 'en'
                            ? 'My Private Trips'
                            : 'رحلاتي الخاصة',
                    type: 1,
                  );
                },
              ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoBoxDefault(
                    icon: Icons.info,
                    text: lang == 'en'
                        ? 'You have trip in the same day accept or not'
                        : 'لديك رحلة بهذا اليوم وافق او ارفض',
                    buttonText: lang == 'en' ? 'Request' : 'طلب حركة',
                    withAction: false,
                    color: Colors.red),
                const SizedBox(height: 8),
              ],
            ),
          );
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
