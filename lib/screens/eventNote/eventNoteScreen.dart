import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/view_models/take_role_view_model.dart';

class EventNoteScreen extends StatefulWidget {
  EventNoteScreen({Key? key, required this.title , required this.type , }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final int type;

  @override
  _EventNoteScreenState createState() =>  _EventNoteScreenState();
}

class _EventNoteScreenState extends State<EventNoteScreen> {
  DateTime _currentDate = DateTime(2019, 2, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  DateTime _targetDateTime = DateTime(2019, 2, 3);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors. deepPurpleAccent,
        borderRadius:const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child:  const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
  List<List<innerModel>> list = [] ;



  final EventList<Event> _markedDateMap =  EventList<Event>(
    events: {
       DateTime(2019, 2, 10): [
         Event(
          date:  DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,

        ),
         Event(
          date:  DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
         Event(
          date:  DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  void initState() {


    _markedDateMap.add(
         DateTime(2019, 2, 25),
         Event(
          date:  DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
         DateTime(2019, 2, 10),
         Event(
          date:  DateTime(2019, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll( DateTime(2019, 2, 11), [
       Event(
        date:  DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
       Event(
        date:  DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
       Event(
        date:  DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    if(list.isEmpty){
      list.add([
        innerModel(Colors.yellow,
            lang.myPrivateTrips
        ),
        innerModel(Colors.green,
            lang.moreThanOneProgram
        ),
      ]);
      list.add([
        innerModel(Colors.blue,
            lang.transferFlights2
        ),
        innerModel(Colors.brown,
            lang.moreThanOneProgram
        ),

      ]);
      list.add([
        innerModel(Colors.red,
            lang.oneBatch
        ),
        innerModel(Colors.orange,
            lang.moreThanOneBatch
        ),
      ]);
    }

    /// Example with custom icon
     final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.transparent,
      //  onDayPressed: (date, events) {
      //   setState(() => _currentDate2 = date);
      //   events.forEach((event) => print(event.title));
      // },
      weekdayTextStyle: const TextStyle(
        color: kPrimaryColor,
      ),

      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,

      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      //firstDayOfWeek: 4,
      // markedDateIconBorderColor: Colors.brown,
      markedDatesMap: _markedDateMap,
      markedDateMoreCustomDecoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.red
          )
        ]
      ),
      height: 400.0,
      targetDateTime: _targetDateTime,
      customGridViewPhysics:const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(5)
      ),


      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: true,
      todayTextStyle: const TextStyle(
        color: Colors.blue,
      ),


      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: const TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
       },
    );

    return  Consumer<TakeRoleViewModel>(builder: (context, vm, child) {
      return Scaffold(
          appBar:  AppBar(
            title:  Text(widget.title),
          ),
          body:vm.isLoading? const Center(child: CircularProgressIndicator(),) :  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarouselNoHeader,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: list[widget.type].map((e) =>Container(
                    child: Row(

                      children: [
                        const SizedBox(width: 16,),
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
                              ]
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Text(e.title,
                          style: const TextStyle(
                              fontSize: 16,
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                )
                              ]
                          ),
                        )

                      ],
                    ),
                    margin: EdgeInsets.symmetric(vertical: 4),
                  ) ).toList(),
                )
              ],
            ),
          ));
    },

    );
  }

}


class innerModel{
  Color color ;
  String title;
  innerModel(this.color,this.title);
}