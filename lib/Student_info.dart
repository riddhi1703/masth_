import 'package:Masth_GURU/Ind_Student_info.dart';
import 'package:Masth_GURU/student_model.dart';
import 'package:Masth_GURU/widget/scrollable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Masth_GURU/home.dart';

class StudentInfo extends StatefulWidget {
  StudentInfo({required this.studentUid, Key? key}) : super(key: key);
  String studentUid;
  @override
  State<StudentInfo> createState() => _StudentInfoState(studentUid);
}

class _StudentInfoState extends State<StudentInfo> {
  final user = FirebaseAuth.instance.currentUser;
  String schoolUid = "";
  _StudentInfoState(this.schoolUid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Student Data'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<List<StudentData>>(
        stream: readStudentData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went Worng!\n${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final students = snapshot.data!;
            // return ListView(
            //   children: students.map(buildStudent).toList(),
            // );
            if (students.isEmpty) {
              return Container(
                width: double.infinity,
                child: Text(
                  "No Data Uploaded",
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Column(
                children: [
                  buildDataTable(students),
                  Text(
                    "Long Press on a Student to view full data",
                    textAlign: TextAlign.end,
                  ),
                ],
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildDataTable(List<StudentData> students) {
    final columns = ['Adm No', 'First Name', 'Last Name', 'Class', 'Section'];
    return ScrollableWidget(
        child: DataTable(
      columns: getColumns(columns),
      rows: getRows(students),
      border: TableBorder.all(),
    ));
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(List<StudentData> students) {
    students.removeWhere((element) => element.uid != user!.uid);
    var x = students.map((StudentData student) {
      final cells = [
        student.admissionNo,
        student.firstname,
        student.lastname,
        student.Class,
        student.section,
      ];

      return DataRow(
          cells: getCells(cells),
          onLongPress: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IndStudentInfo(studentData: student)));
          });
    }).toList();
    return x;
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text(data.toString()))).toList();

  // String getData() async {
  //   var school = await FirebaseFirestore.instance
  //       .collection("Teachers")
  //       .doc("${user!.uid}")
  //       .get();
  //   return school.data()!["schooluid"];
  // }

  Stream<List<StudentData>> readStudentData() {
    var x = FirebaseFirestore.instance
        .collection('StudentData')
        .doc(schoolUid)
        .collection("StudentData")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => StudentData.fromJson(doc.data()))
            .toList());
    return x;
  }
}
