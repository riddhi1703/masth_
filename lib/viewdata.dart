import 'dart:io';

import 'package:Masth_GURU/student_model.dart';
import 'package:Masth_GURU/therapist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ViewData extends StatefulWidget {
  StudentDetails myClass;
  ViewData(this.myClass, {Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState(myClass);
}

class _ViewDataState extends State<ViewData> {
  StudentDetails myClass;
  CollectionReference? dataBase;
  CollectionReference? oldDatabase;

  _ViewDataState(this.myClass);

  setValues() async {
    dataBase = FirebaseFirestore.instance
        .collection("StudentData")
        .doc(myClass.schoolUid)
        .collection('referredStudentscurr');
    oldDatabase = FirebaseFirestore.instance
        .collection("StudentData")
        .doc(myClass.schoolUid)
        .collection('referredStudentsold');
  }

  void initState() {
    super.initState();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 207, 201),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 164, 112, 90),
        title: Text(
          "${myClass.firstname} ${myClass.cls} ${myClass.sec}",
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
                  "First Name :- ${myClass.firstname}\nLast Name :- ${myClass.lastname}\n"),
              SizedBox(height: 5),
              Text("Class and Section :- ${myClass.cls} ${myClass.sec}"),
              SizedBox(height: 5),
              Text("Admission Number :- ${myClass.admNo}"),
              SizedBox(height: 5),
              Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        var data = await dataBase!.doc(myClass.deleteID).get();
                        oldDatabase!.add(data.data());
                        await dataBase!.doc(myClass.deleteID).delete();
                        Navigator.pop(context);
                      },
                      child: Text("Resolved"))),
              SizedBox(
                height: 10,
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
              // Expanded(
              //   child: ListView.builder(
              //       itemCount: 3,
              //       itemBuilder: ((context, index) {
              //         return Container(
              //           padding: EdgeInsets.symmetric(vertical: 10),
              //           foregroundDecoration: BoxDecoration(
              //             border: Border.all(
              //               width: 2,
              //             ),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Text("${index + 1}"),
              //               VerticalDivider(
              //                 indent: 1,
              //                 endIndent: 20,
              //                 width: 20,
              //                 thickness: 4,
              //                 color: Colors.amber,
              //               ),
              //               Container(
              //                 child: Wrap(
              //                   children: [Text("\n")],
              //                 ),
              //               ),
              //               VerticalDivider(
              //                 width: 5,
              //                 thickness: 4,
              //               ),
              //               Container(
              //                 child: Wrap(
              //                   children: [Text("Emoji")],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         );
              //       })),
              // )
            ],
          ),
        ),
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
    var x = await FirebaseFirestore.instance
        .collection('StudentData')
        .doc("${myClass.schoolUid}")
        .collection("StudentData")
        .doc('${myClass.admNo}_${myClass.firstname}_${myClass.lastname}')
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
