
import 'package:flutter/cupertino.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'MyFacebookButton.dart';
import 'MyGoogleButton.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final colorWhite = Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.png'), fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Stack (
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 0, top: 150),
              child: Icon(
                Icons.headphones,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : colorWhite ,
                size: 50,

              ),

            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.42,
                right: 35,
                left:35),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'EMAIL',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Superclarendon',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.blue,
                      ),

                    ),
                    TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50)
                      ],
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.grey[300]?.withOpacity(0.9),
                        )

                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'PASSWORD',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Superclarendon',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.blue,
                      ),

                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20)
                          ],
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.grey[300]?.withOpacity(0.9),
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
                                : Colors.blue,
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
                          print('pressed!');
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
                                : MaterialStateProperty.all(Colors.blue),

                          ),

                        ),

                      ],

                    ),
                    Row(
                      children: [
                        Expanded(child: Divider(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.grey,
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
                                : Colors.grey
                          )
                        ),
                        Expanded(child: Divider(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.grey,
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
    );
  }
}
