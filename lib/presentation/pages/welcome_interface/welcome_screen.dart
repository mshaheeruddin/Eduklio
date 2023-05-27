import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/login_screen.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_as_screen.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_screen_teacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this as TickerProvider,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          //Welcome
          SizedBox(height: 60),
          Text('Welcome to  \n  Eduklio',
          style: GoogleFonts.acme(color: Colors.black,decoration: TextDecoration.none, fontSize: 40, ),
            textAlign: TextAlign.center,

          ),
          //icon as svg
        /*AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: Container(
                width: 200.0,
                height: 200.0,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Eduklio',
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                ),
              ),
            );
          },),*/
          Spacer(),
          //signup button
          ElevatedButton(onPressed:  () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupAs()));
            },
                child: Text('Signup'),
                style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(326, 50)), // change the width and height as required
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0), // change the value of the radius as required
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? MaterialStateProperty.all(Colors.black)
              : MaterialStateProperty.all(Color.fromRGBO(47, 79, 79, 1.0)),

        ), ),
          SizedBox(height: 20,),
          //login button
          ElevatedButton(onPressed:  () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
          },
            child: Text('Login',
            style: TextStyle(
              color: Colors.white,
            ),),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(326, 50)), // change the width and height as required
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // change the value of the radius as required
                ),
              ),
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? MaterialStateProperty.all(Colors.black)
                  : MaterialStateProperty.all(Color.fromRGBO(
                  119, 136, 153, 1.0)),

            ), ),
          SizedBox(height: 20,),
        ],
      ),
      ),
    );
  }
}
