import 'package:Masth_GURU/firebase_options.dart';
import 'package:Masth_GURU/login_page.dart';
import 'package:Masth_GURU/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Masth_GURU/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MASTHGuru());
}

class MASTHGuru extends StatefulWidget {
  @override
  State<MASTHGuru> createState() => _MASTHGuruState();
}

class _MASTHGuruState extends State<MASTHGuru> {
  secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_FULLSCREEN);
  }

  @override
  void initState() {
    super.initState();
    secureScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Splash(),
        // MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
      },
    );
  }
}

// class Datatabl extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => TabBarWidget(
//         title: 'Data Table',
//         tabs: [
//           Tab(icon: Icon(Icons.sort_by_alpha), text: 'Sortable'),
//           Tab(icon: Icon(Icons.select_all), text: 'Selectable'),
//           Tab(icon: Icon(Icons.edit), text: 'Editable'),
//         ],
//         children: [
//           Container(),
//           DataTableDemoState(),
//           Container(),
//         ],
//       );
// }
