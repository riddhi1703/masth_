import 'package:Masth_GURU/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widget/scrollable_widget.dart';

class IndStudentInfo extends StatefulWidget {
  StudentData studentData;
  IndStudentInfo({Key? key, required this.studentData}) : super(key: key);

  @override
  State<IndStudentInfo> createState() => _IndStudentInfoState(studentData);
}

class _IndStudentInfoState extends State<IndStudentInfo> {
  StudentData studentData;
  _IndStudentInfoState(this.studentData);

  final user = FirebaseAuth.instance.currentUser;
  // GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Teachers');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('${studentData.firstname} Data'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Text(
              'First Name: ${studentData.firstname}\nLast Name: ${studentData.lastname}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Class: ${studentData.Class}'),
              Text('Section: ${studentData.section}'),
              Text('Roll Number: ${studentData.rollNo}'),
            ],
          ),
          FutureBuilder<List<StudentBehaviour>>(
            future: readStudentBehaviour(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Something went Worng!\n${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final studentBehaviours = snapshot.data!;

                return buildDataTable(studentBehaviours);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildDataTable(List<StudentBehaviour> studentBehaviours) {
    final columns = ['Date', 'Observed Behaviour', 'Emoji'];
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(studentBehaviours),
      border: TableBorder.all(),
      columnSpacing: 10,
      horizontalMargin: 10,
    );
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(List<StudentBehaviour> studentBehaviours) =>
      studentBehaviours.map((StudentBehaviour studentBehaviour) {
        final cells = [
          studentBehaviour.date,
          studentBehaviour.behaviour,
          studentBehaviour.behaviourState,
        ];

        return DataRow(
          cells: getCells(cells),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text(data.toString()))).toList();

  Widget buildStudentBehaviour(StudentBehaviour studentBehaviour) =>
      GestureDetector(
        onTap: () {
          print(studentBehaviour.behaviourState);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(studentBehaviour.date),
            Text(studentBehaviour.behaviour),
            Text(studentBehaviour.behaviourState),
          ],
        ),
      );

  Future<List<StudentBehaviour>> readStudentBehaviour() async {
    // var school = await FirebaseFirestore.instance
    //                           .collection("Teachers")
    //                           .doc("${user!.uid}")
    //                           .get();
    // var schoolUid = school.data()!["schooluid"];
    var x = await FirebaseFirestore.instance
        .collection('StudentData')
        .doc(studentData.schoolUid)
        .collection("StudentData")
        .doc(
            '${studentData.admissionNo}_${studentData.firstname}_${studentData.lastname}')
        .get();
    var y = x["StudentBehaviour"] as List<dynamic>;
    List<StudentBehaviour> behave = [];
    y.forEach(
      (element) {
        behave.add(StudentBehaviour.fromJson(element));
      },
    );
    print(x);
    return behave;
  }
}
