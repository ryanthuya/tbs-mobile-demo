import 'package:flutter/material.dart';
import 'package:tbs_mobile_demo/models/student.dart';
import 'package:tbs_mobile_demo/screens/create.dart';
import 'package:tbs_mobile_demo/screens/details.dart';
import 'package:tbs_mobile_demo/screens/edit.dart';
import 'package:tbs_mobile_demo/screens/home.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}


late final Student student;
//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodayBookStore(DEMO)',
      initialRoute: '/',
        theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // home: const Home(),
      routes: {
        '/': (context) => const Home(),
        '/create': (context) => const Create(),
        '/edit': (context) => Edit(student:student),
      },
    );
  }
}