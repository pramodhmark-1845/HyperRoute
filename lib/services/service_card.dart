import 'dart:developer';
import 'dart:ffi';

import 'package:hike_latest/pages/buses_page.dart';
import 'package:hike_latest/pages/order_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hike_latest/services/Transaction_process.dart';
import 'package:hike_latest/services/conversion_func.dart';
import 'package:hike_latest/services/get_bus_timings.dart';

// class to store bus details
List<service> s_buses = [];
class service {
  String? BusId;
  String? start;
  String? end;
  String? start_time;
  String? end_time;
  int? time_diff;
  int ? slot;
  service({this.BusId, this.start, this.end, this.start_time, this.end_time,this.time_diff,this.slot});
}
// ignore: non_constant_identifier_names
// Get details of buses available
Future get_bus_data(String start, String end) async {
  buses_start.clear();
  buses_end.clear();
  await getbuses(start, end);
  int l=buses_start.length;
  s_buses.clear();
  String temp1="";
  String temp2="";
  for (int i = 0; i < l; i++) {
    if(buses_start[i]['Minute']<10)
      temp1="0"+buses_start[i]['Minute'].toString();
    else
      temp1=buses_end[i]['Minute'].toString();

    if(buses_end[i]['Minute']<10)
      temp2="0"+buses_end[i]['Minute'].toString();
    else
      temp2=buses_end[i]['Minute'].toString();

    s_buses.add(service(
        BusId: buses_start[i]['BusId'],
        start: start,
        end: end,
        start_time: (buses_start[i]['Hour'].toString()+":"+temp1),
        end_time: buses_end[i]['Hour'].toString()+":"+temp2,
        time_diff: buses_end[i]['TimeValue']-buses_start[i]['TimeValue'],
        slot: buses_start[i]['Slot'],
    ));
  }
  return;
}

// class to store box information
class box{
  int ? size;
  int ? value;
  box({this.value,this.size});
}
// fetch box informtion
List<box>sample = [box(size: 10,value: 1),box(size: 20,value: 0),box(size: 30,value: 1),box(size: 40,value: 0),box(size: 50,value: 1)];
// widget of box display
class box_details extends StatefulWidget {
  box b;
  service s;
  box_details({Key? key,required this.b,required this.s
  }) : super(key: key);
  Color ? c ;
  @override
  State<box_details> createState() => _box_detailsState();
}

class _box_detailsState extends State<box_details> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if(widget.b.value==1)
      {
        widget.c=Colors.green;
      }
    else
      {
        widget.c=Colors.red;
      }
    return  Container(
      width: ((width*0.96)/5)*0.8,
      margin: EdgeInsets.symmetric(horizontal: ((width*0.96)/5)*0.1, vertical:height*0.01),
      child: ElevatedButton(
        onPressed: () async {
          if(widget.b.value==1)
            {
              TransDetails.slot= widget.s.slot;
              TransDetails.lockerbox= widget.b.size;
              TransDetails.busid=widget.s.BusId;
              //Loading widget
              showDialog(context: context,
                  barrierDismissible: false,
                  builder:(context){
                    return Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xF73A2DCD)),
                    ) );
                  });
              //await createTransaction();
              //await createParcel();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => order_summary(s: widget.s)));
            }
        },
        child: Text(
          widget.b.size.toString(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: width*0.035,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 1, color: widget.c!)),
          ),
        ),
      ),
    );
  }
}

// bus information card
class bus_card extends StatefulWidget {
  service s;
  bus_card({Key? key, required this.s}) : super(key: key);

  @override
  State<bus_card> createState() => _bus_cardState();
}

class _bus_cardState extends State<bus_card> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: width*0.02, vertical: height*0.9*0.01),
      child: Column(
        children: [
          Container(
            //width: width,
            //alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xF73A2DCD)),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            margin: EdgeInsets.symmetric(vertical: height*0.9*0.02),
            padding: EdgeInsets.symmetric(horizontal: width*0.015,vertical: height*0.9*0.005),
            child: Text(
              "Bus No - " + widget.s.BusId.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: width*0.035,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: width*0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.s.start.toString(),
                    style: TextStyle(
                      fontSize: width*0.035,
                    ),
                  ),
                  Text(
                    widget.s.start_time.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: width*0.05,
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: width*0.06),
                  child: Text("---"+time_differece_func(widget.s.time_diff!)+"---",
                  style: TextStyle(
                    fontSize: width*0.04,
                  ),),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.s.end.toString(),
                    style: TextStyle(
                      fontSize: width*0.035,
                    ),
                  ),
                  Text(
                    widget.s.end_time.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: width*0.05,
                    ),
                  ),
                ],
              ),
            ],
          ),
// boxes data
          Row(
            children: sample!.map((e) => box_details(b: e, s: widget.s)).toList(),
          ),
        ],
      ),
    );
  }
}

/*Widget buscard(service s) {
  return Card(
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Bus No - " + s.BusId.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.start.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  s.start_time.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text('---1 hr 5 mins---')),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.s.end.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.s.end_time.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
// boxes data
        Row(
          children: [
            SizedBox(width: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '10',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.green)),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '20',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.red)),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)));
                },
                child: Text(
                  '30',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.green)),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '40',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.red)),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '50',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.red)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}*/
