class StudentData {
  final String firstname;
  final String lastname;
  final String rollNo;
  final String Class;
  final String section;
  final String admissionNo;
  final String uid;
  final String schoolUid;

  StudentData({
    required this.firstname,
    required this.lastname,
    required this.rollNo,
    required this.Class,
    required this.section,
    required this.admissionNo,
    required this.uid,
    required this.schoolUid,
  });

  static StudentData fromJson(Map<String, dynamic> json) => StudentData(
      firstname: json['firstname'],
      lastname: json['lastname'],
      rollNo: json['rollNo'],
      Class: json['Class'],
      section: json['section'],
      admissionNo: json['admissionNo'],
      uid: json["adduid"],
      schoolUid: json["schoolUid"]);
}

class StudentBehaviour {
  final String behaviour;
  final String behaviourState;
  final String date;

  StudentBehaviour({
    required this.behaviour,
    required this.behaviourState,
    required this.date,
  });
  static StudentBehaviour fromJson(Map<String, dynamic> json) =>
      StudentBehaviour(
        behaviour: json['behaviour'],
        behaviourState: json['behaviourState'],
        date: json['date'],
      );
}
