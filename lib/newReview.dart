import 'package:Masth_GURU/login_page.dart';
import 'package:Masth_GURU/redirect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NewReview extends StatefulWidget {
  const NewReview({Key? key}) : super(key: key);

  @override
  State<NewReview> createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  final snackBar = SnackBar(
    content: const Text('Please correct School Identifier'),
  );
  show(context) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool visible = false;
  final TextEditingController SchoolUIDController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  _launchRedirect(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RedirectPage()));
  }

  _Wait(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    _launchRedirect(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Identification"),
        actions: [
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.brown[400])),
              label: Text("Logout"),
              onPressed: () async {
                try {
                  await auth.signOut();
                } catch (e) {
                  //
                }
                try {
                  await googleSignIn.signOut();
                } catch (e) {
                  //
                }
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Please enter code provided by your School",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    // padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: TextField(
                      enabled: !visible,
                      style: TextStyle(
                        fontFamily: 'Century Gothic',
                      ),
                      obscureText: false,
                      controller: SchoolUIDController,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(147, 100, 81, 0.576),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'School Identifier',
                          labelStyle: TextStyle(
                            fontFamily: 'Century Gothic',
                          )),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: visible
                          ? null
                          : () async {
                              setState(() {
                                visible = true;
                              });
                              User? user = FirebaseAuth.instance.currentUser;
                              var x = await FirebaseFirestore.instance
                                  .collection("StudentData")
                                  .doc(SchoolUIDController.text)
                                  .get();
                              if (x.exists) {
                                await FirebaseFirestore.instance
                                    .collection("Teachers")
                                    .doc(user!.uid)
                                    .set(
                                        {"schooluid": SchoolUIDController.text},
                                        SetOptions(merge: true));
                                _Wait(context);
                              } else {
                                show(context);
                                SchoolUIDController.clear();
                              }
                              setState(() {
                                visible = false;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(121, 85, 72, 1),
                        textStyle: TextStyle(fontFamily: 'Century Gothic'),
                      ),
                      child: Text("Submit")),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
