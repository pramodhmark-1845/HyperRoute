import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:hike_latest/animations/startapp.dart';
import 'package:hike_latest/pages/Notifications.dart';
import 'package:hike_latest/pages/parcel_details.dart';
import 'package:hike_latest/services/get_bus_timings.dart';
import 'package:hike_latest/services/get_places.dart';
import 'package:hike_latest/services/get_profile.dart';

class home_page extends StatefulWidget {
  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final List _imgURL = [
    'https://cdn.openpr.com/V/a/Va03940650_g.jpg',
    'https://shipsy.io/wp-content/uploads/2021/05/Blog-99.jpg',
    'https://www.tsrtcparcel.in/TSCounter/IndexSite/img/slider-img03.jpg',
  ];
  TextEditingController countryController = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  String start = 'intial';
  String end = 'intial';
  Future getp() async
  {
    await get_profile().getprofile();
    return 0;
  }
  @override
  void initState() {
    // TODO: implement initState
    getp();
    getplaces();
    countryController.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    print('Here');
    return Scaffold(

        resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
//APP BAR
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Welcome to HIKE !",
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 17.0,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 2.0,
                      offset: const Offset(0.0, 1.5),
                    )
                  ],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              profile['Firstname'].toString(),
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
          ],
        ),
        backgroundColor: Color(0xF73A2DCD),
        toolbarHeight: 100,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => notf_page()));
              },
              icon: Icon(Icons.notifications)),
        ],
      ),
// BODY
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          SizedBox(height: 20),
// START LOCATIONS
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Container(
                child: Text(
                  "START LOCATION*",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: Places,
              popupItemDisabled: (String s) => s==end,
              dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              showSearchBox: true,
              onChanged: (String? selectedValue) {
                start = selectedValue!;
              },
            ),
          ),
// END LOCATION
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Container(
                child: Text(
                  "END LOCATION*",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: Places,
              popupItemDisabled: (String s) => s==start,
              dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              showSearchBox: true,
              onChanged: (String? selectedValue) {
                end = selectedValue!;
              },
            ),
          ),
//RECEIVER PHONE NUMBER
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Container(
                child: Text(
                  "RECEIVER PHONE NUMBER*",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 55,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 40,
                  child: TextField(
                    controller: countryController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Text(
                  "|",
                  style: TextStyle(fontSize: 33, color: Colors.grey),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  controller: phone_number,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone Number",
                  ),
                ))
              ],
            ),
          ),
//BOOK NOW BUTTON
          InkWell(
            onTap: () {
              int l = phone_number.text.length;
              String phone = phone_number.text.toString();
              for (int i = 0; i < l; i++) {
                if (phone[i] == '1' ||
                    phone[i] == '2' ||
                    phone[i] == '3' ||
                    phone[i] == '4' ||
                    phone[i] == '5' ||
                    phone[i] == '6' ||
                    phone[i] == '7' ||
                    phone[i] == '8' ||
                    phone[i] == '9' ||
                    phone[i] == '0') {
                  continue;
                } else {
                  l = 0;
                  break;
                }
              }
              if (start == 'intial' || end == 'intial' || l != 10) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Invalid Entry'),
                          content:
                              const Text('Please ( Fill / Enter Valid ) Details'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => parcel_page(
                              start: start,
                              end: end,
                              rec_phone: phone_number.toString(),
                            )));
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
                'BOOK NOW',
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
// Terms and Conditions
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Message/Terms and Conditions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
// IMAGE SLIDDER
          SizedBox(height: 20),
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
              ),
              items: _imgURL.map((imagepath) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DropShadowImage(
                      offset: Offset(0.0, 1.5),
                      scale: 10,
                      blurRadius: 10,
                      borderRadius: 10,
                      image: Image.network(imagepath),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
