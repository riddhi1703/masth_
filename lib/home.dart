// import 'dart:ffi';
// import 'dart:html';
import 'package:Masth_GURU/Send_Mail.dart';
import 'package:Masth_GURU/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoji_feedback/emoji_feedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:emoji_feedback/emoji_feedback.dart';
import 'dart:ui';

import 'package:Masth_GURU/Counsellor.dart';
import 'package:Masth_GURU/google_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'sos.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp() : super();

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
        body: Homepage(),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage() : super();

  String get title => '';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String schoolUid = "";
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController TextController = TextEditingController();
  TextEditingController RollnoController = TextEditingController();
  TextEditingController SectionController = TextEditingController();
  TextEditingController AdmissionController = TextEditingController();

  DateTime _myDateTime = DateTime.now();
  String formattedDate = "";
  final user = FirebaseAuth.instance.currentUser;
  final databaseStudent = FirebaseFirestore.instance;
  // Create a CollectionReference called studentBehaviour that references the firestore collection

  String behaviourState = "OK";

  String time = '?';
  final items = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    'XI',
    'XII'
  ];
  String? value;

  bool _isVisible = true;

// get class => null;

// get extends => null;

  String? classValue = "I";
  @override
  void initState() {
    super.initState();
    formattedDate = _myDateTime.toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 60,
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(121, 85, 72, 1),
                            textStyle: TextStyle(fontFamily: 'Century Gothic'),
                          ),
                          child: const Text('REFER TO COUNSELLOR'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Counsellor_Page()),
                            );
                          },
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: IconButton(
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
                              MaterialPageRoute(
                                  builder: (context) => const Sos()),
                            );
                          },
                          iconSize: 60,
                          icon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Image.asset(
                              'assets/images/sos_circle.png',

                              height: 60,
                              width: 60,
                              //fit: ,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.fromLTRB(50, 0, 0, 10),
                    child: const Text(
                      'Masth Guru',
                      style: TextStyle(
                          color: Color.fromRGBO(164, 112, 90, 1),
                          fontFamily: 'Century Gothic',
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ))
              ]),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: const Text(
                    'Good morning, Teacher',
                    style: TextStyle(
                        color: Color.fromRGBO(164, 112, 90, 1),
                        fontFamily: 'Century Gothic',
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  )),
              // Row(
              //   children: [
              //     Container(
              //         alignment: Alignment.centerLeft,
              //         padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              //         child: const Text(
              //           'Name of the student',
              //           style: TextStyle(
              //               color: Color.fromARGB(255, 160, 123, 74),
              //               fontWeight: FontWeight.w500,
              //               fontSize: 22),
              //         )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: TextField(
                  style: TextStyle(
                    fontFamily: 'Century Gothic',
                  ),
                  onChanged: (value) async {
                    if (schoolUid == "") {
                      var school = await databaseStudent
                          .collection("Teachers")
                          .doc("${user!.uid}")
                          .get();
                      schoolUid = school.data()!["schooluid"];
                    }
                    var ans = await databaseStudent
                        .collection("StudentData")
                        .doc(schoolUid)
                        .collection("StudentData")
                        .where("admissionNo",
                            isEqualTo: AdmissionController.text)
                        .limit(1)
                        .get();
                    if (ans.docs.length == 1) {
                      setState(() {
                        firstnameController.text =
                            ans.docs.first.data()["firstname"];
                        lastnameController.text =
                            ans.docs.first.data()["lastname"];
                        SectionController.text =
                            ans.docs.first.data()["section"];
                        RollnoController.text = ans.docs.first.data()["rollNo"];
                        classValue = ans.docs.first.data()["Class"];
                      });
                    }
                  },
                  obscureText: false,
                  controller: AdmissionController,
                  decoration: const InputDecoration(
                      fillColor: Color.fromRGBO(147, 100, 81, 0.576),
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Admission No',
                      labelStyle: TextStyle(
                        fontFamily: 'Century Gothic',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Century Gothic',
                        ),
                        controller: firstnameController,
                        decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(147, 100, 81, 0.576),
                            hintStyle: TextStyle(color: Colors.brown),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                              fontFamily: 'Century Gothic',
                            )),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Century Gothic',
                        ),
                        controller: lastnameController,
                        decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(147, 100, 81, 0.576),
                            hintStyle: TextStyle(color: Colors.brown),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              fontFamily: 'Century Gothic',
                            )),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      // color: Colors.black,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(147, 100, 81, 0.576),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.brown,
                              )),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text("Class"),
                              value: classValue,
                              iconSize: 36,
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                              isExpanded: true,
                              items: items.map(buildMenuItem).toList(),
                              onChanged: (value) =>
                                  setState(() => classValue = value!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      // padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Century Gothic',
                        ),
                        obscureText: false,
                        controller: SectionController,
                        decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(147, 100, 81, 0.576),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Section',
                            labelStyle: TextStyle(
                              fontFamily: 'Century Gothic',
                            )),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      // padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Century Gothic',
                        ),
                        obscureText: false,
                        controller: RollnoController,
                        decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(147, 100, 81, 0.576),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Roll no.',
                            labelStyle: TextStyle(
                              fontFamily: 'Century Gothic',
                            )),
                      ),
                    ),
                  ],
                ),
              ),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       // color: Colors.black,
              //       padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              //       child: Center(
              //         child: Container(
              //           padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              //           decoration: BoxDecoration(
              //               color: Color.fromRGBO(147, 100, 81, 0.576),
              //               borderRadius: BorderRadius.circular(5),
              //               border: Border.all(
              //                 color: Colors.brown,
              //               )),
              //           child: DropdownButtonHideUnderline(
              //             child: DropdownButton<String>(
              //               value: value,
              //               iconSize: 36,
              //               icon:
              //                   Icon(Icons.arrow_drop_down, color: Colors.black),
              //               isExpanded: true,
              //               items: items.map(buildMenuItem).toList(),
              //               onChanged: (value) =>
              //                   setState(() => this.value = value),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              //       child: TextField(
              //         style: TextStyle(
              //           fontFamily: 'Century Gothic',
              //         ),
              //         obscureText: false,
              //         controller: RollnoController,
              //         decoration: const InputDecoration(
              //             fillColor: Color.fromRGBO(147, 100, 81, 0.576),
              //             filled: true,
              //             border: OutlineInputBorder(),
              //             labelText: 'Section',
              //             labelStyle: TextStyle(
              //               fontFamily: 'Century Gothic',
              //             )),
              //       ),
              //     ),
              //   ],
              // ),

              Container(
                // onPressed: () {
                //   //forgot password screen
                // },
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Observed behaviour',
                  style: TextStyle(
                      color: Color.fromRGBO(164, 112, 90, 1),
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(19, 0, 9, 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: 5,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontFamily: 'Century Gothic',
                    fontSize: 18,
                    height: 3.0,
                  ),
                  controller: TextController,
                  decoration: const InputDecoration(
                    fillColor: Color.fromRGBO(147, 100, 81, 0.576),
                    hintStyle: TextStyle(color: Colors.brown),
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              _isVisible
                  ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                      child: const Text(
                        'How was the student behaving today?',
                        style: TextStyle(
                            color: Color.fromRGBO(164, 112, 90, 1),
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ))
                  : Container(),
              _isVisible
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          icon: Image.asset('assets/images/emoji1.png'),
                          iconSize: 50,
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                            behaviourState = "Terrible";
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            icon: Image.asset('assets/images/emoji2.png'),
                            iconSize: 50,
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                              behaviourState = "Bad";
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            icon: Image.asset('assets/images/emoji3.png'),
                            iconSize: 50,
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                              behaviourState = "OK";
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          icon: Image.asset('assets/images/emoji4.png'),
                          iconSize: 50,
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                            behaviourState = "Good";
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          icon: Image.asset('assets/images/emoji5.png'),
                          iconSize: 50,
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                            behaviourState = "Awesome";
                          },
                        ),
                      ],
                    )
                  : Container(),
              _isVisible == false
                  ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                      child: const Text(
                        'Thank you for your Response!',
                        style: TextStyle(
                            color: Color.fromRGBO(164, 112, 90, 1),
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ))
                  : Container(),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
              //   child: EmojiFeedback(
              //     onChange: (index) {
              //       print(index);
              //     },
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.center,
              //   padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              //   child: Image.asset('assets/images/all_icons.png', scale: 10),
              // ),
              Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(1, 20, 0, 10),
                  child: Text(
                    time,
                    style: TextStyle(
                        fontFamily: 'Century Gothic',
                        color: Color.fromRGBO(121, 85, 72, 1)),
                  )
                  // style: TextStyle(
                  //     color: Color.fromRGBO(164, 112, 90, 1),
                  //     fontFamily: 'Century Gothic',
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 18),
                  ),
              Row(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: const Text(
                      'Behaviour observed on :',
                      style: TextStyle(
                          color: Color.fromRGBO(164, 112, 90, 1),
                          fontFamily: 'Century Gothic',
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(1, 1, 0, 0),
                  height: 70,
                  child: IconButton(
                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                    icon: Image.asset('assets/images/calendar-5-512.png'),
                    iconSize: 85,
                    onPressed: () async {
                      _myDateTime = (await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: _myDateTime = _myDateTime,
                          firstDate: DateTime(1990),
                          lastDate: DateTime.now()))!;
                      print(_myDateTime);
                      setState(() {
                        formattedDate = _myDateTime.toString().split(' ')[0];
                      });
                    },
                    // onPressed: () async {
                    //   _myDateTime = (await showDatePicker(
                    //       context: context,
                    //       initialDate: _myDateTime = _myDateTime,
                    //       firstDate: DateTime(1990),
                    //       lastDate: DateTime(2800)))!;
                    //   setState(() {
                    //     final now = DateTime.now();
                    //     time = //DateFormat('dd-MM-yy').format(_myDateTime);
                    //         _myDateTime.toString();
                    //   });
                    // },
                  ),
                ),
              ]),
              Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(121, 85, 72, 1),
                      textStyle: TextStyle(fontFamily: 'Century Gothic'),
                    ),
                    child: const Text('ADD TO RECORDS'),
                    onPressed: () async {
                      if (schoolUid == "") {
                        var school = await databaseStudent
                            .collection("Teachers")
                            .doc("${user!.uid}")
                            .get();
                        schoolUid = school.data()!["schooluid"];
                      }
                      var studentBehaviour = FirebaseFirestore.instance
                          .collection('StudentData')
                          .doc(schoolUid)
                          .collection("StudentData")
                          .doc(
                              '${AdmissionController.text}_${firstnameController.text}_${lastnameController.text}');
                      //Setting Student Data
                      studentBehaviour.set({
                        'firstname': firstnameController.text,
                        "lastname": lastnameController.text,
                        'rollNo': RollnoController.text,
                        'Class': classValue ?? 'not specified',
                        'section': SectionController.text,
                        'admissionNo': AdmissionController.text,
                        "adduid": user!.uid,
                        "schoolUid": schoolUid
                      }, SetOptions(merge: true));
                      //Setting Student Behaviour

                      var ans = await studentBehaviour.get();
                      var ne = ans.data() as Map<String, dynamic>;
                      if (ne["StudentBehaviour"] == null) {
                        ne["StudentBehaviour"] = [];
                      }
                      ne["StudentBehaviour"].add({
                        'behaviour': TextController.text,
                        'behaviourState': behaviourState,
                        'date': formattedDate,
                      });
                      studentBehaviour.set(ne);
                      // studentBehaviour.update({
                      //   "StudentBehaviour": [
                      // {
                      //   'behaviour': TextController.text,
                      //   'behaviourState': behaviourState,
                      //   'date': formattedDate,
                      // }
                      //   ]
                      // });
                      // studentBehaviour
                      //     .set({
                      //       "StudentBehaviour": [
                      //         {
                      //           'behaviour': TextController.text,
                      //           'behaviourState': behaviourState,
                      //           'date': formattedDate,
                      //         }
                      //       ]
                      //     }, SetOptions(merge: true))
                      //     .then((value) => print("Student Behaviour Recorded"))
                      //     .catchError((error) => print(
                      //         "Failed to record student behaviour: $error"));
                      setState(() {
                        _isVisible = true;
                        firstnameController.clear();
                        lastnameController.clear();
                        RollnoController.clear();
                        SectionController.clear();
                        AdmissionController.clear();
                        TextController.clear();
                        _myDateTime = DateTime.now();
                        formattedDate = _myDateTime.toString().split(' ')[0];
                      });
                    },
                  )),
              // Container(
              //     height: 60,
              //     padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         primary: Color.fromRGBO(121, 85, 72, 1),
              //         textStyle: TextStyle(fontFamily: 'Century Gothic'),
              //       ),
              //       child: const Text('REFER STUDENT TO THERAPIST'),
              //       onPressed: () {
              //         print(nameController.text);
              //       },
              //     )),
            ],
          )),
    );
  }

  DateFormat(String s) {}
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 15),
        ),
      );
}
