// //import 'dart:js';
//
// import 'package:Masth_GURU/Student_info.dart';
// import 'package:Masth_GURU/table.dart';
// import 'package:flutter/material.dart';
// //import 'package:material_floating_search_bar/material_floating_search_bar.dart';
// //import 'package:google_nav_bar/google_nav_bar.dart';
//
// import 'sos.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp() : super();
//
//   static const String _title = 'SOS';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: _title,
//       // ignore: unnecessary_new
//       theme: new ThemeData(
//           scaffoldBackgroundColor: Color.fromRGBO(249, 239, 238, 1)),
//       home: const Scaffold(
//         // appBar: AppBar(title: const Text(_title)),
//         body: MyStatefulWidget(),
//       ),
//     );
//   }
// }
//
// // @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     // This is handled by the search bar itself.
// //     resizeToAvoidBottomInset: false,
// //     body: Stack(
// //       fit: StackFit.expand,
// //       children: [
// //         buildMap(),
// //         buildBottomNavigationBar(),
// //         buildFloatingSearchBar(),
// //       ],
// //     ),
// //   );
// // }
//
// // buildMap() {}
//
// // buildBottomNavigationBar() {}
//
// // Widget buildFloatingSearchBar() {
// //   final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
//
// //   return FloatingSearchBar(
// //     hint: 'Search...',
// //     scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
// //     transitionDuration: const Duration(milliseconds: 800),
// //     transitionCurve: Curves.easeInOut,
// //     physics: const BouncingScrollPhysics(),
// //     //axisAlignment: isPortrait ? 0.0 : -1.0,
// //     openAxisAlignment: 0.0,
// //     //width: isPortrait ? 600 : 500,
// //     debounceDelay: const Duration(milliseconds: 500),
// //     onQueryChanged: (query) {
// //       // Call your model, bloc, controller here.
// //     },
// //     // Specify a custom transition to be used for
// //     // animating between opened and closed stated.
// //     transition: CircularFloatingSearchBarTransition(),
// //     actions: [
// //       FloatingSearchBarAction(
// //         showIfOpened: false,
// //         child: CircularButton(
// //           icon: const Icon(Icons.place),
// //           onPressed: () {},
// //         ),
// //       ),
// //       FloatingSearchBarAction.searchToClear(
// //         showIfClosed: false,
// //       ),
// //     ],
// //     builder: (context, transition) {
// //       return ClipRRect(
// //         borderRadius: BorderRadius.circular(8),
// //         child: Material(
// //           color: Colors.white,
// //           elevation: 4.0,
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: Colors.accents.map((color) {
// //               return Container(height: 112, color: color);
// //             }).toList(),
// //           ),
// //         ),
// //       );
// //     },
// //   );
// // }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget() : super();
//
//   String get title => '';
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController TextController = TextEditingController();
//   TextEditingController RollnoController = TextEditingController();
//   //DateTime _myDateTime = DateTime.now();
//   String time = '?';
//
// // get class => null;
//
// // get extends => null;
//
// // var class;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: ListView(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.fromLTRB(320, 1, 0, 0),
//             child: IconButton(
//               //onPressed: () {
//               //  Navigator.push(context, MaterialPageRoute(builder: (_) => Sos()));
//               //  },
//               onPressed: () {
//                 // Navigator.of(context, rootNavigator: true)
//                 //     .push<void>(PageRoute(
//                 //   //title: SettingsTab.title,
//                 //   fullscreenDialog: true,
//                 //   builder: (context) => const Sos(),
//                 // ));
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Sos()),
//                 );
//               },
//               iconSize: 60,
//               icon: Padding(
//                 padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
//                 child: Image.asset(
//                   'assets/images/sos_circle.png',
//
//                   height: 150,
//                   width: 150,
//                   //fit: ,
//                 ),
//               ),
//             ),
//           ),
//           // Container(
//           //     alignment: Alignment.centerRight,
//           //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//           //     child: const Text(
//           //       'SOS',
//           //       style: TextStyle(
//           //           color: Color.fromRGBO(164, 112, 90, 1),
//           //           fontFamily: 'Century Gothic',
//           //           fontWeight: FontWeight.w500,
//           //           fontSize: 18),
//           //     )),
//           Row(children: [
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.fromLTRB(10, 1, 10, 10),
//               child: Image.asset('assets/images/masti.png', scale: 10),
//             ),
//             // Container(
//             //     alignment: Alignment.centerRight,
//             //     padding: const EdgeInsets.fromLTRB(50, 0, 10, 10),
//             //     child: const Text(
//             //       'Masth Guru',
//             //       style: TextStyle(
//             //           color: Color.fromRGBO(164, 112, 90, 1),
//             //           fontFamily: 'Century Gothic',
//             //           fontWeight: FontWeight.w500,
//             //           fontSize: 30),
//             //     ))
//           ]),
//           Container(
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
//               child: const Text(
//                 'Name of the student',
//                 style: TextStyle(
//                     color: Color.fromRGBO(164, 112, 90, 1),
//                     fontFamily: 'Century Gothic',
//                     fontWeight: FontWeight.w500,
//                     fontSize: 22),
//               )),
//           Container(
//             margin: EdgeInsets.only(top: 25, left: 25, right: 25),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Flexible(
//                       flex: 1,
//                       child: TextField(
//                         cursorColor: Colors.grey,
//                         decoration: InputDecoration(
//                             fillColor: Colors.white,
//                             filled: true,
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide.none),
//                             hintText: 'Search',
//                             hintStyle:
//                                 TextStyle(color: Colors.grey, fontSize: 18),
//                             prefixIcon: Container(
//                               padding: EdgeInsets.all(15),
//                               child: Image.asset('assets/images/search.png'),
//                               width: 18,
//                             )),
//                       ),
//                     ),
//                     // Container(
//                     //     margin: EdgeInsets.only(left: 10),
//                     //     padding: EdgeInsets.all(15),
//                     //     decoration: BoxDecoration(
//                     //         color: Theme.of(context).primaryColor,
//                     //         borderRadius: BorderRadius.circular(15)),
//                     //     //child: Image.asset('assets/images/.png'),
//                     //     width: 25),
//                   ],
//                 )
//               ],
//             ),
//           ),
//
//           Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
//               child: const Text(
//                 'OR',
//                 style: TextStyle(
//                     color: Color.fromRGBO(164, 112, 90, 1),
//                     fontFamily: 'Century Gothic',
//                     fontWeight: FontWeight.w500,
//                     fontSize: 22),
//               )),
//           Container(
//               height: 100,
//               padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Color.fromRGBO(121, 85, 72, 1),
//                   textStyle: TextStyle(fontFamily: 'Century Gothic'),
//                 ),
//                 child: const Text(
//                   'VIEW FULL DATA',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => StudentInfo()),
//                     // MaterialPageRoute(builder: (context) => SfDataGridDemo()),
//                   );
//                 },
//               )),
//         ],
//       ),
//     );
//   }
// }
