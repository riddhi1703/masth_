import 'package:Masth_GURU/Ind_Student_info.dart';
import 'package:Masth_GURU/login_page.dart';
import 'package:Masth_GURU/viewdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TherapistPage extends StatefulWidget {
  const TherapistPage({Key? key}) : super(key: key);

  @override
  State<TherapistPage> createState() => _TherapistPageState();
}

class StudentDetails {
  StudentDetails(this.firstname, this.lastname, this.cls, this.sec, this.admNo,
      this.deleteID, this.schoolUid);
  String firstname;
  String lastname;
  String cls;
  String sec;
  String admNo;
  String deleteID;
  String schoolUid;
}

class _TherapistPageState extends State<TherapistPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  CollectionReference? dataBase;
  CollectionReference? oldDatabase;
  late QuerySnapshot<Object?> oldData;
  late QuerySnapshot<Object?> data;
  int index = 0;
  String schoolUid = "";

  setValues() async {
    user = auth.currentUser;
    if (schoolUid == "") {
      var school = await FirebaseFirestore.instance
          .collection("Teachers")
          .doc("${user!.uid}")
          .get();
      schoolUid = school.data()!["schooluid"];
    }
    dataBase = FirebaseFirestore.instance
        .collection("StudentData")
        .doc(schoolUid)
        .collection('referredStudentscurr');
    oldDatabase = FirebaseFirestore.instance
        .collection("StudentData")
        .doc(schoolUid)
        .collection('referredStudentsold');
  }

  void initState() {
    super.initState();
    setValues();
  }

  Widget historyStudents() {
    return Column(children: [
      Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            "Previous Students",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
      FutureBuilder<List<MapEntry<int, QueryDocumentSnapshot<Object?>>>?>(
          future: gethistoryStudents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var mapEntries = snapshot.data;
              if (mapEntries!.isEmpty) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text("No history present"),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: mapEntries.length,
                    itemBuilder: ((context, index) {
                      var listData = mapEntries[index].value.data()
                          as Map<String, dynamic>;
                      return ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(
                            listData["firstname"] + " " + listData["lastname"]),
                        trailing: Text("Resolved"),
                      );
                    }));
              }
            } else if (snapshot.hasError) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Text("No history present"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })
    ]);
  }

  Widget mycurrstudents() {
    return Column(children: [
      Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            "Referred Students",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
      FutureBuilder<List<MapEntry<int, QueryDocumentSnapshot<Object?>>>?>(
          future: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var mapEntries = snapshot.data;
              if (mapEntries!.isEmpty) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "No Students referred at this time. Please come back later."),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: mapEntries.length,
                    itemBuilder: ((context, index) {
                      var listData = mapEntries[index].value.data()
                          as Map<String, dynamic>;
                      int listKey = mapEntries[index].key;
                      return ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(
                            listData["firstname"] + " " + listData["lastname"]),
                        trailing: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(250, 164, 112, 90)),
                          ),
                          onPressed: () {
                            var details = StudentDetails(
                              listData["firstname"],
                              listData["lastname"],
                              listData["class"],
                              listData["section"],
                              listData["admNo"],
                              data.docs.elementAt(listKey).id,
                              listData["schoolUid"],
                            );
                            Navigator.of(context, rootNavigator: true)
                                .push<void>(CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => ViewData(details),
                            ));
                          },
                          child: Text("Data"),
                        ),
                      );
                    }));
              }
            } else if (snapshot.hasError) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Text(
                    "No Students referred at this time. Please come back later."),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })
    ]);
  }

  Future<List<MapEntry<int, QueryDocumentSnapshot<Object?>>>?>
      getStudents() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (dataBase != null) {
      data = await dataBase!.get();
      var mapEntries = data.docs.asMap().entries.toList();
      return mapEntries;
    } else {
      return null;
    }
  }

  Future<List<MapEntry<int, QueryDocumentSnapshot<Object?>>>?>
      gethistoryStudents() async {
    if (oldDatabase != null) {
      oldData = await oldDatabase!.get();
      var mapEntries = oldData.docs.asMap().entries.toList();
      print(mapEntries);
      return mapEntries;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 207, 201),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 164, 112, 90),
        leading: Container(
          width: 50,
          padding: EdgeInsets.all(2),
          child: Image.asset(
            "assets/images/masti.png",
            height: 60,
          ),
        ),
        title: Text("Therapist"),
        actions: [
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.brown[400])),
              label: Text("Logout"),
              onPressed: () async {
                try {
                  await auth.signOut();
                } catch (e) {
                  //
                }
                try {
                  await googleSignIn.signOut();
                } catch (e) {
                  //
                }
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: index == 0 ? mycurrstudents() : historyStudents(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (inx) {
          setState(() {
            index = inx;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Pending",
            icon: Icon(Icons.today_outlined),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History")
        ],
      ),
    ));
  }
}
