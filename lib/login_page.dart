import 'package:Masth_GURU/Otp.dart';
import 'package:Masth_GURU/google_page.dart';
import 'package:Masth_GURU/inReviewPage.dart';
import 'package:Masth_GURU/newReview.dart';
import 'package:Masth_GURU/redirect.dart';
import 'package:Masth_GURU/sign_up.dart';
import 'package:Masth_GURU/teacher.dart';
import 'package:Masth_GURU/therapist.dart';
import 'package:Masth_GURU/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Masth_GURU/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Masth_GURU/Email_Login.dart';
import 'package:Masth_GURU/Google_Login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = "";
  String name = "";
  String phone = "";
  bool changeButton = false;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    userEmail = googleUser.email;

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });

      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 249, 239, 238),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: GestureDetector(
              //       onTap: () => Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Teacher()),
              //       ),
              //       child: Text(
              //         "Skip",
              //         style: TextStyle(
              //             fontFamily: 'Century Gothic',
              //             fontSize: 17,
              //             color: Color.fromARGB(255, 164, 112, 90)),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20.0, //to insert space instead of doing padding
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 227, 207, 201),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/images/masti.png",
                ),
              ),
              const SizedBox(
                height: 20.0, //to insert space instead of doing padding
              ),
              Text(
                "MASTH Guru",
                style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 28,
                  color: Color.fromARGB(250, 164, 112, 90),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0, //to insert space instead of doing padding
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            labelStyle: TextStyle(
                                fontFamily: 'Century Gothic',
                                color: Color.fromARGB(250, 164, 112, 90)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefix: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '(+91)',
                                style: TextStyle(
                                    fontFamily: 'Century Gothic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 32,
                            )),
                        onChanged: (value) {
                          phone = value;
                        },
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '+91' + phone,
                              timeout: const Duration(seconds: 30),
                              verificationFailed: (FirebaseAuthException e) {
                                if (e.code == 'invalid-phone-number') {
                                  print(
                                      'The provided phone number is not valid.');
                                }
                                print('exception occurred: ' + e.toString());
                                // Handle other errors
                              },
                              verificationCompleted: (PhoneAuthCredential
                                  phoneAuthCredential) async {
                                print('The provided phone number is valid.');
                                // print(test);
                              },
                              codeSent: (String verificationId,
                                  int? forceResendingToken) {
                                print('verificationId: ' + verificationId);
                                print('forceResendingToken: ' +
                                    forceResendingToken.toString());
                                _verificationId = verificationId;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Otp(
                                            phone: phone,
                                            verificationId: _verificationId,
                                            resendToken: forceResendingToken,
                                          )),
                                );
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                print('codeAutoRetrievalTimeout: ' +
                                    verificationId);
                                _verificationId = verificationId;
                              },
                            );
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 231, 215, 215)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ))),
                          child: Padding(
                            padding: EdgeInsets.all(14),
                            child: Text(
                              "Send OTP",
                              style: TextStyle(
                                  fontFamily: 'Century Gothic',
                                  fontSize: 16,
                                  // color: Color.fromARGB(250, 164, 112, 90),
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20.0, //to insert space instead of doing padding
                      ),

                      OrDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              child: Image.asset("assets/icons/google.png"),
                            ),
                            onTap: () async {
                              await signInWithGoogle();
                              var user = auth.currentUser;
                              var dataBase = FirebaseFirestore.instance
                                  .collection('Teachers');
                              var query = await dataBase.doc(user!.uid).get();
                              var data = query.data() as Map<String, dynamic>?;
                              if (data != null && data["isTherapist"] != null) {
                                if (data["isTherapist"] == true) {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TherapistPage()));
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

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Google_page()),
                              // );
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            child: Container(
                              child: Image.asset("assets/icons/email.png"),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signin()),
                              );
                            },
                          ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          // InkWell(
                          //   child: Container(
                          //     child: Image.asset("assets/icons/instagram.png"),
                          //   ),
                          //   onTap: () {},
                          // ),
                          // Container(
                          //   child: Image.asset("assets/icons/facebook.png"),
                          // ),
                          // Container(
                          //   child: Image.asset("assets/icons/google.png"),
                          // )
                          // Container(
                          //   padding: EdgeInsets.all(5),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       width: 2,
                          //       color: Color.fromARGB(255, 241, 214, 212),
                          //     ),
                          //     shape: BoxShape.circle,
                          //   ),
                          //   child: Image.asset("assets/icons/google.png"),
                          // ),

                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(24),
                          //   child: ElevatedButton.icon(
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Color.fromARGB(255, 249, 239, 238),
                          //       onPrimary: Colors.black,
                          //       minimumSize: Size(100, 50),
                          //     ),
                          //     icon: FaIcon(
                          //       FontAwesomeIcons.google,
                          //       color: Colors.red,
                          //     ),
                          //     label: Text(
                          //       "Google",
                          //       style: TextStyle(fontFamily: 'Century Gothic'),
                          //     ),
                          //     onPressed: () {},
                          //   ),
                          // ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(24),
                          //   child: ElevatedButton.icon(
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Color.fromARGB(255, 249, 239, 238),
                          //       onPrimary: Colors.black,
                          //       minimumSize: Size(100, 50),
                          //     ),
                          //     icon: FaIcon(
                          //       FontAwesomeIcons.instagram,
                          //       color: Colors.pink,
                          //     ),
                          //     label: Text(
                          //       "Instagram",
                          //       style: TextStyle(fontFamily: 'Century Gothic'),
                          //     ),
                          //     onPressed: () {},
                          //   ),
                          // ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(24),
                          //   child: ElevatedButton.icon(
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Color.fromARGB(255, 249, 239, 238),
                          //       onPrimary: Colors.black,
                          //       minimumSize: Size(100, 50),
                          //     ),
                          //     icon: FaIcon(
                          //       FontAwesomeIcons.facebook,
                          //       color: Color.fromARGB(255, 16, 89, 150),
                          //     ),
                          //     label: Text(
                          //       "facebook",
                          //       style: TextStyle(fontFamily: 'Century Gothic'),
                          //     ),
                          //     onPressed: () {},
                          //   ),
                          // ),
                          // Container(
                          //   padding: EdgeInsets.all(20),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       width: 2,
                          //       color: Color.fromARGB(250, 164, 112, 90),
                          //     ),
                          //     shape: BoxShape.circle,
                          //   ),
                          //   child: Image.asset("assets/icons/instagram"),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(24),
                      //   child: ElevatedButton.icon(
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Color.fromARGB(255, 249, 239, 238),
                      //       onPrimary: Colors.black,
                      //       minimumSize: Size(200, 50),
                      //     ),
                      //     icon: FaIcon(
                      //       FontAwesomeIcons.google,
                      //       color: Colors.red,
                      //     ),
                      //     label: Text(
                      //       "Sign in with Google",
                      //       style: TextStyle(fontFamily: 'Century Gothic'),
                      //     ),
                      //     onPressed: () {},
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(24),
                      //   child: ElevatedButton.icon(
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Color.fromARGB(255, 249, 239, 238),
                      //       onPrimary: Colors.black,
                      //       minimumSize: Size(200, 50),
                      //     ),
                      //     icon: FaIcon(
                      //       FontAwesomeIcons.instagram,
                      //       color: Colors.pink,
                      //     ),
                      //     label: Text(
                      //       "Sign in with Instagram",
                      //       style: TextStyle(fontFamily: 'Century Gothic'),
                      //     ),
                      //     onPressed: () {},
                      //   ),
                      // ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, MyRoutes.homeRoute);
                      //   },
                      //   child: Text("Login"),
                      //   style: TextButton.styleFrom(minimumSize: Size(120, 40)),
                      // ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, MyRoutes.homeRoute);
                      //   },
                      //   child: Text("Login"),
                      //   style: TextButton.styleFrom(minimumSize: Size(120, 40)),
                      // ),
                    ],
                  ),
                ),
              ),
              // Text(
              //   "Don't have an account?",
              //   style: TextStyle(
              //     fontFamily: 'Century Gothic',
              //     color: Color.fromARGB(255, 164, 112, 90),
              //     fontSize: 15,
              //   ),
              // ),
              // TextButton(
              //   style: ButtonStyle(
              //     foregroundColor: MaterialStateProperty.all<Color>(
              //         Color.fromARGB(255, 114, 78, 63)),
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => signin()),
              //     );
              //   },
              //   child: Text(
              //     'Create Account',
              //     style: TextStyle(fontFamily: 'Century Gothic'),
              //   ),
              // ),
              // SizedBox(
              //   height: 25,
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: [
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                fontFamily: 'Century Gothic',
                color: Color.fromARGB(255, 164, 112, 90),
                fontSize: 15,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
        child: Divider(
      height: 1.5,
    ));
  }
}
