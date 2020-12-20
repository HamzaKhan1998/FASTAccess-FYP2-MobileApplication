import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_access/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fast_access/pages/CalenderClient.dart';
import 'package:fast_access/pages/HomePage.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class CalenderPage extends StatefulWidget {
  final Userr gCurrentUser;

  CalenderPage({this.gCurrentUser});


  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    print(_selectedDay);

    _events = {
      _selectedDay.subtract(Duration(days: 4)): ['Event A5'],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6'],

    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }



  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.indigo, //---------------------------------------------------------------------------------
        todayColor: Colors.pink,
        markersColor: Colors.blue,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      //onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)


  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.red,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text('Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
    //AddSubject();
    AddMeetings();
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),

    );
    //AddSubject();
  }
  
  AddMeetings() async
  {
    String s;
    DateTime dateTime = DateTime.now();
    QuerySnapshot querySnapshot = await RoomReference.doc("Meeting Room").collection("Meetings").get();
    querySnapshot.docs.forEach((element) {
      DateTime StartTimeofAppointment = element.data()["StartTimeofAppointment"].toDate();
      String convertedDateTime1 = "${StartTimeofAppointment.year.toString()}-${StartTimeofAppointment.month.toString().padLeft(2,'0')}-${StartTimeofAppointment.day.toString().padLeft(2,'0')} ${StartTimeofAppointment.hour.toString()}:${StartTimeofAppointment.minute.toString()}";
      //String convertedDateTime2 = "${EndTimeofAppointment.year.toString()}-${EndTimeofAppointment.month.toString().padLeft(2,'0')}-${EndTimeofAppointment.day.toString().padLeft(2,'0')} ${EndTimeofAppointment.hour.toString()}:${EndTimeofAppointment.minute.toString()}";
      //s = element.data()["StartTimeofAppointment"].toString();
      String username = element.data()["AppointmentMadeFrom"];
      convertedDateTime1 = convertedDateTime1  + " =>> " + username;
      _events[dateTime.add(Duration(days: 2))] = [convertedDateTime1];
    });
  }

  AddSubject(){
    int d1 = widget.gCurrentUser.day1;
    int d11 = widget.gCurrentUser.day11;
    int d2 = widget.gCurrentUser.day2;
    int d22 = widget.gCurrentUser.day22;
    int d3 = widget.gCurrentUser.day3;
    int d33 = widget.gCurrentUser.day33;
    int d4 = widget.gCurrentUser.day4;
    int d44 = widget.gCurrentUser.day44;
    int d5 = widget.gCurrentUser.day5;
    int d55 = widget.gCurrentUser.day55;
    String p = widget.gCurrentUser.room1;
    String s = widget.gCurrentUser.subject1;
    String o = widget.gCurrentUser.timing1;
    s = s + " =>> " + p + " =>> " + o;
    // _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
    // _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
    //i=no of weeks

    DateTime dateTime = DateTime.now();
    int w = dateTime.weekday;
    int j=0; //jump to next week

    //print(_events);
    //_events[dateTime.add(Duration(days: 1))] = ["okkkk"];
    // print("Value:");
    // print(w-D);

    if(w-d1 == 0)
    {
      for(int i=0; i<8;i++)
      {
        _events[dateTime.add(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == 1)
    {
      j=1;
      for(int i=0; i<8;i++)
      {
        _events[dateTime.subtract(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == -1)
    {
      j=1;
      for(int i=0; i<8;i++)
      {
        _events[dateTime.add(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == 2)
    {
      j=2;
      for(int i=0; i<8;i++)
      {
        _events[dateTime.subtract(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == -2)
    {
      j=2;
      for(int i=0; i<8;i++)
      {
        _events[dateTime.add(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == 3)
    {
      j=3;
      for(int i=0; i<8;i++)
      {
        _events[dateTime.subtract(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == -3)
    {
      j=3;
      for(int i=0; i<8;i++)
      {
        _events[dateTime.add(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == 4)
    {
      j=4;
      for(int i=0; i<8;i++)
      {
        _events[dateTime.subtract(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == -4)
    {
      j=4;
      for(int i=0; i<8;i++)
      {
        _events[dateTime.add(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == 5)
    {
      for(int i=0; i<8;i++)
      {
        _events[dateTime.subtract(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == -5)
    {
      for(int i=0; i<8;i++)
      {
        _events[dateTime.add(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == 6)
    {
      for(int i=0; i<8;i++)
      {
        _events[dateTime.subtract(Duration(days: j))] = [s];
        j += 7;
      }
    }

    else if (w-d1 == -6)
    {
      for(int i=0; i<8;i++)
      {
        _events[dateTime.add(Duration(days: j))] = [s];
        j += 7;
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      //drawerScrimColor: Colors.green,
      appBar: AppBar(
        title: Text("Calender"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
          //AddSubject(),
        ],
      ),
    );
  }


}

/*Widget _buildTableCalendarWithBuilders() {
  return TableCalendar(
    locale: 'pl_PL',
    calendarController: _calendarController,
    events: _events,
    holidays: _holidays,
    initialCalendarFormat: CalendarFormat.month,
    formatAnimation: FormatAnimation.slide,
    startingDayOfWeek: StartingDayOfWeek.sunday,
    availableGestures: AvailableGestures.all,
    availableCalendarFormats: const {
      CalendarFormat.month: '',
      CalendarFormat.week: '',
    },
    calendarStyle: CalendarStyle(
      outsideDaysVisible: false,
      weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
      holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
    ),
    daysOfWeekStyle: DaysOfWeekStyle(
      weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
    ),
    headerStyle: HeaderStyle(
      centerHeaderTitle: true,
      formatButtonVisible: false,
    ),
    builders: CalendarBuilders(
      selectedDayBuilder: (context, date, _) {
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.yellow,
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          ),
        );
      },
      todayDayBuilder: (context, date, _) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.only(top: 5.0, left: 6.0),
          color: Colors.green,
          width: 100,
          height: 100,
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 16.0),
          ),
        );
      },
      markersBuilder: (context, date, events, holidays) {
        final children = <Widget>[];

        if (events.isNotEmpty) {
          children.add(
            Positioned(
              right: 1,
              bottom: 1,
              child: _buildEventsMarker(date, events),
            ),
          );
        }

        if (holidays.isNotEmpty) {
          children.add(
            Positioned(
              right: -2,
              top: -2,
              child: _buildHolidaysMarker(),
            ),
          );
        }

        return children;
      },
    ),
    // onDaySelected: (date, events) {
    //   _onDaySelected(date, events);
    //   _animationController.forward(from: 0.0);
    // },
    onVisibleDaysChanged: _onVisibleDaysChanged,
    onCalendarCreated: _onCalendarCreated,
  );
}*/