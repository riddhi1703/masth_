import 'package:Masth_GURU/teacher.dart';
import 'package:Masth_GURU/therapist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RedirectPage extends StatefulWidget {
  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  CollectionReference? dataBase;
  User? user;
  final FirebaseAuth auth = FirebaseAuth.instance;

  _launchTeacher(context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Teacher()));
  }

  _launchTherapist(context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TherapistPage()));
  }

  void initState() {
    super.initState();
    dataBase = FirebaseFirestore.instance.collection('Teachers');
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Image.asset("assets/images/masti.png"),
      // ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Are you a Teacher or Therapist?",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(250, 164, 112, 90)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Please choose very carefully, you will not be able to edit this later.",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(250, 164, 112, 90),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(250, 164, 112, 90))),
                  onPressed: () async {
                    await dataBase!
                        .doc(user!.uid)
                        .set({"isTherapist": true}, SetOptions(merge: true));
                    _launchTherapist(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: Text(
                      "Therapist",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(250, 164, 112, 90))),
                  onPressed: () async {
                    await dataBase!.doc(user!.uid).set({
                      "isTherapist": false,
                    }, SetOptions(merge: true));
                    _launchTeacher(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: Text(
                      "Teacher",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
