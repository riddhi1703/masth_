import 'package:Masth_GURU/refer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Counsellor_Page extends StatefulWidget {
  const Counsellor_Page({Key? key}) : super(key: key);
  String get title => '';
  @override
  State<Counsellor_Page> createState() => Counsellor_PageState();
}

class Counsellor_PageState extends State<Counsellor_Page> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String firstname = "";
  String lastname = "";
  String rollNo = "";
  String classValue = "";
  String section = "";
  String schoolUid = "";
  TextEditingController NameController = TextEditingController();
  TextEditingController ClassController = TextEditingController();
  TextEditingController SectionController = TextEditingController();
  TextEditingController AdmissionController = TextEditingController();
  final databaseStudent = FirebaseFirestore.instance;

  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  //DateTime _myDateTime = DateTime.now();
  final snackBar = SnackBar(
    content: const Text('Please Enter Correct Student Details'),
  );
  bool is_checked = false;
  String time = '?';
  String currValue = "I";
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 249, 239, 238),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 227, 207, 201),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/masti.png',
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            cursorColor: Colors.grey,
                            controller: AdmissionController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Admission Number',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),

                              // prefixIcon: Container(
                              //   padding: EdgeInsets.all(15),
                              //   child: Image.asset('assets/images/search.png'),
                              //   width: 18,
                              // ),
                            ),
                          ),
                        ),
                        // Container(
                        //     margin: EdgeInsets.only(left: 10),
                        //     padding: EdgeInsets.all(15),
                        //     decoration: BoxDecoration(
                        //         color: Theme.of(context).primaryColor,
                        //         borderRadius: BorderRadius.circular(15)),
                        //     //child: Image.asset('assets/images/.png'),
                        //     width: 25),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Consulted with the student's Parents"),
                  // subtitle: Text("Subtitle"),
                  value: is_checked,
                  onChanged: (value) {
                    setState(() => is_checked = value!);
                  },
                  activeColor: Color.fromARGB(255, 231, 215, 215),
                  checkColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 0, left: 50, right: 50),
                constraints: BoxConstraints(minWidth: 50, maxWidth: 150),
                width: 50,
                child: ElevatedButton(
                  onPressed: is_checked
                      ? () async {
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
                              .get();
                          if (ans.docs.length == 1) {
                            setState(() {
                              firstname = ans.docs.first.data()["firstname"];
                              lastname = ans.docs.first.data()["lastname"];
                              section = ans.docs.first.data()["section"];
                              rollNo = ans.docs.first.data()["rollNo"];
                              classValue = ans.docs.first.data()["Class"];
                            });
                            var myClass = StudentDetails(
                                firstname,
                                lastname,
                                classValue,
                                section,
                                AdmissionController.text,
                                schoolUid);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Refer_Page(myClass)),
                            );
                            // var dataBase = FirebaseFirestore.instance
                            //     .collection("StudentData")
                            //     .doc(schoolUid)
                            //     .collection("StudentData")
                            //     .doc(
                            //         "${AdmissionController.text}_${firstname}__${lastname}")
                            //     .get()
                            //     .then((valu) {
                            //   if (valu.exists) {

                            //   } else {
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(snackBar);
                            //   }
                            // });
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      : null,
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 231, 215, 215)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ))),
                  child: Container(
                    padding: EdgeInsets.all(14),
                    child: Text(
                      "Refer Student",
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
      ),
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
