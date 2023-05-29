import 'package:eduklio/data/repositories/class_repository.dart';
import 'package:eduklio/data/repositories/general_repository.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/domain/usecases/manage_student_class_usecase.dart';
import 'package:eduklio/domain/usecases/signin_usecase.dart';
import 'package:eduklio/presentation/widgets/futurebuilder_userid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/class.dart';
import '../../domain/usecases/manageclass_usecase.dart';

class ClassDialogEnroll extends StatefulWidget {
  final ClassManagerStudent classManager;


  ClassDialogEnroll({required this.classManager});

  @override
  _ClassDialogEnrollState createState() => _ClassDialogEnrollState();
}

class _ClassDialogEnrollState extends State<ClassDialogEnroll> {
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _classCodeController = TextEditingController();
  SignInUseCase signInUseCase = SignInUseCase();

  @override
  void dispose() {
    _classNameController.dispose();
    _classCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    UserRepository userRepository = UserRepository();
    ClassRepository classRepository = ClassRepository();

    return AlertDialog(
      title: Text('Add Class'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _classNameController,
            decoration: InputDecoration(
              labelText: 'Class Name',
            ),
          ),
          TextField(
            controller: _classCodeController,
            decoration: InputDecoration(
              labelText: 'Class Code',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            String className = _classNameController.text;
            String classCode = _classCodeController.text;
            if (className.isNotEmpty && classCode.isNotEmpty) {
              Class newClass = Class(className: className, classCode: classCode);
              setState(() {
                widget.classManager.addClass(newClass);
              });
              classRepository.addClass(className,classCode, userRepository.getUserUID());
              Navigator.pop(context); // Close the dialog
            }
          },
          child: Text('Add'),
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
}