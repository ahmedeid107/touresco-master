import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:touresco/components/exbandable_item_default.dart';
import 'package:touresco/models/trip_details_model.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';

class TripExpenses extends StatefulWidget {
  TripExpenses({Key? key, required this.vm, required this.isType})
      : super(key: key);

  final TripDetailsViewModel vm;
  bool? isType;

  @override
  State<TripExpenses> createState() => _TripExpensesState();
}

class _TripExpensesState extends State<TripExpenses> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1), () {
      if (widget.isType == true) {
        widget.vm.isExpandableExpenses = true;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return ExpandableItemDefault(
      mainTitle: lang!.tripExpenses,
      isCurrentExpand: widget.vm.isExpandableExpenses,
      reverseExpandableList: () {
        widget.vm.isExpandableExpenses = !widget.vm.isExpandableExpenses;
      },
      expandableWidget: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _buildExpensesItem(
                widget.vm.trip.expenses[index], context, lang);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: widget.vm.trip.expenses.length),
    );
  }

  Column _buildExpensesItem(SingleExpensesData expenses, BuildContext context,
      AppLocalizations? lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('#${expenses.id}', style: textTitle(kPrimaryColor)),
            if (getTripStatusType(
                    widget.vm.trip.status, widget.vm.currentTripSource) !=
                TripStatusData.waitingDriverToTakeTrip)
              Text(
                getExpensesStatusAsMessageToUser(expenses.expensesStatus),
                style: textSubtitle(kNormalTextColor),
              ),
          ],
        ),
        const SizedBox(height: 12),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: lang!.name, style: textTitle(kPrimaryColor)),
          TextSpan(text: expenses.note, style: textTitle1(kTitleBlackTextColor))
        ])),
        const SizedBox(height: 12),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: lang.amount, style: textTitle(kPrimaryColor)),
          TextSpan(
              text: '${expenses.amount} ${lang.jd}',
              style: textTitle1(kTitleBlackTextColor))
        ])),
        const SizedBox(height: 12),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: lang.addedDate, style: textTitle(kPrimaryColor)),
          TextSpan(
              text: DateFormat.yMEd(
                          ServiceCollector.getInstance().currentLanguage)
                      .format(DateTime.parse(expenses.addedDate)) +
                  '  ' +
                  DateFormat.jm(ServiceCollector.getInstance().currentLanguage)
                      .format(DateTime.parse(expenses.addedDate)),
              style: textTitle1(kTitleBlackTextColor))
        ])),
        const SizedBox(height: 12),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(text: lang.paymentDate, style: textTitle(kPrimaryColor)),
            TextSpan(
                text: DateFormat.yMEd(
                        ServiceCollector.getInstance().currentLanguage)
                    .format(DateTime.parse(expenses.paymentDate)),
                style: textTitle1(kTitleBlackTextColor)),
          ],
        )),
        if (TripDetailsModel.getExpensesStatus(
                expenses.expensesStatus, widget.vm.currentTripSource) ==
            ExpensesStatusData.paymentIsCompleted) //Active and payment Complete
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: lang.completedAt,
                        style: textTitle(kPrimaryColor)),
                    TextSpan(
                        text: DateFormat.yMEd(
                                ServiceCollector.getInstance().currentLanguage)
                            .format(DateTime.parse(expenses.paymentDateDone)),
                        style: textTitle1(kTitleBlackTextColor))
                  ],
                ),
              ),
            ],
          ),
        if (getTripStatusType(
                widget.vm.trip.status, widget.vm.currentTripSource) !=
            TripStatusData.waitingDriverToTakeTrip)
          Column(
            children: [
              const SizedBox(height: 12),
              //Actions Handling
              //when expenses accepted between two parts
              if ((TripDetailsModel.getExpensesStatus(
                  expenses.expensesStatus, widget.vm.currentTripSource) ==
                  ExpensesStatusData
                      .activeAndAcceptedTwoPartsButPaymentNotCompleted) && !widget.vm.trip.isOwner)
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        widget.vm.paymentDoneForExpenses(context, expenses.id);
                      },
                      child: Text(lang.paymentCompleted,
                          style: textTitle(kPrimaryColor))),
                ),

