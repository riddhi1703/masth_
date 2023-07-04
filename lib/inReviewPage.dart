import 'package:Masth_GURU/login_page.dart';
import 'package:Masth_GURU/redirect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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

  Future<DocumentSnapshot<Map<String, dynamic>>> _getData() async {
    var user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection("Teachers")
        .doc(user!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("In Review"),
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
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var data = snapshot.data?.data();
              if (data != null && data["schooluid"] != null) {
                if (data["schooluid"] == "-1") {
                  return Center(
                    child: Text("Your Application Request has been denied"),
                  );
                } else {
                  _Wait(context);
                  return Center(
                    child: Text("Please Wait"),
                  );
                }
              } else {
                return Center(
                  child: Text(
                      "Your Application is in Review.\nPlease check back in 24-48 hours"),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong.\nPlease try again later!"),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
