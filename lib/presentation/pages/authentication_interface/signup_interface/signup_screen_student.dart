import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../domain/usecases/signup_usecase.dart';
import '../../../components/MyFacebookButton.dart';
import '../../../components/MyGoogleButton.dart';
import '../signin_interface/login_screen.dart';
import 'bloc/signup_bloc.dart';

class SignupStudent extends StatefulWidget {
  const SignupStudent({Key? key}) : super(key: key);

  @override
  State<SignupStudent> createState() => _SignupStudentState();
}

class _SignupStudentState extends State<SignupStudent> {
  String _dropDownValue = "Choose Gender";
  String _selectedOption = "Choose option";

  void initState() {
    // TODO: implement initState
    BlocProvider.of<SignupBloc>(context).add(
        EmptyFieldEvent(signUpUseCase.studentNameController.text,"-", signUpUseCase.studentEmailController.text,signUpUseCase.studentPasswordController.text, signUpUseCase.studentConfirmPasswordController.text, signUpUseCase.studentInstitutionNameController.text, _dropDownValue, "-", signUpUseCase.studentGradeLevelController.text));
  }

  SignUpUseCase signUpUseCase = SignUpUseCase();
  List<String> _selectedOptions = [];
  final List<String> _options = ['Male', 'Female'];
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
                        controller: signUpUseCase.studentNameController,
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
                        controller: signUpUseCase.studentEmailController,
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
                            controller: signUpUseCase.studentPasswordController,
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
                            controller: signUpUseCase.studentConfirmPasswordController,
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
                            controller: signUpUseCase.studentInstitutionNameController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],

                            decoration: InputDecoration(
                                hintText: 'Institution Name',
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
                                  _dropDownValue = val!;
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
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            controller: signUpUseCase.studentGradeLevelController,
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
                            BlocBuilder<SignupBloc, SignupState>(
  builder: (context, state) {
    return ElevatedButton(onPressed: () {
                              BlocProvider.of<SignupBloc>(context).add(EmptyFieldEvent(signUpUseCase.studentNameController.text,"-", signUpUseCase.studentEmailController.text,signUpUseCase.studentPasswordController.text, signUpUseCase.studentConfirmPasswordController.text, signUpUseCase.studentInstitutionNameController.text, _dropDownValue, "-", signUpUseCase.studentGradeLevelController.text));
                              state is SignupValidState ? signUpUseCase.createStudentAccount(context,_selectedOption) : '';
                              state is SignupValidState ?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyLogin())): '';

    },
                              child: state is SignupInvalidState ? Text('FILL IN ALL FIELDS!') :Text('SIGNUP'),
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
