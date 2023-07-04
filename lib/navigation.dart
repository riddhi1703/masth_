import 'package:Masth_GURU/drafts1.dart';

import 'package:Masth_GURU/home.dart' as home;
import 'package:basic_utils/basic_utils.dart';
import 'package:intl/intl.dart';
import 'package:Masth_GURU/login_page.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // secureScreen() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_FULLSCREEN);
  // }

  @override
  void initState() {
    super.initState();
    // secureScreen();
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Do you want to exit the app?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Yes")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("No")),
      ],
    );
    String user = auth.currentUser!.displayName ?? "Teacher";
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            title: Text(
              StringUtils.capitalize("Hello ${user}", allWords: true),
            ),
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
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              8.0,
              8.0,
              8.0,
              8.0,
            ),
            child: Column(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(249, 239, 238, 10),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.brown[400],
                        borderRadius: BorderRadius.circular(25.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        child: Text(
                          'Enter User Data',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Retrieve User Data',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const Center(
                        child: home.Homepage(),
                      ),
                      const Center(
                        child: MyStatefulWidget(),
                      ),
                      // Scaffold(
                      //   body: Center(child: Text('This is personalized feed')),
                      //   floatingActionButton: FloatingActionButton.extended(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, '/spin');
                      //     },
                      //     label: Text('Share'),
                      //     backgroundColor: Color.fromRGBO(164, 112, 90, 1),
                      //     icon: const Icon(Icons.share),
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
