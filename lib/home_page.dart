import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvento/utils/Event.dart';
import 'package:uvento/utils/calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Calendar objects for days row
  Calendar sue10 = Calendar(10, 'Sue');
  Calendar mon11 = Calendar(11, 'Mon');
  Calendar tue12 = Calendar(12, 'Tue');
  Calendar wed13 = Calendar(13, 'Wed');
  Calendar thu14 = Calendar(14, 'Thu');
  Calendar fri15 = Calendar(15, 'Fri');
  Map<Calendar, bool> selected;

  // Events available
  Event event1 = Event('Sports Meet in Galaxy Field', 'Jan 12, 2019', 'Greenfields, Sector 42, Faridabad', 'assets/sport.png');
  Event event2 = Event('Art & Meet in Street Plaza', 'Jan 12, 2019', 'Galaxyfields, Sector 22, Faridabad', 'assets/art.png');
  Event event3 = Event('Youth Music in Galleria', 'Jan 12, 2019', 'Greenfields, Sector 42, Faridabad', 'assets/music.png');

  @override
  void initState() {
    setState(() {
      selected = {
        sue10: false,
        mon11: false,
        tue12: true,
        wed13: false,
        thu14: false,
        fri15: false
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF102733),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // App Bar
              Padding(
                padding: EdgeInsets.fromLTRB(25, 35, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today, color: Color(0xFFFAE072), size: 30,),
                        SizedBox(width: 6),
                        Text('UVE', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),),
                        SizedBox(width: 7),
                        Text('NTO', style: TextStyle(color: Color(0xFFFAE072), fontSize: 25, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.notifications, color: Colors.white, size: 30,),
                        SizedBox(width: 20),
                        Icon(Icons.crop_free, color: Colors.white, size: 30,)
                      ],
                    )
                  ],
                ),
              ),
              // Welcome Text
              Padding(
                padding: EdgeInsets.fromLTRB(25, 35, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Hello, Rúben !', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                        SizedBox(height: 15,),
                        Text('What’s happening nearby', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFFAE072),
                      radius: 32,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    )
                  ],
                ),
              ),
              // Days Section
              Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: __getDaysRow()
              ),
              // Events section
              Padding(
                padding: EdgeInsets.fromLTRB(25, 35, 30, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('All Events', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(height: 35,),
                    Container(
                      height: 100,
                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          __getEventWidget(Icons.music_note, 'Concert'),
                          SizedBox(width: 30),
                          __getEventWidget(Icons.school, 'Education'),
                          SizedBox(width: 30),
                          __getEventWidget(Icons.assignment_ind, 'Work'),
                          SizedBox(width: 30),
                          __getEventWidget(Icons.tv, 'Cinema'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 35, 30, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Popular Events', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(height: 35,),
                    Column(
                      children: <Widget>[
                        __getPopularEvents(event1),
                        SizedBox(height: 20,),
                        __getPopularEvents(event2),
                        SizedBox(height: 20,),
                        __getPopularEvents(event3),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget __getDays(Calendar cal, bool selected) {
    Widget col = GestureDetector(
      key: Key(cal.getDay.toString()),
      onTap: () {
        for (Calendar c in this.selected.keys) {
          if (this.selected[c] == true) {
            this.selected[c] = false;
          }
        }
        setState(() {
          this.selected[cal] = true;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(cal.getDay.toString(), style: TextStyle(color: selected ? Colors.black : Color(0xFFCCCCCC), fontSize: 20, fontWeight: FontWeight.w400)),
          SizedBox(height: 15,),
          Text(cal.getDayOfWeek, style: TextStyle(color: selected ? Colors.black : Color(0xFFD8D9DB), fontSize: 18, fontWeight: FontWeight.w600))
        ],
      )
    );

    if (selected) {
      return Container(
        height: 90,
        width: 60,
        decoration: BoxDecoration(
            color: Color(0xFFFCCD00),
            borderRadius: BorderRadius.circular(10)
        ),
        child: col,
      );
    }

    return col;
  }

  Widget __getEventWidget(IconData icon, String text) {
    return Container(
      width: 129.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: Colors.white,),
          SizedBox(height: 15,),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500))
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFF29404E),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget __getDaysRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        __getDays(sue10, selected[sue10]),
        SizedBox(width: 24),
        __getDays(mon11, selected[mon11]),
        SizedBox(width: 24),
        __getDays(tue12, selected[tue12]),
        SizedBox(width: 24),
        __getDays(wed13, selected[wed13]),
        SizedBox(width: 24),
        __getDays(thu14, selected[thu14]),
        SizedBox(width: 24),
        __getDays(fri15, selected[fri15]),
      ],
    );
  }

  Widget __getPopularEvents(Event event) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(event.name, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                SizedBox(height: 15,),
                Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today, color: Colors.white, size: 16,),
                    SizedBox(width: 10,),
                    Text(event.date, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.white, size: 16,),
                    SizedBox(width: 10,),
                    Text(event.location, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),)
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 110,
            width: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
              child: Image.asset(event.imagePath, fit: BoxFit.fill,),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFF29404E),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
