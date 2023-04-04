
import 'dart:developer';



import 'package:flutter/cupertino.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../domain/usecases/signin_usecase.dart';
import '../../domain/usecases/signin_usecase.dart';
import '../components/MyFacebookButton.dart';
import '../components/MyGoogleButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/usecases/signin_usecase.dart';

import 'home_screen.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}


class _MyLoginState extends State<MyLogin> {
  final colorWhite = Color(0xFFFFFFFF);
  SignInUseCase signInUseCase = SignInUseCase();


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.png'), fit: BoxFit.cover,
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.12),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body:Stack (
            children: [
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.42,
                  right: 35,
                  left:35),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TextField(

                        controller: signInUseCase.emailController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50)
                        ],
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.black?.withOpacity(0.8),
                          )

                        ),
                      ),
                      SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            controller: signInUseCase.passwordController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Colors.black?.withOpacity(0.8),
                                )

                            ),
                          ),
                          Gap(30),
                          Text(

                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Superclarendon',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black
                                  : Colors.black,
                            ),
                          ),
                        ],
                      )
                      ,
                      Gap(23),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () {
                               signInUseCase.login(context);
                          },

                              child: Text('LOGIN'),
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
                                  47, 79, 79, 1.0)),

                            ),

                          ),

                        ],

                      ),
                      Row(
                        children: [
                          Expanded(child: Divider(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.black
                                : Colors.black,
                            height: 50,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          )),
                          Text(
                              "OR CONNECT WITH",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.black
                                      : Colors.black
                              )
                          ),
                          Expanded(child: Divider(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.black
                                : Colors.black,
                            height: 50,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyFacebookButton(),
                              Gap(1),
                              MyGoogleButton()
                            ],
                          ),
                        ],
                      )

                    ]
                    ,
                  ),
                ),

              ),
            ],

          ),
        ),
      ),
    );
  }
}
