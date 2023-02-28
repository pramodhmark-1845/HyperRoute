import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hike_latest/pages/edit_profile.dart';
import 'package:hike_latest/services/get_places.dart';
import 'package:hike_latest/services/user.dart';

import '../services/get_profile.dart';

class profile_page extends StatefulWidget {
  profile_page({
    Key? key,
  }) : super(key: key);
  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "PROFILE",
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
// profile edit
          InkWell(
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => edit_page(
                          )));
              setState(() {
                //load data from server
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(50, 40, 80, 10),
                  child: Text(
                    profile['Firstname'].toString(),
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Color.fromARGB(255, 83, 83, 83),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            child: Text(profile['Phone'].toString()),
          ),
          SizedBox(height: 10),
// KYC Verification
          InkWell(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(50, 40, 120, 10),
                  child: Text(
                    'KYC verification',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Color.fromARGB(255, 83, 83, 83),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            child: Text('Verify your Aadhar'),
          ),
          Divider(
            color: Colors.grey,
          ),
// policies
          InkWell(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(50, 40, 190, 10),
                  child: Text(
                    'Policies',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Color.fromARGB(255, 83, 83, 83),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            child: Text('Terms and Conditons, Privacy Policy'),
          ),
          Divider(
            color: Colors.grey,
          ),
// previous orders
          InkWell(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(50, 40, 117, 10),
                  child: Text(
                    'Previous Orders',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Color.fromARGB(255, 83, 83, 83),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            child: Text('Check Previous Orders'),
          ),
          Divider(
            color: Colors.grey,
          ),
// logout
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Logout !'),
                  content: const Text('Do you want to Logout ?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Places.clear();
                        FirebaseAuth.instance.signOut();
                        Navigator.pop(context); 
                      },
                      child: const Text('LOGOUT'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('NO'),
                    ),
                  ],
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(50, 40, 190, 10),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Color.fromARGB(255, 83, 83, 83),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
