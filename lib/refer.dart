
import 'package:Masth_GURU/teacher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Refer_Page extends StatefulWidget {
  StudentDetails myClass;
  Refer_Page(this.myClass, {Key? key}) : super(key: key);

  @override
  State<Refer_Page> createState() => _Refer_PageState(myClass);
}

class StudentDetails {
  StudentDetails(this.firstname, this.lastname, this.cls, this.sec, this.admNo,
      this.schoolUid);
  String firstname;
  String lastname;
  String cls;
  String sec;
  String admNo;
  String schoolUid;
}

class _Refer_PageState extends State<Refer_Page> {
  String reply = "Checking Student";
  CollectionReference? dataBase;
  User? user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final databaseStudent = FirebaseFirestore.instance;
  StudentDetails myclass;

  _Refer_PageState(this.myclass) {
    _backgroundTask();
  }

  _backgroundTask() async {
    await Future.delayed(const Duration(seconds: 0), () async {
      var school = await FirebaseFirestore.instance
          .collection("Teachers")
          .doc("${user!.uid}")
          .get();
      var schoolUid = school.data()!["schooluid"];
      var teacherId = school.data()!["teacherId"];
      var teacherName =school.data()!["name"];
      var ans = await databaseStudent
          .collection("StudentData")
          .doc(schoolUid)
          .collection("referredStudentscurr")
          .where("admNo", isEqualTo: myclass.admNo)
          .get();
      if (ans.docs.isEmpty) {
        setState(() {
          reply = "Student Referred Succefully\nRedirecting to Homepage";
        });
        FirebaseFirestore.instance
            .collection("StudentData")
            .doc(schoolUid)
            .collection("referredStudentscurr")
            .add({
          "firstname": myclass.firstname,
          "lastname": myclass.lastname,
          "class": myclass.cls,
          "section": myclass.sec,
          "admNo": myclass.admNo,
          "schoolUid": schoolUid,
          "referredby": {
            "uid": user!.uid,
            "username": user!.displayName,
            "email": user!.email ?? "",
            "referringteacherId": teacherId,
            "referringteacherName": teacherName
          }
        });
      } else {
        setState(() {
          reply = "Student Already Referred\nRedirecting to Homepage";
        });
      }
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Teacher()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 249, 239, 238),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Center(
          child: Text(
            reply,
            style: TextStyle(
                fontFamily: 'Century Gothic',
                fontSize: 16,
                // color: Color.fromARGB(250, 164, 112, 90),
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}