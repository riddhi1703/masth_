//import 'dart:js';

import 'package:Masth_GURU/Student_info.dart';
import 'package:Masth_GURU/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';
//import 'package:google_nav_bar/google_nav_bar.dart';

import 'sos.dart';

void main() => runApp(const draft());

class draft extends StatelessWidget {
  const draft() : super();

  static const String _title = 'SOS';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      // ignore: unnecessary_new
      theme: new ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(249, 239, 238, 1)),
      home: const Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget() : super();

  String get title => '';

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController TextController = TextEditingController();
  TextEditingController RollnoController = TextEditingController();
  //DateTime _myDateTime = DateTime.now();
  String time = '?';
  String schoolUid = "";

// get class => null;

// get extends => null;

// var class;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.end,
              // padding: const EdgeInsets.fromLTRB(1, 1, 0, 0),
              children: [
                IconButton(
                  //onPressed: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (_) => Sos()));
                  //  },
                  onPressed: () {
                    // Navigator.of(context, rootNavigator: true)
                    //     .push<void>(PageRoute(
                    //   //title: SettingsTab.title,
                    //   fullscreenDialog: true,
                    //   builder: (context) => const Sos(),
                    // ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Sos()),
                    );
                  },
                  iconSize: 60,
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                    child: Image.asset(
                      'assets/images/sos_circle.png',

                      height: 150,
                      width: 150,
                      //fit: ,
                    ),
                  ),
                ),
              ]),
          // Container(
          //     alignment: Alignment.centerRight,
          //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          //     child: const Text(
          //       'SOS',
          //       style: TextStyle(
          //           color: Color.fromRGBO(164, 112, 90, 1),
          //           fontFamily: 'Century Gothic',
          //           fontWeight: FontWeight.w500,
          //           fontSize: 18),
          //     )),
          Row(children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 10),
              child: Image.asset('assets/images/masti.png', scale: 10),
            ),
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(50, 0, 10, 10),
                child: const Text(
                  'Masth Guru',
                  style: TextStyle(
                      color: Color.fromRGBO(164, 112, 90, 1),
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ))
          ]),
          // Container(
          //     alignment: Alignment.centerLeft,
          //     padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          //     child: const Text(
          //       'Name of the student',
          //       style: TextStyle(
          //           color: Color.fromRGBO(164, 112, 90, 1),
          //           fontFamily: 'Century Gothic',
          //           fontWeight: FontWeight.w500,
          //           fontSize: 22),
          //     )),
          // Container(
          //   margin: EdgeInsets.only(top: 25, left: 25, right: 25),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           Flexible(
          //             flex: 1,
          //             child: TextField(
          //               cursorColor: Colors.grey,
          //               decoration: InputDecoration(
          //                   fillColor: Color.fromARGB(255, 249, 239, 238),
          //                   filled: true,
          //                   border: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(20),
          //                       borderSide: BorderSide.none),
          //                   hintText: 'Search',
          //                   hintStyle:
          //                       TextStyle(color: Colors.grey, fontSize: 18),
          //                   prefixIcon: Container(
          //                     padding: EdgeInsets.all(10),
          //                     child: Image.asset('assets/images/search.png'),
          //                     width: 14,
          //                   )),
          //             ),
          //           ),
          //           // Container(
          //           //     margin: EdgeInsets.only(left: 10),
          //           //     padding: EdgeInsets.all(15),
          //           //     decoration: BoxDecoration(
          //           //         color: Theme.of(context).primaryColor,
          //           //         borderRadius: BorderRadius.circular(15)),
          //           //     //child: Image.asset('assets/images/.png'),
          //           //     width: 25),
          //         ],
          //       )
          //     ],
          //   ),
          // ),

          // Container(
          //     alignment: Alignment.center,
          //     padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
          //     child: const Text(
          //       'OR',
          //       style: TextStyle(
          //           color: Color.fromRGBO(164, 112, 90, 1),
          //           fontFamily: 'Century Gothic',
          //           fontWeight: FontWeight.w500,
          //           fontSize: 22),
          //     )),
          Container(
              height: 100,
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(121, 85, 72, 1),
                  textStyle: TextStyle(fontFamily: 'Century Gothic'),
                ),
                child: const Text(
                  'VIEW FULL DATA',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  if (schoolUid == "") {
                    var user = FirebaseAuth.instance.currentUser;
                    var school = await FirebaseFirestore.instance
                        .collection("Teachers")
                        .doc("${user!.uid}")
                        .get();
                    schoolUid = school.data()!["schooluid"];
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudentInfo(studentUid: schoolUid)),
                    // MaterialPageRoute(builder: (context) => SfDataGridDemo()),
                  );
                },
              )),
          SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Container(
          //       constraints: BoxConstraints.tightForFinite(
          //         width: 150,
          //       ),

          //       // padding: const EdgeInsets.fromLTRB(400, 50, 10, 0),
          //       child: FloatingActionButton.extended(
          //         onPressed: () {},
          //         label: Text('Share via mail'),
          //         icon: const Icon(Icons.share),
          //         backgroundColor: Color.fromRGBO(164, 112, 90, 1),
          //       ),
          //     )
          //   ],
          // ),
          // Container(
          //   constraints: BoxConstraints.tightForFinite(
          //     width: 50,
          //   ),

          //   // padding: const EdgeInsets.fromLTRB(400, 50, 10, 0),
          //   child: FloatingActionButton.extended(
          //     onPressed: () {},
          //     label: Text('Share via mail'),
          //     icon: const Icon(Icons.share),
          //     backgroundColor: Color.fromRGBO(164, 112, 90, 1),
          //   ),
          // )
          //   floatingActionButton: FloatingActionButton.extended(
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/spin');
          //     },
          //     label: Text('Share'),
          //     backgroundColor: Color.fromRGBO(164, 112, 90, 1),
          //     icon: const Icon(Icons.share),
          //   ),
        ],
      ),
    );
  }
}

// Future sendEmail() async{
//   final message = Message()
//   ..subject = 'Hello xyz!'
//   ..text = 'This is a test Email!';
// }