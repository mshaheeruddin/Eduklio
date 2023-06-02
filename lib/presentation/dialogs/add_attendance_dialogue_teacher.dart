import 'dart:developer';

import 'package:eduklio/presentation/pages/teacher_interface/bloc/bottombar_homescreen_bloc/text_field_announce_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/class_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/entities/class.dart';
import '../../domain/usecases/manageclass_usecase.dart';
import '../../domain/usecases/signin_usecase.dart';
import 'bloc/add_attendance_bloc/add_attendance_bloc.dart';
import 'class_dialog.dart';

class AddAttendanceDialogue extends StatefulWidget {
  final ClassManager classManager;
  String studentName = "";
  String studentId = "";

  AddAttendanceDialogue(this.classManager,this.studentName, this.studentId);

  @override
  _AddAttendanceDialogueState createState() => _AddAttendanceDialogueState();
}

class _AddAttendanceDialogueState extends State<AddAttendanceDialogue> {
  final TextEditingController _DurationOfClass = TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  late final TextEditingController _dateController= TextEditingController();

  /*TextEditingController(text: _dateTime.day.toString() + " " +
  _monthFormatter(_dateTime.month) + " " +
  _dateTime.year.toString());*/
  SignInUseCase signInUseCase = SignInUseCase();

  @override
  void dispose() {
    _DurationOfClass.dispose();
    _studentNameController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddAttendanceBloc>(context).add(EmptyFieldEvent(_DurationOfClass.text, _studentNameController.text, _dateController.text));

  }

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();
    ClassRepository classRepository = ClassRepository();

    return AlertDialog(
      title: Text('Add Attendance'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (_) {
            },
            controller: _DurationOfClass,
            decoration: InputDecoration(
              labelText: 'Duration Of Class',
            ),
          ),
          TextField(
            controller: _studentNameController,
            decoration: InputDecoration(
              labelText: 'Student Name',
            ),
          ),
          SizedBox(height: 20,),
          Stack(
              children: [

                BlocBuilder<AddAttendanceBloc, AddAttendanceState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: state is DateFieldPopulatedState ? getUpdatedDate() : _dateController,
                      //TextEditingController(text: _dateTime.day.toString() + " " +
                      //_monthFormatter(_dateTime.month) + " " + _dateTime.year.toString()),
                      decoration: InputDecoration(
                        labelText: 'Date class conducted',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, top: 8),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: _showDatePicker,
                  ),
                ),
              ]
          ),
        ],
      ),
      actions: [
        BlocBuilder<AddAttendanceBloc, AddAttendanceState>(
          builder: (context, state) {
            return TextButton(
              onPressed:(state is EmptyTextFieldState) ? null : () {

                String className = _DurationOfClass.text;
                String studentName = _studentNameController.text;
                if (className.isNotEmpty && studentName.isNotEmpty) {
                  Class newClass = Class(
                      className: className, classCode: studentName);
                  setState(() {
                    widget.classManager.addClass(newClass);
                  });



                 classRepository.addAttendance(
                      className,widget.studentName,widget.studentId,getUpdatedDate().text);
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: Text('Add'),
            );
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }


  //Month formatter
  String _monthFormatter(int month) {
    switch (month) {
      case 1:
        return "Jan";
        break;
      case 2:
        return "Feb";
        break;
      case 3:
        return "Mar";
        break;
      case 4:
        return "Apr";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "Jun";
        break;
      case 7:
        return "Jul";
        break;
      case 8:
        return "Aug";
        break;
      case 9:
        return "Sep";
        break;
      case 10:
        return "Oct";
        break;
      case 11:
        return "Nov";
        break;
      case 12:
        return "Dec";
        break;
      default:
        return "Invalid month";
        break;
    }
  }

  TextEditingController getUpdatedDate() {
    return TextEditingController(text: _dateTime.day.toString() + " " +
        _monthFormatter(_dateTime.month) + " " +
        _dateTime.year.toString());
  }


  String? dueOn;
  DateTime _dateTime = DateTime.now();

  Future<void> _showDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(2023, 12, 31),
    ).then((value) {

        _dateTime = value!;
        dueOn = _dateTime.day.toString() + " " +
            _monthFormatter(_dateTime.month) + " " +
            _dateTime.year.toString();
        BlocProvider.of<AddAttendanceBloc>(context).add(DateSelectedEvent(dueOn!));

    });

  }
}