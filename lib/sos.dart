//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// import 'home.dart';

class Sos extends StatefulWidget {
  const Sos() : super();

  @override
  _SosState createState() => _SosState();
}

class _SosState extends State<Sos> {
  @override
  void initState() {
    super.initState();
    //_navigatetohome();
  }

  @override
  Widget build(BuildContext context) {
    //return Container();
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
          Image.asset('assets/images/sos_circle.png',
              fit: BoxFit.contain, height: 60),
          Padding(
            padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
            child: Text(
              "Are any of your students having suicidal thoughts?",
              style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 20.0,
                  color: new Color(0xffa4705a)),
            ),
          ),
          Text("Please contact SUICIDE HELPLINE NUMBER",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 20.0,
                  color: new Color(0xffa4705a))),
          Text("AASRA - We're Here To Help",
              style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 20.0,
                  color: new Color(0xffa4705a))),
          // TextButton(
          //     onPressed: () {
          //       _callNumber('tel:+919820466726');
          //     },
          //     //    (){setState(() {
          //     //  _makePhoneCall('919820466726');
          //     //  });},
          //     child: Text(
          //       "91-9820466726",
          //       style: TextStyle(
          //           fontFamily: 'Century Gothic',
          //           fontSize: 24.0,
          //           color: new Color(0xffa4705a),
          //           fontWeight: FontWeight.bold),
          //     )),
          //     ElevatedButton(
          //   onPressed: _callNumber,
          //   child: Text('Call Number'),
          // ),

          Container(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 200),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 167, 124, 108),
                      shadowColor: Colors.brown,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  onPressed:
                      // launchUrl("tel:123456789");
                      // FlutterPhoneDirectCaller.callNumber("7224806422");
                      _callNumber,
                  child: Text('Call Now')),
            ),
          ),

          //Text("91-9820466726", style:  TextStyle(fontFamily: 'Century Gothic', fontSize: 24.0,color:  new Color(0xffa4705a), fontWeight: FontWeight.bold),),
          Text(
            "Hours: 24 Hours, 7 days a week",
            style: TextStyle(
                fontFamily: 'Century Gothic',
                fontSize: 20.0,
                color: new Color(0xffa4705a)),
          ),
          Text(
            "Languages: English, Hindi",
            style: TextStyle(
                fontFamily: 'Century Gothic',
                fontSize: 20.0,
                color: new Color(0xffa4705a)),
          ),
          Padding(
              padding: EdgeInsets.all(30),
              child: Image.asset('assets/images/masti.png', height: 130))

          //Text("breathe in",style: TextStyle(fontFamily: 'Century Gothic', fontSize: 22.0,fontWeight: FontWeight.bold)),
          //Text("breathe out", style: TextStyle(fontFamily: 'Century Gothic', fontSize: 22.0)),
        ])));
  }

  // _callNumber(String url) async {
  //   //const number = '919820466726'; //set the number here
  //   //bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  //   // ignore: deprecated_member_use
  //   if (await canLaunch(url)) {
  //     //  await launchUrl();
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}

_callNumber() async {
  const number = '9820466726'; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}
