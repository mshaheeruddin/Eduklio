
import 'package:eduklio/presentation/pages/home_screen.dart';
import 'package:eduklio/presentation/pages/login_screen.dart';
import 'package:eduklio/presentation/pages/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eduklio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //Basic User Persistence
      home: (FirebaseAuth.instance.currentUser != null) ? HomeScreen() : WelcomeScreen(),
    );
  }
}

