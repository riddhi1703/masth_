import 'package:Masth_GURU/home.dart';
import 'package:Masth_GURU/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Teacher extends StatefulWidget {
  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');

  @override
  void initState() {
    super.initState();
    users.doc(user?.uid).get().then((docSnap) {
      if (docSnap.data() != null &&
          docSnap['name'] != null &&
          docSnap['schoolName'] != null &&
          docSnap['city'] != null) {
        setState(() {
          nameController.text = docSnap['name'];
          schoolNameController.text = docSnap['schoolName'];
          cityController.text = docSnap['city'];
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavigationPage()),
        );
      } else {
        print('Teacher does not exists');
      }
    }).onError((error, stackTrace) {
      print('Error while fetching teacher details: ' + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 249, 239, 238),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Please help us more!',
                style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      showCursor: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: "Teacher Name",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(250, 164, 112, 90),
                          fontFamily: 'Century Gothic',
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        nameController.value = nameController.value.copyWith(
                            text: value,
                            selection: TextSelection.fromPosition(
                                TextPosition(offset: value.length)));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: schoolNameController,
                      showCursor: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: "School Name",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(250, 164, 112, 90),
                          fontFamily: 'Century Gothic',
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        // schoolNameController.text = value;
                        schoolNameController.value = schoolNameController.value
                            .copyWith(
                                text: value,
                                selection: TextSelection.fromPosition(
                                    TextPosition(offset: value.length)));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cityController,
                      showCursor: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: "Enter City",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(250, 164, 112, 90),
                          fontFamily: 'Century Gothic',
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        cityController.value = cityController.value.copyWith(
                            text: value,
                            selection: TextSelection.fromPosition(
                                TextPosition(offset: value.length)));
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 231, 215, 215)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ))),
                onPressed: () async {
                  print('saving user...');
                  users.doc(user?.uid).set({
                    'name': nameController.text,
                    'schoolName': schoolNameController.text,
                    'city': cityController.text,
                  }, SetOptions(merge: true)).then((value) {
                    print("Profile Updated");
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationPage()),
                    );
                  }).catchError(
                      (error) => print("Failed to update profile: $error"));
                },
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontFamily: 'Century Gothic',
                        fontSize: 16,
                        // color: Color.fromARGB(250, 164, 112, 90),
                        color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                  );
                },
                child: Text(
                  'skip',
                  style: TextStyle(fontFamily: 'Century Gothic'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
