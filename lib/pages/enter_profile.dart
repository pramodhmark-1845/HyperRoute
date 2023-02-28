import 'package:firebase_auth/firebase_auth.dart';
import 'package:hike_latest/main.dart';
import 'package:hike_latest/pages/login_page.dart';
import 'package:hike_latest/pages/profile_loader.dart';
import 'package:flutter/material.dart';
import 'package:hike_latest/services/user.dart';

class enter_profile_page extends StatelessWidget {
  String phone;
  enter_profile_page({
    Key? key,
    required this.phone,
  }) : super(key: key);
  TextEditingController fn = TextEditingController();
  TextEditingController ln = TextEditingController();
  TextEditingController ml = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    'NEW TO HIKE !',
                    style: TextStyle(
                      color: Color(0xF73A2DCD),
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
// first name
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: fn,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                  ),
                ),
// last name
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: ln,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                  ),
                ),
//Email details
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: ml,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: ()  async {
                    if (ln.text.isEmpty == true ||
                        fn.text.isEmpty == true ||
                        ml.text.isEmpty == true) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Invalid Entry'),
                          content: const Text('Please fill all details'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final auth= FirebaseAuth.instance.currentUser !;
                      //Loading
                      showDialog(context: context,
                          barrierDismissible: false,
                          builder:(context){
                            return Center(child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xF73A2DCD)),
                            ) );
                          });
                      await DatabaseService(uid:auth.uid
                      ).CreateProfile(fn.text, ln.text, ml.text,phone);
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => main_page(index: 1)),
                              (route) => false);
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
                      'CREATE PROFILE',
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login with different Phone Number?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
