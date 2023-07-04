import 'package:Masth_GURU/inReviewPage.dart';
import 'package:Masth_GURU/newReview.dart';
import 'package:Masth_GURU/redirect.dart';
import 'package:Masth_GURU/teacher.dart';
import 'package:Masth_GURU/therapist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google_page extends StatefulWidget {
  const Google_page({Key? key}) : super(key: key);

  @override
  State<Google_page> createState() => _Google_pageState();
}

class _Google_pageState extends State<Google_page> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    // if (_formKey.currentState.validate()) {
    //   setState(() {
    //     changeButton = true;
    //   });
    //   await Future.delayed(Duration(seconds: 1));
    //   // await Navigator.pushNamed(context, MyRoutes.homeRoute);
    //   setState(() {
    //     changeButton = false;
    //   });
    // }
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Align(
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
                ),
                // SizedBox(
                //   height: 18,
                // ),
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
                SizedBox(
                  height: 20.0,
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
                SizedBox(
                  height: 20.0,
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
                        Material(
                          color: Color.fromARGB(255, 227, 207, 201),
                          // borderRadius:
                          //     BorderRadius.circular(changeButton ? 50 : 8),
                          borderRadius: BorderRadius.circular(24),
                          child: InkWell(
                            onTap: () async {
                              // await signInWithGoogle();
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

                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              // width: changeButton ? 50 : 150,
                              width: 120,
                              height: 50,
                              alignment: Alignment.center,
                              child: changeButton
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'Century Gothic',
                                          fontSize: 16,
                                          // color: Color.fromARGB(250, 164, 112, 90),
                                          color: Colors.black),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Material(
                          color: Color.fromARGB(255, 227, 207, 201),
                          // borderRadius:
                          //     BorderRadius.circular(changeButton ? 50 : 8),
                          borderRadius: BorderRadius.circular(24),
                          child: InkWell(
                            //
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              userEmail = "";
                              await GoogleSignIn().signOut();
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              // width: changeButton ? 50 : 150,
                              width: 120,
                              height: 50,
                              alignment: Alignment.center,
                              child: changeButton
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontFamily: 'Century Gothic',
                                          fontSize: 16,
                                          // color: Color.fromARGB(250, 164, 112, 90),
                                          color: Colors.black),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

String userEmail = "";
final FirebaseAuth auth = FirebaseAuth.instance;


// SignInGoogle() async {
//   await signInWithGoogle();
// }
