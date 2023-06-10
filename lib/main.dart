import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:materi_firebase/view/contact.dart';
import 'package:materi_firebase/view/register.dart';
import 'package:materi_firebase/view/login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //intial firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/login': (context) => Login(),
      },
    );
  }
}
