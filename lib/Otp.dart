import 'package:Masth_GURU/inReviewPage.dart';
import 'package:Masth_GURU/newReview.dart';
import 'package:Masth_GURU/redirect.dart';
import 'package:Masth_GURU/teacher.dart';
import 'package:Masth_GURU/therapist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  String verificationId;
  int? resendToken;
  final String phone;
  Otp(
      {Key? key,
      required this.verificationId,
      required this.resendToken,
      required this.phone})
      : super(key: key);
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String smsCode = "";
  bool visible = false;
  myFunc() async {
    print("Started");
    if (super.mounted) {
      setState(() {
        visible = false;
      });
    }
    await Future.delayed(Duration(seconds: 30), () {
      print("Completing");
      if (super.mounted) {
        setState(() {
          visible = true;
        });
      }
    });
  }

  _OtpState() {
    myFunc();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 249, 239, 238),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 227, 207, 201),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/masti.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            //generate the credentials by verifying the otp entered by user
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: widget.verificationId,
                                    smsCode: this.smsCode);
                            //login using the credentials
                            final User? user = (await FirebaseAuth.instance
                                    .signInWithCredential(credential))
                                .user;
                            var dataBase = FirebaseFirestore.instance
                                .collection('Teachers');
                            var query = await dataBase.doc(user!.uid).get();
                            var data = query.data();
                            if (data != null && data["isTherapist"] != null) {
                              if (data["isTherapist"] == true) {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TherapistPage()));
                              } else {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Teacher()));
                              }
                            } else {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewReview()));
                            }
                          } catch (e) {
                            print('Failed to sign in: ' + e.toString());
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(250, 164, 112, 90)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 227, 207, 201),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              ElevatedButton(
                onPressed: !visible
                    ? null
                    : () {
                        FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '+91' + widget.phone,
                          verificationCompleted:
                              (PhoneAuthCredential phoneAuthCredential) async {
                            print('The provided phone number is valid.');
                            // print(test);
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            if (e.code == 'invalid-phone-number') {
                              print('The provided phone number is not valid.');
                            }
                            print('exception occurred: ' + e.toString());
                            // Handle other errors
                          },
                          codeSent: (String verificationId,
                              int? forceResendingToken) {
                            setState(() {
                              widget.verificationId = verificationId;
                              widget.resendToken = forceResendingToken;
                            });
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            setState(() {
                              widget.verificationId = verificationId;
                            });
                          },
                          forceResendingToken: widget.resendToken,
                        );
                        myFunc();
                      },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(250, 164, 112, 90)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 227, 207, 201),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Resend New Code",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.5,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            this.smsCode += value;
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 177, 152, 145),
                ),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
