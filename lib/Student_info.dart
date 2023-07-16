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

   late List<StudentData> students;
   List<StudentData> sortedStudents = [];
  int? sortColumnIndex;
   bool IsAscending = false;



  @override
  void initState() {
    super.initState();
     sortColumnIndex = null;
     IsAscending =false;
  }

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
             students = snapshot.data!;
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

    if (sortColumnIndex != null) {
      sortedStudents = List.from(students);
      sortedStudents.sort((student1, student2) {
        switch (sortColumnIndex) {
          case 0:
            return compareString(
                IsAscending, student1.admissionNo, student2.admissionNo);
          case 1:
            return compareString(
                IsAscending, student1.firstname, student2.firstname);
          case 2:
            return compareString(
                IsAscending, student1.lastname, student2.lastname);
          case 3:
            return compareString(IsAscending, student1.Class, student2.Class);
          case 4:
            return compareString(
                IsAscending, student1.section, student2.section);
          default:
            return 0;
        }
      });
    }


    return ScrollableWidget(
        child: DataTable(

          sortAscending: IsAscending,
          sortColumnIndex: sortColumnIndex,
          columns: getColumns(columns),
          // rows: getRows(students),
          rows: getRows(sortColumnIndex != null ? sortedStudents : students),
          border: TableBorder.all(),
    ));
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(
          label: Text(column),
           onSort : onSortColumn,
      ))
          .toList();

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


  void onSortColumn(int columnIndex, bool ascending) {
    if (students != null) {
      setState(() {
        if (sortColumnIndex == columnIndex) {
          IsAscending = !IsAscending;
        } else {
          sortColumnIndex = columnIndex;
          IsAscending = ascending;
        }

        students.sort((student1, student2) {
          switch (columnIndex) {
            case 0:
              return compareString(
                  IsAscending, student1.admissionNo, student2.admissionNo);
            case 1:
              return compareString(
                  IsAscending, student1.firstname, student2.firstname);
            case 2:
              return compareString(
                  IsAscending, student1.lastname, student2.lastname);
            case 3:
              return compareString(IsAscending, student1.Class, student2.Class);
            case 4:
              return compareString(
                  IsAscending, student1.section, student2.section);
            default:
              return 0;
          }
        });
      });
    }
  }





  int compareString(bool ascending, String value1, String value2) {
    final int1 = convertRomanToInteger(value1);
    final int2 = convertRomanToInteger(value2);

    if (int1 != null && int2 != null) {
      return ascending ? int1.compareTo(int2) : int2.compareTo(int1);
    }

    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }


  int? convertRomanToInteger(String romanNumeral) {
    final Map<String, int> romanToInteger = {
      'I': 1,
      'II': 2,
      'III': 3,
      'IV': 4,
      'V': 5,
      'VI': 6,
      'VII': 7,
      'VIII': 8,
      'IX': 9,
      'X': 10,
      'XI': 11,
      'XII': 12
    };

    return romanToInteger[romanNumeral];
  }

}

