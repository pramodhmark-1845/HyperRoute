import 'package:firebase_auth/firebase_auth.dart';
import 'package:hike_latest/pages/otp.dart';
import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  static String verification_id="";
  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    countryController.text = '+91';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: height*0.6),
            Container(
              margin: EdgeInsets.fromLTRB(width*0.045, 0, 0, width*0.02),
              alignment: Alignment.centerLeft,
              child: Text(
                'LOGIN TO HYPER-ROUTE!',
                style: TextStyle(
                  fontSize: width*0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(width*0.045, 0, width*0.045, width*0.02),
              width: width,
              height: height*0.065,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width*0.02,
                  ),
                  SizedBox(
                    width: width*0.1,
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
                    style: TextStyle(fontSize: width*0.08, color: Colors.grey),
                  ),
                  SizedBox(
                    width: width*0.04,
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
            SizedBox(height: height*0.012),
// get otp button
            InkWell(
              onTap: () async {
                int l = phone_number.text.length;
                String phone = phone_number.text.toString();
               /* for (int i = 0; i < l; i++) {
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
                if (l != 10) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Invalid Entry'),
                            content:
                                const Text('Please Enter Valid Phone Number'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                } else { */
                  // Loading Widget
                  showDialog(context: context,
                      barrierDismissible: false,
                      builder:(context){
                      return Center(child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xF73A2DCD)),
                      ) );
                      });
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: countryController.text.toString()+phone,
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {
                      if (e.code == 'invalid-phone-number') {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Invalid Entry'),
                              content:
                              const Text('Please Enter Valid Phone Number'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                      }
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      login_page.verification_id=verificationId;
                      Navigator.of(context).pop();
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => otp(phone: countryController.text.toString()+phone)));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                //}
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
                  'GET OTP',
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
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              child: Text(
                "By clicking, I accept the Terms & Conditions and Privacy Policy",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
