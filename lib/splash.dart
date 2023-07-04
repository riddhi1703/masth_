import 'package:Masth_GURU/inReviewPage.dart';
import 'package:Masth_GURU/login_page.dart';
import 'package:Masth_GURU/newReview.dart';
import 'package:Masth_GURU/redirect.dart';
import 'package:Masth_GURU/teacher.dart';
import 'package:Masth_GURU/therapist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late SharedPreferences prefs;
  final String userTypeKey = "userTypreKey";
  bool? isTherapist;
  CollectionReference? dataBase;
  User? user;
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1000), () async {
      user = auth.currentUser;
      prefs = await SharedPreferences.getInstance();
      // isTherapist = prefs.getBool(userTypeKey);
      dataBase = FirebaseFirestore.instance.collection('Teachers');
    });

    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      var query = await dataBase!.doc(user!.uid).get();
      var data = query.data() as Map<String, dynamic>?;
      if (data != null && data["isTherapist"] != null) {
        if (data["isTherapist"] == true) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => TherapistPage()));
        } else {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Teacher()));
        }
      } else {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NewReview()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //return Container();
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Image.asset('assets/images/masti.png', height: 130),
          // Text(
          //   "I'm all ears",
          //   style: TextStyle(
          //       fontFamily: 'Century Gothic',
          //       fontSize: 22.0,
          //       color: Theme.of(context).primaryColor),
          // ),
          // Text(
          //   "- Masti",
          //   style: TextStyle(
          //       fontFamily: 'Century Gothic',
          //       fontSize: 22.0,
          //       color: Theme.of(context).primaryColor),
          // ),
          Text("breathe in",
              style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold)),
          Text("breathe out",
              style: TextStyle(fontFamily: 'Century Gothic', fontSize: 22.0)),
        ])));
  }
}
