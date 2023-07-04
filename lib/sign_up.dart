import 'package:Masth_GURU/inReviewPage.dart';
import 'package:Masth_GURU/newReview.dart';
import 'package:Masth_GURU/redirect.dart';
import 'package:Masth_GURU/teacher.dart';
import 'package:Masth_GURU/therapist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class signin extends StatefulWidget {
  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;
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
                Text(
                  'Enter Email Credentials',
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
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //     hintText: "Enter email Id",
                        //     labelText: "Email Id",
                        //
                        //   ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return "Username cannot be empty";
                        //   }

                        //   return null;
                        // },
                        // onChanged: (value) {
                        //   name = value;
                        //   setState(() {});
                        // },
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: 'Email'),
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
                            });
                          },
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(hintText: 'Password'),
                          onChanged: (value) {
                            setState(() {
                              _password = value.trim();
                            });
                          },
                        ),
                        // TextFormField(
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     hintText: "Enter password",
                        //     labelText: "Password",
                        //   ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return "Password cannot be empty";
                        //   } else if (value.length < 6) {
                        //     return "Password length should be atleast 6";
                        //   }

                        //   return null;
                        // },
                        // ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Material(
                          color: Color.fromARGB(255, 227, 207, 201),
                          // borderRadius:
                          //     BorderRadius.circular(changeButton ? 50 : 8),
                          borderRadius: BorderRadius.circular(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  auth
                                      .signInWithEmailAndPassword(
                                          email: _email, password: _password)
                                      .then((_) async {
                                    var user = auth.currentUser;
                                    var dataBase = FirebaseFirestore.instance
                                        .collection('Teachers');
                                    var query =
                                        await dataBase.doc(user!.uid).get();
                                    var data = query.data();
                                    if (data != null &&
                                        data["isTherapist"] != null) {
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
                                                builder: (context) =>
                                                    Teacher()));
                                      }
                                    } else {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewReview()));
                                    }
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  // width: changeButton ? 50 : 150,
                                  width: 90,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: changeButton
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Sign-in",
                                          style: TextStyle(
                                              fontFamily: 'Century Gothic',
                                              fontSize: 16,
                                              // color: Color.fromARGB(250, 164, 112, 90),
                                              color: Colors.black),
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  auth
                                      .createUserWithEmailAndPassword(
                                          email: _email, password: _password)
                                      .then((_) async {
                                    var user = auth.currentUser;
                                    var dataBase = FirebaseFirestore.instance
                                        .collection('Teachers');
                                    var query =
                                        await dataBase.doc(user!.uid).get();
                                    var data = query.data();
                                    if (data != null &&
                                        data["isTherapist"] != null) {
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
                                                builder: (context) =>
                                                    Teacher()));
                                      }
                                    } else {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewReview()));
                                    }
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  // width: changeButton ? 50 : 150,
                                  width: 90,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: changeButton
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Sign-up",
                                          style: TextStyle(
                                              fontFamily: 'Century Gothic',
                                              fontSize: 16,
                                              // color: Color.fromARGB(250, 164, 112, 90),
                                              color: Colors.black),
                                        ),
                                ),
                              ),
                            ],
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
