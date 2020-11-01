import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brexit Countdown',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Brexit Countdown"),
            ),
            body: MyBody()));
  }
}

class MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 20, 66, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/brexit_banner.png'),
          Container(
            padding: EdgeInsets.all(20),
          ),
          Countdown(),
        ],
      ),
    );
  }
}

class Countdown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _myCountdown();
  }
}

enum Selection {
  seconds,
  minutes,
  hours,
  days,
  months,
}


class _myCountdown extends State<Countdown> {

  String time_left = "";
  Selection unit_selected = Selection.seconds;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!mounted) return;
      update();
    });
  }

  void update(){
    setState(() {
      var now = new DateTime.now();
      var brexitDate = new DateTime.utc(2021, 1, 1);
      time_left = formatDate(now, brexitDate);
    });
  }
  
  String formatDate (DateTime now, DateTime brexitDate){
    switch(this.unit_selected){
      case Selection.seconds:
        return brexitDate.difference(now).inSeconds.toString() + " seconds left";
        break;
      case Selection.minutes:
        return (brexitDate.difference(now).inSeconds / 60).toStringAsFixed(0) + " minutes left";
        break;
      case Selection.hours:
        return (brexitDate.difference(now).inSeconds / 60 / 60).toStringAsFixed(0) + " hours left";
        break;
      case Selection.days:
        return (brexitDate.difference(now).inDays).toStringAsFixed(0) + " days left";
        break;
      case Selection.months:
        return (brexitDate.difference(now).inDays / 30).toStringAsFixed(0) + " months left";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(time_left.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 30
            ),
          ),
          Container(height: 60,),
          buttons()
        ],
      ),
    );
  }

  void setUnitSelectedAndUpdate(Selection value){
    this.unit_selected = value;
    this.update();
  }

  Widget buttons(){
    return Row(
      children: [
        Divider(
          height: 20,
          color: Colors.grey,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                child: Text("Months"),
                onPressed: (){setUnitSelectedAndUpdate(Selection.months);},
              ),
              RaisedButton(
                child: Text("Days"),
                onPressed: (){setUnitSelectedAndUpdate(Selection.days);},
              ),
              RaisedButton(
                child: Text("Hours"),
                onPressed: (){setUnitSelectedAndUpdate(Selection.hours);},
              ),
              RaisedButton(
                child: Text("Seconds"),
                onPressed: (){setUnitSelectedAndUpdate(Selection.seconds);},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
