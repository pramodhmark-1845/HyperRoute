import 'package:hike_latest/pages/bus_timings.dart';
import 'package:flutter/material.dart';
import 'package:hike_latest/pages/buses_page.dart';
import 'package:hike_latest/services/service_card.dart';

class parcel_page extends StatefulWidget {
  String start;
  String end;
  String rec_phone;
  parcel_page(
      {Key? key,
      required this.start,
      required this.end,
      required this.rec_phone})
      : super(key: key);
  @override
  State<parcel_page> createState() => _parcel_pageState();
}

class _parcel_pageState extends State<parcel_page> {
  TextEditingController item = TextEditingController(text: '');
  TextEditingController cat = TextEditingController(text: '');
  TextEditingController est_weight = TextEditingController(text: '');
  TextEditingController est_val = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    print(cat);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PARCEL DETAILS',
          style: TextStyle(
              letterSpacing: 2.0,
              fontSize: 20.0,
              shadows: <Shadow>[
                Shadow(
                  blurRadius: 2.0,
                  offset: const Offset(0.0, 1.5),
                )
              ],
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xF73A2DCD),
        toolbarHeight: 100,
      ),
      body: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(25, 25, 25, 10),
              child: Text(
                'Please enter (*) details mandatorily',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )),
//item name
          Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
            child: TextField(
              controller: item,
              decoration: const InputDecoration(
                labelText: 'Product (or) Item Name* / Description (if any)',
              ),
            ),
          ),
//parcel categary
          Container(
            padding: const EdgeInsets.all(25),
            child: TextField(
              controller: cat,
              decoration: const InputDecoration(
                labelText: 'Parcel Category*',
              ),
            ),
          ),
//Estimated weight
          Container(
            padding: const EdgeInsets.all(25),
            child: TextField(
              controller: est_weight,
              decoration: const InputDecoration(
                labelText: 'Estimated Weight*',
              ),
            ),
          ),
//Estimated Value
          Container(
            padding: const EdgeInsets.all(25),
            child: TextField(
              controller: est_val,
              decoration: const InputDecoration(
                labelText: 'Estimated value*',
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (cat.text == '' ||
                  item.text == '' ||
                  est_weight.text == '' ||
                  est_val.text == '') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Invalid Entry'),
                          content: const Text('Please Enter Details'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              } else {
                showDialog(context: context,
                    barrierDismissible: false,
                    builder:(context){
                      return Center(child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xF73A2DCD)),
                      ) );
                    });
                await get_bus_data(widget.start, widget.end);
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            bus_times(start: widget.start,end: widget.end,)));
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xF73A2DCD),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(
                      0.0,
                      10.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  )
                ],
              ),
              child: Text(
                'PROCEED',
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 20.0,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 2.0,
                      offset: const Offset(0.0, 1.5),
                    )
                  ],
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
