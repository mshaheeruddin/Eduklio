import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/bloc/signin_bloc.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/login_screen.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_as_screen.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_screen_teacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'EIcon.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isPlay = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Set a delay to transition from firstChild to secondChild after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isPlay = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Welcome
            SizedBox(height: 60),
            Text(
              'Welcome to  \n  Eduklio',
              style: GoogleFonts.acme(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            // Icon as SVG
            AnimatedCrossFade(
              firstChild: SvgPicture.asset(
                'assets/svgs/E.svg',
                semanticsLabel: 'E Icon',
              ),
              secondChild: SvgPicture.asset(
                'assets/svgs/E_with_cap.svg',
                semanticsLabel: 'E Icon',
              ),
              crossFadeState: _isPlay
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(seconds: 1),
            ),
            Spacer(),
            // Signup button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupAs()),
                );
              },
              child: Text('Signup'),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(326, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? MaterialStateProperty.all(Colors.black)
                    : MaterialStateProperty.all(Color.fromRGBO(47, 79, 79, 1.0)),
              ),
            ),
            SizedBox(height: 20,),
            // Login button
            BlocProvider(
  create: (context) => SigninBloc(),
  child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyLogin()),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(326, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? MaterialStateProperty.all(Colors.black)
                    : MaterialStateProperty.all(Color.fromRGBO(119, 136, 153, 1.0)),
              ),
            ),
),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
