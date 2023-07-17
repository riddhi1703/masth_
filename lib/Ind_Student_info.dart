
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


  @override
  Widget build(BuildContext context) {
    if (studentData == null) {
      return Center(
        child: Text('No student data available.'),
      );
    }

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
            'First Name: ${studentData.firstname}\nLast Name: ${studentData.lastname}',
          ),
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
                  child: Text('Something went wrong!\n${snapshot.error}'),
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

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) => DataColumn(label: Text(column))).toList();
  }

  List<DataRow> getRows(List<StudentBehaviour> studentBehaviours) {
    return studentBehaviours.map((StudentBehaviour studentBehaviour) {
      final cells = [
        studentBehaviour.date ?? '',
        studentBehaviour.behaviour ?? '',
        studentBehaviour.behaviourState ?? '',
      ];

      return DataRow(
        cells: getCells(cells),
      );
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) {
    return cells.map((data) => DataCell(Text(data?.toString() ?? ''))).toList();
  }


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


  // Future<List<StudentBehaviour>> readStudentBehaviour() async {
  //   var x = await FirebaseFirestore.instance
  //       .collection('StudentData')
  //       .doc(studentData.schoolUid)
  //       .collection("StudentData")
  //       .where('admissionNo', isEqualTo: studentData.admissionNo)
  //       .get();
  //
  //   var document = x.docs.first;
  //   if (document.exists) {
  //     var data = document.data();
  //     var studentBehaviourList = data?["StudentBehaviour"] as List<dynamic>?;
  //     List<StudentBehaviour> behave = [];
  //
  //     if (studentBehaviourList != null) {
  //       studentBehaviourList.forEach((behaviorData) {
  //         var behaviorMap = behaviorData as Map<String, dynamic>;
  //         var behavior = behaviorMap["behaviour"] as String?;
  //         var behaviorState = behaviorMap["behaviourState"] as String?;
  //         var date = behaviorMap["date"] as String?;
  //
  //         if (behavior != null && behaviorState != null && date != null) {
  //           behave.add(StudentBehaviour(
  //             behaviour: behavior,
  //             behaviourState: behaviorState,
  //             date: date,
  //             teacherName: "",
  //             teacherId: "",
  //           ));
  //         }
  //       });
  //     }
  //
  //     return behave;
  //   }
  //
  //   return [];
  // }

  Future<List<StudentBehaviour>> readStudentBehaviour() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('StudentData')
        .doc(studentData.schoolUid)
        .collection("StudentData")
        .where('admissionNo', isEqualTo: studentData.admissionNo)
        .get();

    List<StudentBehaviour> behave = [];

    for (var document in querySnapshot.docs) {
      var data = document.data();
      var studentBehaviourList = data?["StudentBehaviour"] as List<dynamic>?;
      var teacherName = data?["teacherName"] as String?;
      var teacherId = data?["teacherId"] as String?;

      if (studentBehaviourList != null) {
        studentBehaviourList.forEach((behaviorData) {
          var behaviorMap = behaviorData as Map<String, dynamic>;
          var behavior = behaviorMap["behaviour"] as String?;
          var behaviorState = behaviorMap["behaviourState"] as String?;
          var date = behaviorMap["date"] as String?;

          if (behavior != null && behaviorState != null && date != null) {
            behave.add(StudentBehaviour(
              behaviour: behavior,
              behaviourState: behaviorState,
              date: date,
              teacherName: teacherName ?? "",
              teacherId: teacherId ?? "",
            ));
          }
        });
      }
    }

    return behave;
  }



}
