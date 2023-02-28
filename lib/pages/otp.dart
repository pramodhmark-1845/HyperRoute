import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hike_latest/pages/enter_profile.dart';
import 'package:flutter/material.dart';
import 'package:hike_latest/pages/login_page.dart';

import '../main.dart';
import '../services/get_profile.dart';

class otp extends StatefulWidget {
  String phone;
  otp({Key? key, required this.phone}) : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  int flag=0;
  Future getprofile() async {
    final  a= FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(a.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        flag=1;
      }
    });
        return flag;
  }
  TextEditingController smscode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var code="";
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 400),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          iconSize: 25,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Enter 6-digit verification code send to Phone Number',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: TextField(
            onChanged: (value)
            {
              code=value;
            },
            maxLength: 6,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Resend OTP?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            try {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: login_page.verification_id,
                  smsCode: code);
              // Loader
              showDialog(context: context,
                  barrierDismissible: false,
                  builder:(context){
                    return Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xF73A2DCD)),
                    ) );
                  });
              // Sign the user in (or link) with the credential
              await auth.signInWithCredential(credential);
              await getprofile();
              Navigator.of(context).pop();
              if(flag==1)
                {
                  showDialog(context: context,
                      barrierDismissible: false,
                      builder:(context){
                        return Center(child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xF73A2DCD)),
                        ) );
                      });
                  await get_profile().getprofile();
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => main_page(index: 1)),
                          (route) => false);
                }
              else {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (context) =>
                            enter_profile_page(phone: widget.phone)));
              }
            }
            catch(e)
            {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Invalid OTP'),
                    content:
                    const Text('Please Enter Valid PIN or Generate New!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ));
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
              'VERIFY',
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
    ));
  }
}
