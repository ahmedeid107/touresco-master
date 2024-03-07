import 'dart:ui';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/view_models/take_role_view_model.dart';

DateTime get _now => DateTime.now();

class TableCalendarScreen extends StatelessWidget {
  TableCalendarScreen({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  final String title;
  final int type;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Consumer<TakeRoleViewModel>(builder: (context, vm, child) {
        return vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    flex: 3,
                    child: MonthView(
                      controller: vm.c,
                      headerStyle: const HeaderStyle(
                          headerTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                      // to provide custom UI for month cells.
                      cellBuilder: (date, events, isToday, isInMonth) {
                        // Return your widget to display as month cell.
                        var contains = false;
                        var color = Colors.white;
                        events.forEach((element) {
                          if (element.date == date) {
                            contains = true;
                            color = element.color;
                          }
                        });
                        return Center(
                          child: Container(
                            height: 38,
                            width: 38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                  ),
                                ],
                                color: !isInMonth
                                    ? Colors.white
                                    : contains
                                        ? color
                                        : Colors.white,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    width: .5,
                                    color: Colors.grey[400]!)),
                            child: Text(
                              "${date.day}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: !isInMonth
                                    ? Colors.grey
                                    : !contains
                                        ? Colors.black
                                        : Colors.white,
                                fontWeight: !isInMonth
                                    ? FontWeight.normal
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                      minMonth: DateTime(1990),
                      maxMonth: DateTime(2050),
                      initialMonth: _now,
                      showBorder: false,
                      weekDayBuilder: (day) {
                        var list = [
                          'Sat',
                          'Fri',
                          'Thu',
                          'Wed',
                          'Tue',
                          'Mon',
                          'Sun'
                        ];
                        return Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 6),
                          child: Text(
                            list[day],
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: kPrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      cellAspectRatio: 1,

                      onPageChange: (date, pageIndex) =>
                          print("$date, $pageIndex"),
                      onCellTap: (events, date) {
                        print("OBJECT ASS ${events[0]}");
                        if (events.length == 1) {
                          var list = events[0].description.split(",");

                          var id = list[2].toString();
                          Navigator.of(context)
                              .pushNamed('/trip_details_screen', arguments: {
                            'id': id,
                            'path': "",
                            "type": '',
                          }).then((value) {});
                        } else if (events.length == 2) {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 8, ),
                                          child: Text(lang.flightASD,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: kPrimaryColor)),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                          height: 120,
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: (){
                                                  var list = events[index].description.split(",");

                                                  var id = list[2].toString();

                                                  Navigator.of(context)
                                                      .pushNamed('/trip_details_screen', arguments: {
                                                    'id': id,
                                                    'path': "",
                                                    "type": '',
                                                  }).then((value) {});
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(16),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${lang.flightNo} ${events[index].description.split(",")[2]}",
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Text("|"),
                                                      SizedBox(width: 5,),
                                                      Text(
                                                        DateFormat.yMd().format(events[index].date),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: kPrimaryColor
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                      startDay: WeekDays.sunday,
                      onEventTap: (event, date) {},
                      onDateLongPress: (date) => print(date),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: vm.list[type - 1]
                        .map((e) => Container(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: e.color,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5,
                                          )
                                        ]),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    e.title,
                                    style:
                                        const TextStyle(fontSize: 16, shadows: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                      )
                                    ]),
                                  )
                                ],
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
      }),
    );
  }
}

List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: _now,
    event: Event(title: "Joe's Birthday", date: DateTime.now()),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  // CalendarEventData(
  //   date: _now.add(Duration(days: 1)),
  //   startTime: DateTime(_now.year, _now.month, _now.day, 18),
  //   endTime: DateTime(_now.year, _now.month, _now.day, 19),
  //   event: Event(title: "Wedding anniversary"),
  //   title: "Wedding anniversary",
  //   description: "Attend uncle's wedding anniversary.",
  // ),
  // CalendarEventData(
  //   date: _now,
  //   startTime: DateTime(_now.year, _now.month, _now.day, 14),
  //   endTime: DateTime(_now.year, _now.month, _now.day, 17),
  //   event: Event(title: "Football Tournament"),
  //   title: "Football Tournament",
  //   description: "Go to football tournament.",
  // ),
  // CalendarEventData(
  //   date: _now.add(Duration(days: 3)),
  //   startTime: DateTime(_now.add(Duration(days: 3)).year,
  //       _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
  //   endTime: DateTime(_now.add(Duration(days: 3)).year,
  //       _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
  //   event: Event(title: "Sprint Meeting."),
  //   title: "Sprint Meeting.",
  //   description: "Last day of project submission for last year.",
  // ),
  // CalendarEventData(
  //   date: _now.subtract(Duration(days: 2)),
  //   startTime: DateTime(
  //       _now.subtract(Duration(days: 2)).year,
  //       _now.subtract(Duration(days: 2)).month,
  //       _now.subtract(Duration(days: 2)).day,
  //       14),
  //   endTime: DateTime(
  //       _now.subtract(Duration(days: 2)).year,
  //       _now.subtract(Duration(days: 2)).month,
  //       _now.subtract(Duration(days: 2)).day,
  //       16),
  //   event: Event(title: "Team Meeting"),
  //   title: "Team Meeting",
  //   description: "Team Meeting",
  // ),
  // CalendarEventData(
  //   date: _now.subtract(Duration(days: 2)),
  //   startTime: DateTime(
  //       _now.subtract(Duration(days: 2)).year,
  //       _now.subtract(Duration(days: 2)).month,
  //       _now.subtract(Duration(days: 2)).day,
  //       10),
  //   endTime: DateTime(
  //       _now.subtract(Duration(days: 2)).year,
  //       _now.subtract(Duration(days: 2)).month,
  //       _now.subtract(Duration(days: 2)).day,
  //       12),
  //   event: Event(title: "Chemistry Viva"),
  //   title: "Chemistry Viva",
  //   description: "Today is Joe's birthday.",
  // ),
];

class innerModel {
  Color color;
  String title;

  innerModel(this.color, this.title);
}