//payment added by user and office not Accept it
              if ((TripDetailsModel.getExpensesStatus(expenses.expensesStatus,
                          widget.vm.currentTripSource) ==
                      ExpensesStatusData.waitingOfficeToAcceptExpenses) &&
                  !widget.vm.trip.isOwner)
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        widget.vm.cancelPendingExpenses(context, expenses.id);
                      },
                      child: Text(lang.canceltextButton,
                          style: textTitle(Colors.red))),
                ),
              if ((TripDetailsModel.getExpensesStatus(expenses.expensesStatus,
                          widget.vm.currentTripSource) ==
                      ExpensesStatusData.waitingOfficeToAcceptExpenses) &&
                  widget.vm.trip.isOwner)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          widget.vm
                              .agreeNewExpensesByDriver(context, expenses.id);
                        },
                        child: Text(lang.takeTrip,
                            style: textTitle(kPrimaryColor))),
                    TextButton(
                        onPressed: () {
                          widget.vm
                              .cancelNewExpensesByDriver(context, expenses.id);
                        },
                        child: Text(lang.cancel, style: textTitle(Colors.red))),
                  ],
                ),

//Waiting driver to accept or refuse payment
              if (TripDetailsModel.getExpensesStatus(expenses.expensesStatus,
                          widget.vm.currentTripSource) ==
                      ExpensesStatusData
                          .waitingDriverToAcceptExpensesThatComeFromOffice &&
                  !widget.vm.trip.isOwner)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          widget.vm
                              .agreeNewExpensesByDriver(context, expenses.id);
                        },
                        child: Text(lang.takeTrip,
                            style: textTitle(kPrimaryColor))),
                    TextButton(
                        onPressed: () {
                          widget.vm
                              .cancelNewExpensesByDriver(context, expenses.id);
                        },
                        child: Text(lang.cancel, style: textTitle(Colors.red))),
                  ],
                ),
              if (TripDetailsModel.getExpensesStatus(expenses.expensesStatus,
                          widget.vm.currentTripSource) ==
                      ExpensesStatusData
                          .waitingDriverToAcceptExpensesThatComeFromOffice &&
                  widget.vm.trip.isOwner)
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        widget.vm.cancelPendingExpenses(context, expenses.id);
                      },
                      child: Text(lang.canceltextButton,
                          style: textTitle(Colors.red))),
                ),
            ],
          ),
        const SizedBox(height: 4),
      ],
    );
  }

  String getExpensesStatusAsMessageToUser(String status) {
    String lang = ServiceCollector.getInstance().currentLanguage;
    if (status ==
        ExpensesStatusData.activeAndAcceptedTwoPartsButPaymentNotCompleted.index
            .toString()) {
      return lang == 'en' ? 'Payment Not Completed' : 'لم يتم التسديد';
    } else if (status ==
        ExpensesStatusData.waitingOfficeToAcceptExpenses.index.toString()) {
      return lang == 'en' ? 'Pending' : 'بانتظار الموافقة';
    } else if (status ==
        ExpensesStatusData.waitingDriverToAcceptExpensesThatComeFromOffice.index
            .toString()) {
      return lang == 'en' ? 'Pending' : 'بانتظار الموافقة';
    } else if (status == ExpensesStatusData.canceldByDriver.index.toString()) {
      return lang == 'en' ? 'Canceled expenses' : 'المصاريف مرفوضة';
    } else if (status == ExpensesStatusData.canceldByOffice.index.toString()) {
      return lang == 'en' ? 'Canceled flights' : 'المصاريف مرفوضة';
    } else if (status ==
        ExpensesStatusData.paymentIsCompleted.index.toString()) {
      return lang == 'en' ? 'Completed' : 'مكتملة';
    } else {
      return 'error';
    }
  }
}
