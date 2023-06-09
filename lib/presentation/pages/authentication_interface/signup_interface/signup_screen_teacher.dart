import 'package:eduklio/domain/usecases/signup_usecase.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/login_screen.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/bloc/signup_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../components/MyFacebookButton.dart';
import '../../../components/MyGoogleButton.dart';

class SignupTeacher extends StatefulWidget {
    SignupTeacher({Key? key}) : super(key: key);


  @override
  State<SignupTeacher> createState() => _SignupTeacherState();

}

class _SignupTeacherState extends State<SignupTeacher> {


  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<SignupBloc>(context).add(
        EmptyFieldEvent(signUpUseCase.fNameController.text,signUpUseCase.fNameController.text, signUpUseCase.emailController.text,signUpUseCase.passwordController.text, signUpUseCase.confirmPasswordController.text, signUpUseCase.schoolNameController.text, "male", signUpUseCase.teachingExperienceController.text, signUpUseCase.qualificationController.text));
  }

  SignUpUseCase signUpUseCase = SignUpUseCase();
  //List<String> _selectedOptions = [];
  //final List<DropdownMenu> _options = ['Male', 'Female'];
  String _selectedOption = "Choose option";


  String _dropDownValue = "Choose Gender";

  String getGender() {
    return _dropDownValue;
  }

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
                    'assets/svgs/teacher_logo.svg',
                    width: 170,
                    height: 170,
                  ),
                  Text(
                    "Teacher Signup",
                    style: GoogleFonts.acme(fontSize: 30),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28,
                    right: 35,
                    left:30),
                child:  Padding(
                  padding:  EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //Full Name
                      TextField(

                        controller: signUpUseCase.fNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                            hintStyle: TextStyle(
                              color: Colors.black?.withOpacity(0.8),
                            )
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextField(
                        controller: signUpUseCase.lNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(
                              color: Colors.black?.withOpacity(0.8),
                            )
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextField(
                        controller: signUpUseCase.emailController,
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
                            controller: signUpUseCase.passwordController,
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
                            controller: signUpUseCase.confirmPasswordController,
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
                            controller: signUpUseCase.schoolNameController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            decoration: InputDecoration(
                                hintText: 'School Name',
                                hintStyle: TextStyle(
                                  color: Colors.black?.withOpacity(0.8),
                                )

                            ),
                          ),
                  BlocBuilder<SignupBloc, SignupState>(
  builder: (context, state) {
    return DropdownButton(
                    hint: state is GenderShowingState ? Text(state.gender, style: TextStyle(color: Colors.blue)) : Text('Choose Gender', style: TextStyle(color: Colors.blue),),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.blue),
                    items: ['Male', 'Female'].map(
                          (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onTap: () {
                      /*BlocProvider.of<SignupBloc>(context).add(
                          GenderSelectedEvent(_selectedOption));*/
                    },
                    onChanged: (val) {
                      BlocProvider.of<SignupBloc>(context).add(
                          GenderSelectedEvent(val!));
                    /*  setState(
                            () {
                          _dropDownValue = val!;

                        }
                        ,
                      );
*/                     
                     signUpUseCase.setGender(_dropDownValue);
                    },
                  );
  },
),

/*
                          DropdownButtonFormField<String>(
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
                            hint: Text('Select an option'),
                            decoration: InputDecoration(
                                labelText: 'Gender'
                            ))*/
                            TextField(
                              controller: signUpUseCase.teachingExperienceController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            decoration: InputDecoration(
                                hintText: 'Year(s) of teaching experience',
                                hintStyle: TextStyle(
                                  color: Colors.black?.withOpacity(0.8),
                                )

                            ),
                          ),
                          TextField(
                            onChanged: (val) {

                            },
                            controller: signUpUseCase.qualificationController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            decoration: InputDecoration(
                                hintText: 'Qualification',
                                hintStyle: TextStyle(
                                  color: Colors.black?.withOpacity(0.8),
                                )

                            ),
                          ),
                        ],
                      )
                      ,
                      SizedBox(height: 0,),
                      Padding(
                        padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.05 ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<SignupBloc, SignupState>(
  builder: (context, state) {
    return ElevatedButton(onPressed: state is SignupInvalidState ? null : () {
              BlocProvider.of<SignupBloc>(context).add(EmptyFieldEvent(signUpUseCase.fNameController.text,signUpUseCase.fNameController.text, signUpUseCase.emailController.text,signUpUseCase.passwordController.text, signUpUseCase.confirmPasswordController.text, signUpUseCase.schoolNameController.text, "male", signUpUseCase.teachingExperienceController.text, signUpUseCase.qualificationController.text));

                                  state is SignupValidState ? signUpUseCase.createTeacherAccount(context, _selectedOption) : '';
                                  state is SignupValidState ?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyLogin())): '';
                            },

                              child: Text('SIGNUP'),
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(326, 50)), // change the width and height as required
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0), // change the value of the radius as required
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(
                                    47, 79, 79, 1.0)),

                              ),

                            );
  },
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
