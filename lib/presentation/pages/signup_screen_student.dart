import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../components/MyFacebookButton.dart';
import '../components/MyGoogleButton.dart';

class SignupStudent extends StatefulWidget {
  const SignupStudent({Key? key}) : super(key: key);

  @override
  State<SignupStudent> createState() => _SignupStudentState();
}

class _SignupStudentState extends State<SignupStudent> {
  List<String> _selectedOptions = [];
  final List<String> _options = ['Math', 'English', 'Computer Science'];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(220, 220, 220, 1.0),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
        body:Stack (
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/student_logo.svg',
                    width: 170,
                    height: 170,
                  ),
                  Text(
                    "Student Signup",
                    style: GoogleFonts.acme(fontSize: 30),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3,
                    right: 35,
                    left:30),
                child:  Padding(
                  padding:  EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //Full Name
                      TextField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                            hintStyle: TextStyle(
                              color: Colors.black?.withOpacity(0.8),
                            )
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Colors.black?.withOpacity(0.8),
                            )

                        ),
                      ),
                      SizedBox(height: 5),
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
                                  color: Colors.black?.withOpacity(0.8),
                                )

                            ),
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  color: Colors.black?.withOpacity(0.8),
                                )

                            ),
                          ),
                          SizedBox(height: 5),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Institution Name',
                                hintStyle: TextStyle(
                                  color: Colors.black?.withOpacity(0.8),
                                )

                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: null,
                            items: _options.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: _selectedOptions.contains(option),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            _selectedOptions.add(option);
                                          } else {
                                            _selectedOptions.remove(option);
                                          }
                                        });
                                      },
                                    ),
                                    Text(option),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                            hint: Text('Select courses'),
                            decoration: InputDecoration(
                                labelText: 'Courses'
                            )),
                            TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Grade Level',
                                hintStyle: TextStyle(
                                  color: Colors.black?.withOpacity(0.8),
                                )

                            ),
                          ),
                        ],
                      )
                      ,
                      SizedBox(height: 40,),
                      Padding(
                        padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.05 ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: () {

                            },
                              child: Text('SIGNUP'),
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
                      ),

                    ]
                    ,
                  ),
                ),
              ),

            ),
          ],

        ),
      ),
    );
  }
}
