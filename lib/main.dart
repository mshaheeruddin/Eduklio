
import 'package:eduklio/presentation/dialogs/bloc/add_attendance_bloc/add_attendance_bloc.dart';
import 'package:eduklio/presentation/pages/animated.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/bloc/signin_bloc.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/bloc/signup_bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/dp_bloc/dp_bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/enroll_bloc/enroll_bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/movement_bloc/movement_bloc.dart';
import 'package:eduklio/presentation/pages/teacher_interface/bloc/bottombar_homescreen_bloc/text_field_announce_bloc.dart';
import 'package:eduklio/presentation/pages/teacher_interface/widgets/bloc/student_attendance_tile_bloc/student_attendance_tiles_bloc.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/login_screen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/teacher_homescreen.dart';
import 'package:eduklio/presentation/pages/welcome_interface/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return MultiBlocProvider(
      providers: [

        BlocProvider<TextFieldAnnounceBloc>(
          create: (context) => TextFieldAnnounceBloc(),
        ),
        BlocProvider<EnrollBloc> (
          create: (context) => EnrollBloc(),
        ),
        BlocProvider<MovementBloc> (
          create: (context) => MovementBloc(),
        ),
        BlocProvider<AddAttendanceBloc> (
          create: (context) => AddAttendanceBloc(),
        ),
        BlocProvider<StudentAttendanceTilesBloc> (
          create: (context) => StudentAttendanceTilesBloc(),
        ),
        BlocProvider<SignupBloc> (
          create: (context) => SignupBloc(),
        ),
        BlocProvider<SigninBloc>(
          create: (context) => SigninBloc(),
        ),
        BlocProvider<DpBloc>(
          create: (context) => DpBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Eduklio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        //Basic User Persistence
        home: WelcomeScreen(),
      ),
    );
  }
}

//      home: (FirebaseAuth.instance.currentUser != null) ? TeacherHomeScreen() : WelcomeScreen(),