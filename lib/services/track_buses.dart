import 'package:flutter/material.dart';

class trans {
  String? BusId;
  String? start;
  String? end;
  String? start_time;
  String? end_time;
  String ? TransId;
  String ? Status;
  String ? Booking_date;
  String ? Booking_time;
  String ? price;
  trans({this.BusId, this.start, this.end, this.start_time, this.end_time,this.TransId,this.Status,this.Booking_date,this.Booking_time,this.price});
}

class trans_card extends StatefulWidget {
  trans s;
  trans_card({Key? key, required this.s}) : super(key: key);

  @override
  State<trans_card> createState() => _trans_cardState();
}

class _trans_cardState extends State<trans_card> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20, 10,0,10),
                  child: Text(
                    "Order ID - " + widget.s.TransId.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
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
                          widget.s.start.toString(),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.s.start_time.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("1 hr")),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}