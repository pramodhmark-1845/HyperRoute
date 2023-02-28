import 'package:hike_latest/services/service_card.dart';
import 'package:flutter/material.dart';

class order_summary extends StatefulWidget {
  service s;
  order_summary({Key? key, required this.s}) : super(key: key);

  @override
  State<order_summary> createState() => _order_summaryState();
}

class _order_summaryState extends State<order_summary> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ORDER SUMMARY',
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
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              '#OrderID-1234567',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Color(0xF73A2DCD),
                    child: Text(
                      "Bus No - " + widget.s.BusId.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: Colors.white,
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
                          child: Text(
                              '-----1 hr 5 mins-----\n(Estimated Delivery Time)')),
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
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      'BILL DETAILS',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green[300],
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                    child: Text('Box Selected - Size No 30 (25cm*25cm*25cm)'),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                    child: Text('Chrage per 1km (for 1kg parcel) - 1 Rs'),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                    child: Text('Parcel Estimated Average Weight - 5 Kg'),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                    child: Text('Distance - 10 kms'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                        child: Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                        child: Text('(1*5*10)    ='),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
                        child: Text(
                          '50 Rs',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'BEFORE CONFIRMATION OF ORDER\nPlease Track/check the current Location of Bus and Confirm that it is not crossed the Start Point',
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 50),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            alignment: Alignment.center,
            child: Text(
              '.....Track Bus.....',
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 3.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Disclaimer*',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Parcel details should be Genuine, Any mis-deatils and Parcels containing illegal products (Oils, Petrochemicals etc) leads to severe action at Random Checks\nRead Terms and Conditions, Policies for more details',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Material(
        color: const Color(0xF73A2DCD),
        child: InkWell(
          onTap: () {
           // Navigator.push(
                //context, MaterialPageRoute(builder: (context) => Payment()));
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'CONTINUE TO PAY',
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
        ),
      ),
    );
  }
}
