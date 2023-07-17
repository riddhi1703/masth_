
import 'dart:io';

import 'package:Masth_GURU/student_model.dart';
import 'package:Masth_GURU/therapist.dart';
import 'package:Masth_GURU/widget/scrollable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ViewData extends StatefulWidget {
  final StudentDetails myClass;

  ViewData(this.myClass, {Key? key}) : super(key: key);

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  CollectionReference? dataBase;
  CollectionReference? oldDatabase;

  @override
  void initState() {
    super.initState();
    setValues();
  }

  void setValues() async {
    dataBase = FirebaseFirestore.instance
        .collection("StudentData")
        .doc(widget.myClass.schoolUid)
        .collection('referredStudentscurr');
    oldDatabase = FirebaseFirestore.instance
        .collection("StudentData")
        .doc(widget.myClass.schoolUid)
        .collection('referredStudentsold');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 207, 201),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 164, 112, 90),
        title: Text(
          "${widget.myClass.firstname} ${widget.myClass.cls} ${widget.myClass.sec}",
          overflow: TextOverflow.clip,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                width: double.infinity,
                child: Text(
                  "Student's Profile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "First Name: ${widget.myClass.firstname}\nLast Name: ${widget.myClass.lastname}\n",
              ),
              SizedBox(height: 5),
              Text(
                "Class and Section: ${widget.myClass.cls} ${widget.myClass.sec}",
              ),
              SizedBox(height: 5),
              Text(
                "Admission Number: ${widget.myClass.admNo}",
              ),
              SizedBox(height: 5),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var data =
                    await dataBase!.doc(widget.myClass.deleteID).get();
                    oldDatabase!.add(data.data()!);
                    await dataBase!.doc(widget.myClass.deleteID).delete();
                    Navigator.pop(context);
                  },
                  child: Text("Resolved"),
                ),
              ),
              SizedBox(
                height: 10,
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
        ),
      ),
    );
  }

  Widget buildDataTable(List<StudentBehaviour> studentBehaviours) {
    final columns = [
      'Date',
      'Observed Behaviour',
      'Emoji',
      'Teacher Name',
      'Teacher Id'
    ];
    return ScrollableWidget(
      child: DataTable(
        columns: getColumns(columns),
        rows: getRows(studentBehaviours),
        border: TableBorder.all(),
        columnSpacing: 10,
        horizontalMargin: 10,
      ),
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
          studentBehaviour.teacherName,
          studentBehaviour.teacherId,
        ];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text(data.toString()))).toList();

  Future<List<StudentBehaviour>> readStudentBehaviour() async {
    var behaviourQuerySnapshot = await FirebaseFirestore.instance
        .collection('StudentData')
        .doc(widget.myClass.schoolUid)
        .collection('StudentData')
        .where('admissionNo', isEqualTo: widget.myClass.admNo)
        .get();

    List<StudentBehaviour> studentBehaviours = [];

    for (var behaviourDocument in behaviourQuerySnapshot.docs) {
      var behaviourData = behaviourDocument.data();
      var behaviourList = behaviourData['StudentBehaviour'] as List<dynamic>?;
      // var teacherName = behaviourData['teacherName'] as String?;
      // var teacherId = behaviourData['teacherId'] as String?;

      if (behaviourList != null) {
        for (var behaviour in behaviourList) {
          var studentBehaviour = StudentBehaviour(
            date: behaviour['date'] as String? ?? '',
            behaviour: behaviour['behaviour'] as String? ?? '',
            behaviourState: behaviour['behaviourState'] as String? ?? '',
            // teacherName: teacherName ?? '',
            // teacherId: teacherId ?? '',
            teacherName: behaviour['teacherName']  as String? ?? '',
            teacherId: behaviour['teacherId'] as String? ?? '',
          );

          studentBehaviours.add(studentBehaviour);
        }
      }
    }

    return studentBehaviours;
  }

}
